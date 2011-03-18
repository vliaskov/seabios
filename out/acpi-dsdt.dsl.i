DefinitionBlock (
    "acpi-dsdt.aml",
    "DSDT",
    0x01,
    "BXPC",
    "BXDSDT",
    0x1
    )
{
    Scope (\)
    {
        OperationRegion (DBG, SystemIO, 0x0402, 0x01)
        Field (DBG, ByteAcc, NoLock, Preserve)
        {
            DBGB, 8,
        }
        Method(DBUG, 1) {
            ToHexString(Arg0, Local0)
            ToBuffer(Local0, Local0)
            Subtract(SizeOf(Local0), 1, Local1)
            Store(Zero, Local2)
            While (LLess(Local2, Local1)) {
                Store(DerefOf(Index(Local0, Local2)), DBGB)
                Increment(Local2)
            }
            Store(0x0A, DBGB)
        }
    }
    Scope(\_SB) {
        Device(PCI0) {
            Name (_HID, EisaId ("PNP0A03"))
            Name (_ADR, 0x00)
            Name (_UID, 1)
            Name(_PRT, Package() {
               Package() { 0x0000ffff, 0, LNKD, 0 }, Package() { 0x0000ffff, 1, LNKA, 0 }, Package() { 0x0000ffff, 2, LNKB, 0 }, Package() { 0x0000ffff, 3, LNKC, 0 },
               Package() { 0x0001ffff, 0, LNKS, 0 },
               Package() { 0x0001ffff, 1, LNKB, 0 },
               Package() { 0x0001ffff, 2, LNKC, 0 },
               Package() { 0x0001ffff, 3, LNKD, 0 },
               Package() { 0x0002ffff, 0, LNKB, 0 }, Package() { 0x0002ffff, 1, LNKC, 0 }, Package() { 0x0002ffff, 2, LNKD, 0 }, Package() { 0x0002ffff, 3, LNKA, 0 },
               Package() { 0x0003ffff, 0, LNKC, 0 }, Package() { 0x0003ffff, 1, LNKD, 0 }, Package() { 0x0003ffff, 2, LNKA, 0 }, Package() { 0x0003ffff, 3, LNKB, 0 },
               Package() { 0x0004ffff, 0, LNKD, 0 }, Package() { 0x0004ffff, 1, LNKA, 0 }, Package() { 0x0004ffff, 2, LNKB, 0 }, Package() { 0x0004ffff, 3, LNKC, 0 },
               Package() { 0x0005ffff, 0, LNKA, 0 }, Package() { 0x0005ffff, 1, LNKB, 0 }, Package() { 0x0005ffff, 2, LNKC, 0 }, Package() { 0x0005ffff, 3, LNKD, 0 },
               Package() { 0x0006ffff, 0, LNKB, 0 }, Package() { 0x0006ffff, 1, LNKC, 0 }, Package() { 0x0006ffff, 2, LNKD, 0 }, Package() { 0x0006ffff, 3, LNKA, 0 },
               Package() { 0x0007ffff, 0, LNKC, 0 }, Package() { 0x0007ffff, 1, LNKD, 0 }, Package() { 0x0007ffff, 2, LNKA, 0 }, Package() { 0x0007ffff, 3, LNKB, 0 },
               Package() { 0x0008ffff, 0, LNKD, 0 }, Package() { 0x0008ffff, 1, LNKA, 0 }, Package() { 0x0008ffff, 2, LNKB, 0 }, Package() { 0x0008ffff, 3, LNKC, 0 },
               Package() { 0x0009ffff, 0, LNKA, 0 }, Package() { 0x0009ffff, 1, LNKB, 0 }, Package() { 0x0009ffff, 2, LNKC, 0 }, Package() { 0x0009ffff, 3, LNKD, 0 },
               Package() { 0x000affff, 0, LNKB, 0 }, Package() { 0x000affff, 1, LNKC, 0 }, Package() { 0x000affff, 2, LNKD, 0 }, Package() { 0x000affff, 3, LNKA, 0 },
               Package() { 0x000bffff, 0, LNKC, 0 }, Package() { 0x000bffff, 1, LNKD, 0 }, Package() { 0x000bffff, 2, LNKA, 0 }, Package() { 0x000bffff, 3, LNKB, 0 },
               Package() { 0x000cffff, 0, LNKD, 0 }, Package() { 0x000cffff, 1, LNKA, 0 }, Package() { 0x000cffff, 2, LNKB, 0 }, Package() { 0x000cffff, 3, LNKC, 0 },
               Package() { 0x000dffff, 0, LNKA, 0 }, Package() { 0x000dffff, 1, LNKB, 0 }, Package() { 0x000dffff, 2, LNKC, 0 }, Package() { 0x000dffff, 3, LNKD, 0 },
               Package() { 0x000effff, 0, LNKB, 0 }, Package() { 0x000effff, 1, LNKC, 0 }, Package() { 0x000effff, 2, LNKD, 0 }, Package() { 0x000effff, 3, LNKA, 0 },
               Package() { 0x000fffff, 0, LNKC, 0 }, Package() { 0x000fffff, 1, LNKD, 0 }, Package() { 0x000fffff, 2, LNKA, 0 }, Package() { 0x000fffff, 3, LNKB, 0 },
               Package() { 0x0010ffff, 0, LNKD, 0 }, Package() { 0x0010ffff, 1, LNKA, 0 }, Package() { 0x0010ffff, 2, LNKB, 0 }, Package() { 0x0010ffff, 3, LNKC, 0 },
               Package() { 0x0011ffff, 0, LNKA, 0 }, Package() { 0x0011ffff, 1, LNKB, 0 }, Package() { 0x0011ffff, 2, LNKC, 0 }, Package() { 0x0011ffff, 3, LNKD, 0 },
               Package() { 0x0012ffff, 0, LNKB, 0 }, Package() { 0x0012ffff, 1, LNKC, 0 }, Package() { 0x0012ffff, 2, LNKD, 0 }, Package() { 0x0012ffff, 3, LNKA, 0 },
               Package() { 0x0013ffff, 0, LNKC, 0 }, Package() { 0x0013ffff, 1, LNKD, 0 }, Package() { 0x0013ffff, 2, LNKA, 0 }, Package() { 0x0013ffff, 3, LNKB, 0 },
               Package() { 0x0014ffff, 0, LNKD, 0 }, Package() { 0x0014ffff, 1, LNKA, 0 }, Package() { 0x0014ffff, 2, LNKB, 0 }, Package() { 0x0014ffff, 3, LNKC, 0 },
               Package() { 0x0015ffff, 0, LNKA, 0 }, Package() { 0x0015ffff, 1, LNKB, 0 }, Package() { 0x0015ffff, 2, LNKC, 0 }, Package() { 0x0015ffff, 3, LNKD, 0 },
               Package() { 0x0016ffff, 0, LNKB, 0 }, Package() { 0x0016ffff, 1, LNKC, 0 }, Package() { 0x0016ffff, 2, LNKD, 0 }, Package() { 0x0016ffff, 3, LNKA, 0 },
               Package() { 0x0017ffff, 0, LNKC, 0 }, Package() { 0x0017ffff, 1, LNKD, 0 }, Package() { 0x0017ffff, 2, LNKA, 0 }, Package() { 0x0017ffff, 3, LNKB, 0 },
               Package() { 0x0018ffff, 0, LNKD, 0 }, Package() { 0x0018ffff, 1, LNKA, 0 }, Package() { 0x0018ffff, 2, LNKB, 0 }, Package() { 0x0018ffff, 3, LNKC, 0 },
               Package() { 0x0019ffff, 0, LNKA, 0 }, Package() { 0x0019ffff, 1, LNKB, 0 }, Package() { 0x0019ffff, 2, LNKC, 0 }, Package() { 0x0019ffff, 3, LNKD, 0 },
               Package() { 0x001affff, 0, LNKB, 0 }, Package() { 0x001affff, 1, LNKC, 0 }, Package() { 0x001affff, 2, LNKD, 0 }, Package() { 0x001affff, 3, LNKA, 0 },
               Package() { 0x001bffff, 0, LNKC, 0 }, Package() { 0x001bffff, 1, LNKD, 0 }, Package() { 0x001bffff, 2, LNKA, 0 }, Package() { 0x001bffff, 3, LNKB, 0 },
               Package() { 0x001cffff, 0, LNKD, 0 }, Package() { 0x001cffff, 1, LNKA, 0 }, Package() { 0x001cffff, 2, LNKB, 0 }, Package() { 0x001cffff, 3, LNKC, 0 },
               Package() { 0x001dffff, 0, LNKA, 0 }, Package() { 0x001dffff, 1, LNKB, 0 }, Package() { 0x001dffff, 2, LNKC, 0 }, Package() { 0x001dffff, 3, LNKD, 0 },
               Package() { 0x001effff, 0, LNKB, 0 }, Package() { 0x001effff, 1, LNKC, 0 }, Package() { 0x001effff, 2, LNKD, 0 }, Package() { 0x001effff, 3, LNKA, 0 },
               Package() { 0x001fffff, 0, LNKC, 0 }, Package() { 0x001fffff, 1, LNKD, 0 }, Package() { 0x001fffff, 2, LNKA, 0 }, Package() { 0x001fffff, 3, LNKB, 0 },
            })
            OperationRegion(PCST, SystemIO, 0xae00, 0x08)
            Field (PCST, DWordAcc, NoLock, WriteAsZeros)
            {
                PCIU, 32,
                PCID, 32,
            }
            OperationRegion(SEJ, SystemIO, 0xae08, 0x04)
            Field (SEJ, DWordAcc, NoLock, WriteAsZeros)
            {
                B0EJ, 32,
            }
     Device (S1) { Name (_ADR, 0x00010000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x0001), B0EJ) Return (0x0) } Name (_SUN, 1) }
     Device (S2) { Name (_ADR, 0x00020000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x0002), B0EJ) Return (0x0) } Name (_SUN, 2) }
     Device (S3) { Name (_ADR, 0x00030000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x0003), B0EJ) Return (0x0) } Name (_SUN, 3) }
     Device (S4) { Name (_ADR, 0x00040000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x0004), B0EJ) Return (0x0) } Name (_SUN, 4) }
     Device (S5) { Name (_ADR, 0x00050000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x0005), B0EJ) Return (0x0) } Name (_SUN, 5) }
     Device (S6) { Name (_ADR, 0x00060000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x0006), B0EJ) Return (0x0) } Name (_SUN, 6) }
     Device (S7) { Name (_ADR, 0x00070000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x0007), B0EJ) Return (0x0) } Name (_SUN, 7) }
     Device (S8) { Name (_ADR, 0x00080000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x0008), B0EJ) Return (0x0) } Name (_SUN, 8) }
     Device (S9) { Name (_ADR, 0x00090000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x0009), B0EJ) Return (0x0) } Name (_SUN, 9) }
     Device (S10) { Name (_ADR, 0x000a0000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x000a), B0EJ) Return (0x0) } Name (_SUN, 10) }
     Device (S11) { Name (_ADR, 0x000b0000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x000b), B0EJ) Return (0x0) } Name (_SUN, 11) }
     Device (S12) { Name (_ADR, 0x000c0000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x000c), B0EJ) Return (0x0) } Name (_SUN, 12) }
     Device (S13) { Name (_ADR, 0x000d0000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x000d), B0EJ) Return (0x0) } Name (_SUN, 13) }
     Device (S14) { Name (_ADR, 0x000e0000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x000e), B0EJ) Return (0x0) } Name (_SUN, 14) }
     Device (S15) { Name (_ADR, 0x000f0000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x000f), B0EJ) Return (0x0) } Name (_SUN, 15) }
     Device (S16) { Name (_ADR, 0x00100000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x0010), B0EJ) Return (0x0) } Name (_SUN, 16) }
     Device (S17) { Name (_ADR, 0x00110000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x0011), B0EJ) Return (0x0) } Name (_SUN, 17) }
     Device (S18) { Name (_ADR, 0x00120000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x0012), B0EJ) Return (0x0) } Name (_SUN, 18) }
     Device (S19) { Name (_ADR, 0x00130000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x0013), B0EJ) Return (0x0) } Name (_SUN, 19) }
     Device (S20) { Name (_ADR, 0x00140000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x0014), B0EJ) Return (0x0) } Name (_SUN, 20) }
     Device (S21) { Name (_ADR, 0x00150000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x0015), B0EJ) Return (0x0) } Name (_SUN, 21) }
     Device (S22) { Name (_ADR, 0x00160000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x0016), B0EJ) Return (0x0) } Name (_SUN, 22) }
     Device (S23) { Name (_ADR, 0x00170000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x0017), B0EJ) Return (0x0) } Name (_SUN, 23) }
     Device (S24) { Name (_ADR, 0x00180000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x0018), B0EJ) Return (0x0) } Name (_SUN, 24) }
     Device (S25) { Name (_ADR, 0x00190000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x0019), B0EJ) Return (0x0) } Name (_SUN, 25) }
     Device (S26) { Name (_ADR, 0x001a0000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x001a), B0EJ) Return (0x0) } Name (_SUN, 26) }
     Device (S27) { Name (_ADR, 0x001b0000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x001b), B0EJ) Return (0x0) } Name (_SUN, 27) }
     Device (S28) { Name (_ADR, 0x001c0000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x001c), B0EJ) Return (0x0) } Name (_SUN, 28) }
     Device (S29) { Name (_ADR, 0x001d0000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x001d), B0EJ) Return (0x0) } Name (_SUN, 29) }
     Device (S30) { Name (_ADR, 0x001e0000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x001e), B0EJ) Return (0x0) } Name (_SUN, 30) }
     Device (S31) { Name (_ADR, 0x001f0000) Method (_EJ0,1) { Store(ShiftLeft(1, 0x001f), B0EJ) Return (0x0) } Name (_SUN, 31) }
            Name (_CRS, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,
                    0x0000,
                    0x00FF,
                    0x0000,
                    0x0100,
                    ,, )
                IO (Decode16,
                    0x0CF8,
                    0x0CF8,
                    0x01,
                    0x08,
                    )
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,
                    0x0000,
                    0x0CF7,
                    0x0000,
                    0x0CF8,
                    ,, , TypeStatic)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,
                    0x0D00,
                    0xFFFF,
                    0x0000,
                    0xF300,
                    ,, , TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000A0000,
                    0x000BFFFF,
                    0x00000000,
                    0x00020000,
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,
                    0xE0000000,
                    0xFEBFFFFF,
                    0x00000000,
                    0x1EC00000,
                    ,, , AddressRangeMemory, TypeStatic)
            })
        }
        Device(HPET) {
            Name(_HID, EISAID("PNP0103"))
            Name(_UID, 0)
            Method (_STA, 0, NotSerialized) {
                    Return(0x0F)
            }
            Name(_CRS, ResourceTemplate() {
                DWordMemory(
                    ResourceConsumer, PosDecode, MinFixed, MaxFixed,
                    NonCacheable, ReadWrite,
                    0x00000000,
                    0xFED00000,
                    0xFED003FF,
                    0x00000000,
                    0x00000400
                )
            })
        }
    }
    Scope(\_SB.PCI0) {
        Device (VGA) {
                 Name (_ADR, 0x00020000)
                 Method (_S1D, 0, NotSerialized)
                 {
                         Return (0x00)
                 }
                 Method (_S2D, 0, NotSerialized)
                 {
                         Return (0x00)
                 }
                 Method (_S3D, 0, NotSerialized)
                 {
                         Return (0x00)
                 }
        }
        Device (ISA) {
            Name (_ADR, 0x00010000)
            OperationRegion (P40C, PCI_Config, 0x60, 0x04)
            Device (RTC)
            {
                Name (_HID, EisaId ("PNP0B00"))
                Name (_CRS, ResourceTemplate ()
                {
                    IO (Decode16, 0x0070, 0x0070, 0x10, 0x02)
                    IRQNoFlags () {8}
                    IO (Decode16, 0x0072, 0x0072, 0x02, 0x06)
                })
            }
            Device (KBD)
            {
                Name (_HID, EisaId ("PNP0303"))
                Method (_STA, 0, NotSerialized)
                {
                    Return (0x0f)
                }
                Method (_CRS, 0, NotSerialized)
                {
                     Name (TMP, ResourceTemplate ()
                     {
                    IO (Decode16,
                        0x0060,
                        0x0060,
                        0x01,
                        0x01,
                        )
                    IO (Decode16,
                        0x0064,
                        0x0064,
                        0x01,
                        0x01,
                        )
                    IRQNoFlags ()
                        {1}
                    })
                    Return (TMP)
                }
            }
            Device (MOU)
            {
                Name (_HID, EisaId ("PNP0F13"))
                Method (_STA, 0, NotSerialized)
                {
                    Return (0x0f)
                }
                Method (_CRS, 0, NotSerialized)
                {
                    Name (TMP, ResourceTemplate ()
                    {
                         IRQNoFlags () {12}
                    })
                    Return (TMP)
                }
            }
     Device (FDC0)
     {
         Name (_HID, EisaId ("PNP0700"))
  Method (_STA, 0, NotSerialized)
  {
      Return (0x0F)
  }
  Method (_CRS, 0, NotSerialized)
  {
      Name (BUF0, ResourceTemplate ()
                    {
                        IO (Decode16, 0x03F2, 0x03F2, 0x00, 0x04)
                        IO (Decode16, 0x03F7, 0x03F7, 0x00, 0x01)
                        IRQNoFlags () {6}
                        DMA (Compatibility, NotBusMaster, Transfer8) {2}
                    })
      Return (BUF0)
  }
     }
     Device (LPT)
     {
         Name (_HID, EisaId ("PNP0400"))
  Method (_STA, 0, NotSerialized)
  {
      Store (\_SB.PCI0.PX13.DRSA, Local0)
      And (Local0, 0x80000000, Local0)
      If (LEqual (Local0, 0))
      {
   Return (0x00)
      }
      Else
      {
   Return (0x0F)
      }
  }
  Method (_CRS, 0, NotSerialized)
  {
      Name (BUF0, ResourceTemplate ()
                    {
   IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
   IRQNoFlags () {7}
      })
      Return (BUF0)
  }
     }
     Device (COM1)
     {
         Name (_HID, EisaId ("PNP0501"))
  Name (_UID, 0x01)
  Method (_STA, 0, NotSerialized)
  {
      Store (\_SB.PCI0.PX13.DRSC, Local0)
      And (Local0, 0x08000000, Local0)
      If (LEqual (Local0, 0))
      {
   Return (0x00)
      }
      Else
      {
   Return (0x0F)
      }
  }
  Method (_CRS, 0, NotSerialized)
  {
      Name (BUF0, ResourceTemplate ()
                    {
   IO (Decode16, 0x03F8, 0x03F8, 0x00, 0x08)
                 IRQNoFlags () {4}
      })
      Return (BUF0)
  }
     }
     Device (COM2)
     {
         Name (_HID, EisaId ("PNP0501"))
  Name (_UID, 0x02)
  Method (_STA, 0, NotSerialized)
  {
      Store (\_SB.PCI0.PX13.DRSC, Local0)
      And (Local0, 0x80000000, Local0)
      If (LEqual (Local0, 0))
      {
   Return (0x00)
      }
      Else
      {
   Return (0x0F)
      }
  }
  Method (_CRS, 0, NotSerialized)
  {
      Name (BUF0, ResourceTemplate ()
                    {
   IO (Decode16, 0x02F8, 0x02F8, 0x00, 0x08)
                 IRQNoFlags () {3}
      })
      Return (BUF0)
  }
     }
        }
        Device (PX13) {
     Name (_ADR, 0x00010003)
     OperationRegion (P13C, PCI_Config, 0x5c, 0x24)
     Field (P13C, DWordAcc, NoLock, Preserve)
     {
  DRSA, 32,
  DRSB, 32,
  DRSC, 32,
  DRSE, 32,
  DRSF, 32,
  DRSG, 32,
  DRSH, 32,
  DRSI, 32,
  DRSJ, 32
     }
 }
    }
    Scope(\_SB) {
         Field (\_SB.PCI0.ISA.P40C, ByteAcc, NoLock, Preserve)
         {
             PRQ0, 8,
             PRQ1, 8,
             PRQ2, 8,
             PRQ3, 8
         }
        Device(LNKA){
                Name(_HID, EISAID("PNP0C0F"))
                Name(_UID, 1)
                Name(_PRS, ResourceTemplate(){
                    Interrupt (, Level, ActiveHigh, Shared)
                        { 5, 10, 11 }
                })
                Method (_STA, 0, NotSerialized)
                {
                    Store (0x0B, Local0)
                    If (And (0x80, PRQ0, Local1))
                    {
                         Store (0x09, Local0)
                    }
                    Return (Local0)
                }
                Method (_DIS, 0, NotSerialized)
                {
                    Or (PRQ0, 0x80, PRQ0)
                }
                Method (_CRS, 0, NotSerialized)
                {
                    Name (PRR0, ResourceTemplate ()
                    {
                        Interrupt (, Level, ActiveHigh, Shared)
                            {1}
                    })
                    CreateDWordField (PRR0, 0x05, TMP)
                    Store (PRQ0, Local0)
                    If (LLess (Local0, 0x80))
                    {
                        Store (Local0, TMP)
                    }
                    Else
                    {
                        Store (Zero, TMP)
                    }
                    Return (PRR0)
                }
                Method (_SRS, 1, NotSerialized)
                {
                    CreateDWordField (Arg0, 0x05, TMP)
                    Store (TMP, PRQ0)
                }
        }
        Device(LNKB){
                Name(_HID, EISAID("PNP0C0F"))
                Name(_UID, 2)
                Name(_PRS, ResourceTemplate(){
                    Interrupt (, Level, ActiveHigh, Shared)
                        { 5, 10, 11 }
                })
                Method (_STA, 0, NotSerialized)
                {
                    Store (0x0B, Local0)
                    If (And (0x80, PRQ1, Local1))
                    {
                         Store (0x09, Local0)
                    }
                    Return (Local0)
                }
                Method (_DIS, 0, NotSerialized)
                {
                    Or (PRQ1, 0x80, PRQ1)
                }
                Method (_CRS, 0, NotSerialized)
                {
                    Name (PRR0, ResourceTemplate ()
                    {
                        Interrupt (, Level, ActiveHigh, Shared)
                            {1}
                    })
                    CreateDWordField (PRR0, 0x05, TMP)
                    Store (PRQ1, Local0)
                    If (LLess (Local0, 0x80))
                    {
                        Store (Local0, TMP)
                    }
                    Else
                    {
                        Store (Zero, TMP)
                    }
                    Return (PRR0)
                }
                Method (_SRS, 1, NotSerialized)
                {
                    CreateDWordField (Arg0, 0x05, TMP)
                    Store (TMP, PRQ1)
                }
        }
        Device(LNKC){
                Name(_HID, EISAID("PNP0C0F"))
                Name(_UID, 3)
                Name(_PRS, ResourceTemplate(){
                    Interrupt (, Level, ActiveHigh, Shared)
                        { 5, 10, 11 }
                })
                Method (_STA, 0, NotSerialized)
                {
                    Store (0x0B, Local0)
                    If (And (0x80, PRQ2, Local1))
                    {
                         Store (0x09, Local0)
                    }
                    Return (Local0)
                }
                Method (_DIS, 0, NotSerialized)
                {
                    Or (PRQ2, 0x80, PRQ2)
                }
                Method (_CRS, 0, NotSerialized)
                {
                    Name (PRR0, ResourceTemplate ()
                    {
                        Interrupt (, Level, ActiveHigh, Shared)
                            {1}
                    })
                    CreateDWordField (PRR0, 0x05, TMP)
                    Store (PRQ2, Local0)
                    If (LLess (Local0, 0x80))
                    {
                        Store (Local0, TMP)
                    }
                    Else
                    {
                        Store (Zero, TMP)
                    }
                    Return (PRR0)
                }
                Method (_SRS, 1, NotSerialized)
                {
                    CreateDWordField (Arg0, 0x05, TMP)
                    Store (TMP, PRQ2)
                }
        }
        Device(LNKD){
                Name(_HID, EISAID("PNP0C0F"))
                Name(_UID, 4)
                Name(_PRS, ResourceTemplate(){
                    Interrupt (, Level, ActiveHigh, Shared)
                        { 5, 10, 11 }
                })
                Method (_STA, 0, NotSerialized)
                {
                    Store (0x0B, Local0)
                    If (And (0x80, PRQ3, Local1))
                    {
                         Store (0x09, Local0)
                    }
                    Return (Local0)
                }
                Method (_DIS, 0, NotSerialized)
                {
                    Or (PRQ3, 0x80, PRQ3)
                }
                Method (_CRS, 0, NotSerialized)
                {
                    Name (PRR0, ResourceTemplate ()
                    {
                        Interrupt (, Level, ActiveHigh, Shared)
                            {1}
                    })
                    CreateDWordField (PRR0, 0x05, TMP)
                    Store (PRQ3, Local0)
                    If (LLess (Local0, 0x80))
                    {
                        Store (Local0, TMP)
                    }
                    Else
                    {
                        Store (Zero, TMP)
                    }
                    Return (PRR0)
                }
                Method (_SRS, 1, NotSerialized)
                {
                    CreateDWordField (Arg0, 0x05, TMP)
                    Store (TMP, PRQ3)
                }
        }
        Device(LNKS){
                Name(_HID, EISAID("PNP0C0F"))
                Name(_UID, 5)
                Name(_PRS, ResourceTemplate(){
                    Interrupt (, Level, ActiveHigh, Shared)
                        { 9 }
                })
                Method (_STA, 0, NotSerialized)
                {
                    Store (0x0B, Local0)
                    If (And (0x80, PRQ0, Local1))
                    {
                         Store (0x09, Local0)
                    }
                    Return (Local0)
                }
                Method (_DIS, 0, NotSerialized)
                {
                    Or (PRQ0, 0x80, PRQ0)
                }
                Method (_CRS, 0, NotSerialized)
                {
                    Name (PRR0, ResourceTemplate ()
                    {
                        Interrupt (, Level, ActiveHigh, Shared)
                            {9}
                    })
                    CreateDWordField (PRR0, 0x05, TMP)
                    Store (PRQ0, Local0)
                    If (LLess (Local0, 0x80))
                    {
                        Store (Local0, TMP)
                    }
                    Else
                    {
                        Store (Zero, TMP)
                    }
                    Return (PRR0)
                }
        }
    }
    Name (\_S3, Package (0x04)
    {
        0x01,
        0x01,
        Zero,
        Zero
    })
    Name (\_S4, Package (0x04)
    {
        Zero,
        Zero,
        Zero,
        Zero
    })
    Name (\_S5, Package (0x04)
    {
        Zero,
        Zero,
        Zero,
        Zero
    })
    Scope(\_SB) {
        External(NTFY, MethodObj)
        External(CPON, PkgObj)
        Method (CPMA, 1, NotSerialized) {
            Store(DerefOf(Index(CPON, Arg0)), Local0)
            Store(Buffer(8) {0x00, 0x08, 0x00, 0x00, 0x00, 0, 0, 0}, Local1)
            Store(Arg0, Index(Local1, 2))
            Store(Arg0, Index(Local1, 3))
            Store(Local0, Index(Local1, 4))
            Return (Local1)
        }
        Method (CPST, 1, NotSerialized) {
            Store(DerefOf(Index(CPON, Arg0)), Local0)
            If (Local0) { Return(0xF) } Else { Return(0x0) }
        }
        Method (CPEJ, 2, NotSerialized) {
            Sleep(200)
        }
        OperationRegion(PRST, SystemIO, 0xaf00, 32)
        Field (PRST, ByteAcc, NoLock, Preserve)
        {
            PRS, 256
        }
        Method(PRSC, 0) {
            Store (PRS, Local5)
            Store (Zero, Local2)
            Store (Zero, Local0)
            While (LLess(Local0, SizeOf(CPON))) {
                Store(DerefOf(Index(CPON, Local0)), Local1)
                If (And(Local0, 0x07)) {
                    ShiftRight(Local2, 1, Local2)
                } Else {
                    Store(DerefOf(Index(Local5, ShiftRight(Local0, 3))), Local2)
                }
                Store(And(Local2, 1), Local3)
                If (LNotEqual(Local1, Local3)) {
                    Store(Local3, Index(CPON, Local0))
                    If (LEqual(Local3, 1)) {
                        NTFY(Local0, 1)
                    } Else {
                        NTFY(Local0, 3)
                    }
                }
                Increment(Local0)
            }
            Return(One)
        }
    }
    Scope (\_GPE)
    {
        Name(_HID, "ACPI0006")
        Method(_L00) {
            Return(0x01)
        }
        Method(_L01) {
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 1))) { Notify(\_SB.PCI0.S1, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 1))) { Notify(\_SB.PCI0.S1, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 2))) { Notify(\_SB.PCI0.S2, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 2))) { Notify(\_SB.PCI0.S2, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 3))) { Notify(\_SB.PCI0.S3, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 3))) { Notify(\_SB.PCI0.S3, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 4))) { Notify(\_SB.PCI0.S4, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 4))) { Notify(\_SB.PCI0.S4, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 5))) { Notify(\_SB.PCI0.S5, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 5))) { Notify(\_SB.PCI0.S5, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 6))) { Notify(\_SB.PCI0.S6, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 6))) { Notify(\_SB.PCI0.S6, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 7))) { Notify(\_SB.PCI0.S7, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 7))) { Notify(\_SB.PCI0.S7, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 8))) { Notify(\_SB.PCI0.S8, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 8))) { Notify(\_SB.PCI0.S8, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 9))) { Notify(\_SB.PCI0.S9, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 9))) { Notify(\_SB.PCI0.S9, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 10))) { Notify(\_SB.PCI0.S10, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 10))) { Notify(\_SB.PCI0.S10, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 11))) { Notify(\_SB.PCI0.S11, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 11))) { Notify(\_SB.PCI0.S11, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 12))) { Notify(\_SB.PCI0.S12, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 12))) { Notify(\_SB.PCI0.S12, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 13))) { Notify(\_SB.PCI0.S13, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 13))) { Notify(\_SB.PCI0.S13, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 14))) { Notify(\_SB.PCI0.S14, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 14))) { Notify(\_SB.PCI0.S14, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 15))) { Notify(\_SB.PCI0.S15, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 15))) { Notify(\_SB.PCI0.S15, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 16))) { Notify(\_SB.PCI0.S16, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 16))) { Notify(\_SB.PCI0.S16, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 17))) { Notify(\_SB.PCI0.S17, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 17))) { Notify(\_SB.PCI0.S17, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 18))) { Notify(\_SB.PCI0.S18, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 18))) { Notify(\_SB.PCI0.S18, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 19))) { Notify(\_SB.PCI0.S19, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 19))) { Notify(\_SB.PCI0.S19, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 20))) { Notify(\_SB.PCI0.S20, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 20))) { Notify(\_SB.PCI0.S20, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 21))) { Notify(\_SB.PCI0.S21, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 21))) { Notify(\_SB.PCI0.S21, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 22))) { Notify(\_SB.PCI0.S22, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 22))) { Notify(\_SB.PCI0.S22, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 23))) { Notify(\_SB.PCI0.S23, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 23))) { Notify(\_SB.PCI0.S23, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 24))) { Notify(\_SB.PCI0.S24, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 24))) { Notify(\_SB.PCI0.S24, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 25))) { Notify(\_SB.PCI0.S25, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 25))) { Notify(\_SB.PCI0.S25, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 26))) { Notify(\_SB.PCI0.S26, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 26))) { Notify(\_SB.PCI0.S26, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 27))) { Notify(\_SB.PCI0.S27, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 27))) { Notify(\_SB.PCI0.S27, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 28))) { Notify(\_SB.PCI0.S28, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 28))) { Notify(\_SB.PCI0.S28, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 29))) { Notify(\_SB.PCI0.S29, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 29))) { Notify(\_SB.PCI0.S29, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 30))) { Notify(\_SB.PCI0.S30, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 30))) { Notify(\_SB.PCI0.S30, 3) }
            If (And(\_SB.PCI0.PCIU, ShiftLeft(1, 31))) { Notify(\_SB.PCI0.S31, 1) } If (And(\_SB.PCI0.PCID, ShiftLeft(1, 31))) { Notify(\_SB.PCI0.S31, 3) }
            Return (0x01)
        }
        Method(_L02) {
            Return(\_SB.PRSC())
        }
        Method(_L03) {
            Return(0x01)
        }
        Method(_L04) {
            Return(0x01)
        }
        Method(_L05) {
            Return(0x01)
        }
        Method(_L06) {
            Return(0x01)
        }
        Method(_L07) {
            Return(0x01)
        }
        Method(_L08) {
            Return(0x01)
        }
        Method(_L09) {
            Return(0x01)
        }
        Method(_L0A) {
            Return(0x01)
        }
        Method(_L0B) {
            Return(0x01)
        }
        Method(_L0C) {
            Return(0x01)
        }
        Method(_L0D) {
            Return(0x01)
        }
        Method(_L0E) {
            Return(0x01)
        }
        Method(_L0F) {
            Return(0x01)
        }
    }
}
