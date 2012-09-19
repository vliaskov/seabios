/* This file is the basis for the ssdt_mem[] variable in src/acpi.c.
 * It is similar in design to the ssdt_proc variable.
 * It defines the contents of the per-cpu Processor() object.  At
 * runtime, a dynamically generated SSDT will contain one copy of this
 * AML snippet for every possible memory device in the system.  The
 * objects will * be placed in the \_SB_ namespace.
 *
 * In addition to the aml code generated from this file, the
 * src/acpi.c file creates a MEMNTFY method with an entry for each memdevice:
 *     Method(MTFY, 2) {
 *         If (LEqual(Arg0, 0x00)) { Notify(MP00, Arg1) }
 *         If (LEqual(Arg0, 0x01)) { Notify(MP01, Arg1) }
 *         ...
 *     }
 * and a MEON array with the list of active and inactive memory devices:
 *     Name(MEON, Package() { One, One, ..., Zero, Zero, ... })
 */
ACPI_EXTRACT_ALL_CODE ssdm_mem_aml

DefinitionBlock ("ssdt-mem.aml", "SSDT", 0x02, "BXPC", "CSSDT", 0x1)
/*  v------------------ DO NOT EDIT ------------------v */
{
    ACPI_EXTRACT_DEVICE_START ssdt_mem_start
    ACPI_EXTRACT_DEVICE_END ssdt_mem_end
    ACPI_EXTRACT_DEVICE_STRING ssdt_mem_name
    Device(MPAA) {
        ACPI_EXTRACT_NAME_BYTE_CONST ssdt_mem_id
        Name(ID, 0xAA)
/*  ^------------------ DO NOT EDIT ------------------^
 *
 * The src/acpi.c code requires the above layout so that it can update
 * MPAA and 0xAA with the appropriate MEMDEVICE id (see
 * SD_OFFSET_MEMHEX/MEMID1/MEMID2).  Don't change the above without
 * also updating the C code.
 */
        Name(_HID, EISAID("PNP0C80"))
        Name(_PXM, 0xAA)

        External(CMST, MethodObj)
        External(MPEJ, MethodObj)
        External(MOST, MethodObj)

        Name(_CRS, ResourceTemplate() {
            QwordMemory(
               ResourceConsumer,
               ,
               MinFixed,
               MaxFixed,
               Cacheable,
               ReadWrite,
               0x0,
               0xDEADBEEF,
               0xE6ADBEEE,
               0x00000000,
               0x08000000,
               )
        })
        Method (_STA, 0) {
            Return(CMST(ID))        
        }    
        Method (_EJ0, 1, NotSerialized) {
            MPEJ(ID, Arg0)
        }
        Method (_OST, 3) {
            MOST(Arg0, Arg1, ID)
        }
    }
}    

