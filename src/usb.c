// Main code for handling USB controllers and devices.
//
// Copyright (C) 2009  Kevin O'Connor <kevin@koconnor.net>
//
// This file may be distributed under the terms of the GNU LGPLv3 license.

#include "util.h" // dprintf
#include "pci.h" // foreachpci
#include "config.h" // CONFIG_*
#include "pci_regs.h" // PCI_CLASS_REVISION
#include "pci_ids.h" // PCI_CLASS_SERIAL_USB_UHCI
#include "usb-uhci.h" // uhci_init
#include "usb-ohci.h" // ohci_init
#include "usb-hid.h" // usb_keyboard_setup
#include "usb-hub.h" // usb_hub_init
#include "usb-msc.h" // usb_msc_init
#include "usb.h" // struct usb_s
#include "biosvar.h" // GET_GLOBAL

struct usb_s USBControllers[16] VAR16VISIBLE;


/****************************************************************
 * Controller function wrappers
 ****************************************************************/

// Send a message on a control pipe using the default control descriptor.
static int
send_control(u32 endp, int dir, const void *cmd, int cmdsize
             , void *data, int datasize)
{
    struct usb_s *cntl = endp2cntl(endp);
    switch (cntl->type) {
    default:
    case USB_TYPE_UHCI:
        return uhci_control(endp, dir, cmd, cmdsize, data, datasize);
    case USB_TYPE_OHCI:
        return ohci_control(endp, dir, cmd, cmdsize, data, datasize);
    }
}

struct usb_pipe *
alloc_bulk_pipe(u32 endp)
{
    struct usb_s *cntl = endp2cntl(endp);
    switch (cntl->type) {
    default:
    case USB_TYPE_UHCI:
        return uhci_alloc_bulk_pipe(endp);
    case USB_TYPE_OHCI:
        return NULL;
    }
}

int
usb_send_bulk(struct usb_pipe *pipe, int dir, void *data, int datasize)
{
    u32 endp = GET_FLATPTR(pipe->endp);
    struct usb_s *cntl = endp2cntl(endp);
    switch (cntl->type) {
    default:
    case USB_TYPE_UHCI:
        return uhci_send_bulk(pipe, dir, data, datasize);
    case USB_TYPE_OHCI:
        return -1;
    }
}

struct usb_pipe *
alloc_intr_pipe(u32 endp, int period)
{
    struct usb_s *cntl = endp2cntl(endp);
    // Find the exponential period of the requested time.
    if (period <= 0)
        period = 1;
    int frameexp = __fls(period);
    switch (cntl->type) {
    default:
    case USB_TYPE_UHCI:
        return uhci_alloc_intr_pipe(endp, frameexp);
    case USB_TYPE_OHCI:
        return ohci_alloc_intr_pipe(endp, frameexp);
    }
}

int noinline
usb_poll_intr(struct usb_pipe *pipe, void *data)
{
    u32 endp = GET_FLATPTR(pipe->endp);
    struct usb_s *cntl = endp2cntl(endp);
    switch (GET_GLOBAL(cntl->type)) {
    default:
    case USB_TYPE_UHCI:
        return uhci_poll_intr(pipe, data);
    case USB_TYPE_OHCI:
        return ohci_poll_intr(pipe, data);
    }
}


/****************************************************************
 * Helper functions
 ****************************************************************/

// Find the first endpoing of a given type in an interface description.
struct usb_endpoint_descriptor *
findEndPointDesc(struct usb_interface_descriptor *iface, int imax
                 , int type, int dir)
{
    struct usb_endpoint_descriptor *epdesc = (void*)&iface[1];
    for (;;) {
        if ((void*)epdesc >= (void*)iface + imax
            || epdesc->bDescriptorType == USB_DT_INTERFACE) {
            return NULL;
        }
        if (epdesc->bDescriptorType == USB_DT_ENDPOINT
            && (epdesc->bEndpointAddress & USB_ENDPOINT_DIR_MASK) == dir
            && (epdesc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) == type)
            return epdesc;
        epdesc = (void*)epdesc + epdesc->bLength;
    }
}

// Build an encoded "endp" from an endpoint descriptor.
u32
mkendpFromDesc(u32 endp, struct usb_endpoint_descriptor *epdesc)
{
    return mkendp(endp2cntl(endp), endp2devaddr(endp)
                  , epdesc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK
                  , endp2speed(endp), epdesc->wMaxPacketSize);
}

// Send a message to the default control pipe of a device.
int
send_default_control(u32 endp, const struct usb_ctrlrequest *req, void *data)
{
    return send_control(endp, req->bRequestType & USB_DIR_IN
                        , req, sizeof(*req), data, req->wLength);
}

// Get the first 8 bytes of the device descriptor.
static int
get_device_info8(struct usb_device_descriptor *dinfo, u32 endp)
{
    struct usb_ctrlrequest req;
    req.bRequestType = USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_DEVICE;
    req.bRequest = USB_REQ_GET_DESCRIPTOR;
    req.wValue = USB_DT_DEVICE<<8;
    req.wIndex = 0;
    req.wLength = 8;
    return send_default_control(endp, &req, dinfo);
}

static struct usb_config_descriptor *
get_device_config(u32 endp)
{
    struct usb_config_descriptor cfg;

    struct usb_ctrlrequest req;
    req.bRequestType = USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_DEVICE;
    req.bRequest = USB_REQ_GET_DESCRIPTOR;
    req.wValue = USB_DT_CONFIG<<8;
    req.wIndex = 0;
    req.wLength = sizeof(cfg);
    int ret = send_default_control(endp, &req, &cfg);
    if (ret)
        return NULL;

    void *config = malloc_tmphigh(cfg.wTotalLength);
    if (!config)
        return NULL;
    req.wLength = cfg.wTotalLength;
    ret = send_default_control(endp, &req, config);
    if (ret)
        return NULL;
    //hexdump(config, cfg.wTotalLength);
    return config;
}

static u32
set_address(u32 endp)
{
    dprintf(3, "set_address %x\n", endp);
    struct usb_s *cntl = endp2cntl(endp);
    if (cntl->maxaddr >= USB_MAXADDR)
        return 0;

    struct usb_ctrlrequest req;
    req.bRequestType = USB_DIR_OUT | USB_TYPE_STANDARD | USB_RECIP_DEVICE;
    req.bRequest = USB_REQ_SET_ADDRESS;
    req.wValue = cntl->maxaddr + 1;
    req.wIndex = 0;
    req.wLength = 0;
    int ret = send_default_control(endp, &req, NULL);
    if (ret)
        return 0;
    msleep(USB_TIME_SETADDR_RECOVERY);

    cntl->maxaddr++;
    return mkendp(cntl, cntl->maxaddr, 0, endp2speed(endp), endp2maxsize(endp));
}

static int
set_configuration(u32 endp, u16 val)
{
    struct usb_ctrlrequest req;
    req.bRequestType = USB_DIR_OUT | USB_TYPE_STANDARD | USB_RECIP_DEVICE;
    req.bRequest = USB_REQ_SET_CONFIGURATION;
    req.wValue = val;
    req.wIndex = 0;
    req.wLength = 0;
    return send_default_control(endp, &req, NULL);
}


/****************************************************************
 * Initialization and enumeration
 ****************************************************************/

// Called for every found device - see if a driver is available for
// this device and do setup if so.
int
configure_usb_device(struct usb_s *cntl, int lowspeed)
{
    dprintf(3, "config_usb: %p %d\n", cntl, lowspeed);

    // Get device info
    u32 endp = mkendp(cntl, 0, 0, lowspeed, 8);
    struct usb_device_descriptor dinfo;
    int ret = get_device_info8(&dinfo, endp);
    if (ret)
        return 0;
    dprintf(3, "device rev=%04x cls=%02x sub=%02x proto=%02x size=%02x\n"
            , dinfo.bcdUSB, dinfo.bDeviceClass, dinfo.bDeviceSubClass
            , dinfo.bDeviceProtocol, dinfo.bMaxPacketSize0);
    if (dinfo.bMaxPacketSize0 < 8 || dinfo.bMaxPacketSize0 > 64)
        return 0;
    endp = mkendp(cntl, 0, 0, lowspeed, dinfo.bMaxPacketSize0);

    // Get configuration
    struct usb_config_descriptor *config = get_device_config(endp);
    if (!config)
        return 0;

    // Determine if a driver exists for this device - only look at the
    // first interface of the first configuration.
    struct usb_interface_descriptor *iface = (void*)(&config[1]);
    if ((iface->bInterfaceClass != USB_CLASS_HID
         || iface->bInterfaceSubClass != USB_INTERFACE_SUBCLASS_BOOT
         || iface->bInterfaceProtocol != USB_INTERFACE_PROTOCOL_KEYBOARD)
        && (iface->bInterfaceClass != USB_CLASS_MASS_STORAGE)
        && (iface->bInterfaceClass != USB_CLASS_HUB))
        // Not a supported device.
        goto fail;

    // Set the address and configure device.
    endp = set_address(endp);
    if (!endp)
        goto fail;
    ret = set_configuration(endp, config->bConfigurationValue);
    if (ret)
        goto fail;

    // Configure driver.
    if (iface->bInterfaceClass == USB_CLASS_HUB) {
        free(config);
        return usb_hub_init(endp);
    }
    int imax = (void*)config + config->wTotalLength - (void*)iface;
    if (iface->bInterfaceClass == USB_CLASS_MASS_STORAGE)
        ret = usb_msc_init(endp, iface, imax);
    else
        ret = usb_keyboard_init(endp, iface, imax);
    if (ret)
        goto fail;

    free(config);
    return 1;
fail:
    free(config);
    return 0;
}

void
usb_setup(void)
{
    ASSERT32FLAT();
    if (! CONFIG_USB)
        return;

    dprintf(3, "init usb\n");

    usb_keyboard_setup();

    // Look for USB controllers
    int count = 0;
    int bdf, max;
    foreachpci(bdf, max) {
        u32 code = pci_config_readl(bdf, PCI_CLASS_REVISION) >> 8;

        if (code >> 8 != PCI_CLASS_SERIAL_USB)
            continue;

        struct usb_s *cntl = &USBControllers[count];
        cntl->bdf = bdf;

        if (code == PCI_CLASS_SERIAL_USB_UHCI)
            run_thread(uhci_init, cntl);
        else if (code == PCI_CLASS_SERIAL_USB_OHCI)
            run_thread(ohci_init, cntl);
        else
            continue;

        count++;
        if (count >= ARRAY_SIZE(USBControllers))
            break;
    }
}
