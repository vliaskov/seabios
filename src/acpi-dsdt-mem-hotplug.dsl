/****************************************************************
 * Memory hotplug
 ****************************************************************/

Scope(\_SB) {
        /* Objects filled in by run-time generated SSDT */
        External(MTFY, MethodObj)
        External(MEON, PkgObj)

        Method (CMST, 1, NotSerialized) {
            // _STA method - return ON status of memdevice
            // Local0 = MEON flag for this cpu
            Store(DerefOf(Index(MEON, Arg0)), Local0)
            If (Local0) { Return(0xF) } Else { Return(0x0) }
        }

        /* Memory hotplug notify array */
        OperationRegion(MEST, SystemIO, 0xaf80, 32)
        Field (MEST, ByteAcc, NoLock, Preserve)
        {
            MES, 256
        }
 
        /* Memory eject byte */
        OperationRegion(MEMJ, SystemIO, 0xafa0, 1)
        Field (MEMJ, ByteAcc, NoLock, Preserve)
        {
            MPE, 8
        }

        /* Memory hot-remove notify failure byte */
        OperationRegion(MEEF, SystemIO, 0xafa1, 1)
        Field (MEEF, ByteAcc, NoLock, Preserve)
        {
            MEF, 8
        }

        /* Memory hot-add notify success byte */
        OperationRegion(MPIS, SystemIO, 0xafa2, 1)
        Field (MPIS, ByteAcc, NoLock, Preserve)
        {
            MIS, 8
        }

        /* Memory hot-add notify failure byte */
        OperationRegion(MPIF, SystemIO, 0xafa3, 1)
        Field (MPIF, ByteAcc, NoLock, Preserve)
        {
            MIF, 8
        }

        /* Memory _PS3 byte */
        OperationRegion(MPSB, SystemIO, 0xafa4, 1)
        Field (MPSB, ByteAcc, NoLock, Preserve)
        {
            MPS, 8
        }

        Method(MESC, 0) {
            // Local5 = active memdevice bitmap
            Store (MES, Local5)
            // Local2 = last read byte from bitmap
            Store (Zero, Local2)
            // Local0 = memory device iterator
            Store (Zero, Local0)
            While (LLess(Local0, SizeOf(MEON))) {
                // Local1 = MEON flag for this memory device
                Store(DerefOf(Index(MEON, Local0)), Local1)
                If (And(Local0, 0x07)) {
                    // Shift down previously read bitmap byte
                    ShiftRight(Local2, 1, Local2)
                } Else {
                    // Read next byte from memdevice bitmap
                    Store(DerefOf(Index(Local5, ShiftRight(Local0, 3))), Local2)
                }
                // Local3 = active state for this memory device
                Store(And(Local2, 1), Local3)

                If (LNotEqual(Local1, Local3)) {
                    // State change - update MEON with new state
                    Store(Local3, Index(MEON, Local0))
                    // Do MEM notify
                    If (LEqual(Local3, 1)) {
                        MTFY(Local0, 1)
                    } Else {
                        MTFY(Local0, 3)
                    }
                }
                Increment(Local0)
            }
            Return(One)
        }

        Method (MPEJ, 2, NotSerialized) {
            // _EJ0 method - eject callback
            Store(Arg0, MPE)
            Sleep(200)
        }


        Method (MPS3, 1, NotSerialized) {
            // _PS3 method - power-off method
            Store(Arg0, MPS)
            Store(Zero, Index(MEON, Arg0))
            Sleep(200)
        }

        Method (MOST, 3, Serialized) {
            // _OST method - OS status indication
            Switch (And(Arg0, 0xFF)) {
                Case(0x3)
                {
                    Switch(And(Arg1, 0xFF)) {
                        Case(0x1) {
                            Store(Arg2, MEF)
                            // Revert MEON flag for this memory device to one
                            Store(One, Index(MEON, Arg2))
                        }
                    }
                }
                Case(0x1)
                {
                    Switch(And(Arg1, 0xFF)) {
                        Case(0x0) {
                            Store(Arg2, MIS)
                        }
                        Case(0x1) {
                            Store(Arg2, MIF)
                            // Revert MEON flag for this memory device to zero
                            Store(Zero, Index(MEON, Arg2))
                        }
                    }
                }
            }
        }
}
