# duo dmi

[Desktop Management Interface](https://en.wikipedia.org/wiki/Desktop_Management_Interface)

```
alex@duo > sudo dmidecode
[sudo] password for alex:
# dmidecode 3.5
Getting SMBIOS data from sysfs.
SMBIOS 3.1.1 present.
Table at 0x8F5C1000.

Handle 0x0000, DMI type 0, 26 bytes
BIOS Information
        Vendor: American Megatrends Inc.
        Version: P4.20
        Release Date: 10/31/2019
        Address: 0xF0000
        Runtime Size: 64 kB
        ROM Size: 16 MB
        Characteristics:
                PCI is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                Boot from CD is supported
                Selectable boot is supported
                BIOS ROM is socketed
                EDD is supported
                5.25"/1.2 MB floppy services are supported (int 13h)
                3.5"/720 kB floppy services are supported (int 13h)
                3.5"/2.88 MB floppy services are supported (int 13h)
                Print screen service is supported (int 5h)
                8042 keyboard services are supported (int 9h)
                Serial services are supported (int 14h)
                Printer services are supported (int 17h)
                ACPI is supported
                USB legacy is supported
                BIOS boot specification is supported
                Targeted content distribution is supported
                UEFI is supported
        BIOS Revision: 5.12

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: To Be Filled By O.E.M.
        Product Name: To Be Filled By O.E.M.
        Version: To Be Filled By O.E.M.
        Serial Number: To Be Filled By O.E.M.
        UUID: 66c28570-7df8-0000-0000-000000000000
        Wake-up Type: Power Switch
        SKU Number: To Be Filled By O.E.M.
        Family: To Be Filled By O.E.M.

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
        Manufacturer: ASRock
        Product Name: Z370M-ITX/ac
        Version:
        Serial Number: M80-AB007100110
        Asset Tag:
        Features:
                Board is a hosting board
                Board is replaceable
        Location In Chassis:
        Chassis Handle: 0x0003
        Type: Motherboard
        Contained Object Handles: 0

Handle 0x0003, DMI type 3, 22 bytes
Chassis Information
        Manufacturer: To Be Filled By O.E.M.
        Type: Desktop
        Lock: Not Present
        Version: To Be Filled By O.E.M.
        Serial Number: To Be Filled By O.E.M.
        Asset Tag: To Be Filled By O.E.M.
        Boot-up State: Safe
        Power Supply State: Safe
        Thermal State: Safe
        Security Status: None
        OEM Information: 0x00000000
        Height: Unspecified
        Number Of Power Cords: 1
        Contained Elements: 0
        SKU Number: To be filled by O.E.M.

Handle 0x0004, DMI type 9, 17 bytes
System Slot Information
        Designation: Slot1
        Type: x16 PCI Express
        Current Usage: In Use
        Length: Short
        ID: 17
        Characteristics:
                3.3 V is provided
                Opening is shared
                PME signal is supported
        Bus Address: 0000:01:00.0

Handle 0x0005, DMI type 9, 17 bytes
System Slot Information
        Designation: Slot2
        Type: x4 PCI Express
        Current Usage: In Use
        Length: Long
        ID: 33
        Characteristics:
                3.3 V is provided
                Opening is shared
                PME signal is supported
        Bus Address: 0000:05:00.0

Handle 0x0006, DMI type 9, 17 bytes
System Slot Information
        Designation: Slot3
        Type: x1 PCI Express
        Current Usage: Available
        Length: Long
        ID: 34
        Characteristics:
                3.3 V is provided
                Opening is shared
                PME signal is supported
        Bus Address: 0000:1c:00.6

Handle 0x0007, DMI type 11, 5 bytes
OEM Strings
        String 1: To Be Filled By O.E.M.

Handle 0x0008, DMI type 32, 20 bytes
System Boot Information
        Status: No errors detected

Handle 0x0009, DMI type 40, 14 bytes
Additional Information 1
        Referenced Handle: 0x00a1
        Referenced Offset: 0x01
        String: MORDOR
        Value: 0x00000000

Handle 0x000A, DMI type 16, 23 bytes
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: None
        Maximum Capacity: 32 GB
        Error Information Handle: Not Provided
        Number Of Devices: 2

Handle 0x000B, DMI type 17, 40 bytes
Memory Device
        Array Handle: 0x000A
        Error Information Handle: Not Provided
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 16 GB
        Form Factor: DIMM
        Set: None
        Locator: ChannelA-DIMM0
        Bank Locator: BANK 0
        Type: DDR4
        Type Detail: Synchronous Unbuffered (Unregistered)
        Speed: 3200 MT/s
        Manufacturer: 859B
        Serial Number: E8451922
        Asset Tag: 9876543210
        Part Number: CP16G4DFRA32A.C8FF
        Rank: 1
        Configured Memory Speed: 3200 MT/s
        Minimum Voltage: 1.2 V
        Maximum Voltage: 1.2 V
        Configured Voltage: 1.2 V

Handle 0x000C, DMI type 17, 40 bytes
Memory Device
        Array Handle: 0x000A
        Error Information Handle: Not Provided
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 16 GB
        Form Factor: DIMM
        Set: None
        Locator: ChannelB-DIMM0
        Bank Locator: BANK 2
        Type: DDR4
        Type Detail: Synchronous Unbuffered (Unregistered)
        Speed: 3200 MT/s
        Manufacturer: 859B
        Serial Number: E8450685
        Asset Tag: 9876543210
        Part Number: CP16G4DFRA32A.C8FF
        Rank: 1
        Configured Memory Speed: 3200 MT/s
        Minimum Voltage: 1.2 V
        Maximum Voltage: 1.2 V
        Configured Voltage: 1.2 V

Handle 0x000D, DMI type 19, 31 bytes
Memory Array Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x007FFFFFFFF
        Range Size: 32 GB
        Physical Array Handle: 0x000A
        Partition Width: 2

Handle 0x000E, DMI type 7, 27 bytes
Cache Information
        Socket Designation: L1 Cache
        Configuration: Enabled, Not Socketed, Level 1
        Operational Mode: Write Back
        Location: Internal
        Installed Size: 0 kB
        Maximum Size: 0 kB
        Supported SRAM Types:
                Synchronous
        Installed SRAM Type: Synchronous
        Speed: Unknown
        Error Correction Type: Parity
        System Type: Unified
        Associativity: 8-way Set-associative

Handle 0x000F, DMI type 7, 27 bytes
Cache Information
        Socket Designation: L2 Cache
        Configuration: Enabled, Not Socketed, Level 2
        Operational Mode: Write Back
        Location: Internal
        Installed Size: 0 kB
        Maximum Size: 0 kB
        Supported SRAM Types:
                Synchronous
        Installed SRAM Type: Synchronous
        Speed: Unknown
        Error Correction Type: Single-bit ECC
        System Type: Unified
        Associativity: 4-way Set-associative

Handle 0x0010, DMI type 7, 27 bytes
Cache Information
        Socket Designation: L3 Cache
        Configuration: Enabled, Not Socketed, Level 3
        Operational Mode: Write Back
        Location: Internal
        Installed Size: 0 kB
        Maximum Size: 0 kB
        Supported SRAM Types:
                Synchronous
        Installed SRAM Type: Synchronous
        Speed: Unknown
        Error Correction Type: Multi-bit ECC
        System Type: Unified
        Associativity: 12-way Set-associative

Handle 0x0011, DMI type 4, 48 bytes
Processor Information
        Socket Designation: CPUSocket
        Type: Central Processor
        Family: Core i5
        Manufacturer: Intel(R) Corporation
        ID: EA 06 09 00 FF FB EB BF
        Signature: Type 0, Family 6, Model 158, Stepping 10
        Flags:
                FPU (Floating-point unit on-chip)
                VME (Virtual mode extension)
                DE (Debugging extension)
                PSE (Page size extension)
                TSC (Time stamp counter)
                MSR (Model specific registers)
                PAE (Physical address extension)
                MCE (Machine check exception)
                CX8 (CMPXCHG8 instruction supported)
                APIC (On-chip APIC hardware supported)
                SEP (Fast system call)
                MTRR (Memory type range registers)
                PGE (Page global enable)
                MCA (Machine check architecture)
                CMOV (Conditional move instruction supported)
                PAT (Page attribute table)
                PSE-36 (36-bit page size extension)
                CLFSH (CLFLUSH instruction supported)
                DS (Debug store)
                ACPI (ACPI supported)
                MMX (MMX technology supported)
                FXSR (FXSAVE and FXSTOR instructions supported)
                SSE (Streaming SIMD extensions)
                SSE2 (Streaming SIMD extensions 2)
                SS (Self-snoop)
                HTT (Multi-threading)
                TM (Thermal monitor supported)
                PBE (Pending break enabled)
        Version: Intel(R) Core(TM) i5-9400 CPU @ 2.90GHz
        Voltage: 0.9 V
        External Clock: 100 MHz
        Max Speed: 8300 MHz
        Current Speed: 3200 MHz
        Status: Populated, Enabled
        Upgrade: Socket LGA1151
        L1 Cache Handle: 0x000E
        L2 Cache Handle: 0x000F
        L3 Cache Handle: 0x0010
        Serial Number: To Be Filled By O.E.M.
        Asset Tag: To Be Filled By O.E.M.
        Part Number: To Be Filled By O.E.M.
        Core Count: 6
        Core Enabled: 6
        Thread Count: 6
        Characteristics:
                64-bit capable
                Multi-Core
                Execute Protection
                Enhanced Virtualization
                Power/Performance Control

Handle 0x0012, DMI type 20, 35 bytes
Memory Device Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x003FFFFFFFF
        Range Size: 16 GB
        Physical Device Handle: 0x000B
        Memory Array Mapped Address Handle: 0x000D
        Partition Row Position: 1
        Interleave Position: 1
        Interleaved Data Depth: 1

Handle 0x0013, DMI type 20, 35 bytes
Memory Device Mapped Address
        Starting Address: 0x00400000000
        Ending Address: 0x007FFFFFFFF
        Range Size: 16 GB
        Physical Device Handle: 0x000C
        Memory Array Mapped Address Handle: 0x000D
        Partition Row Position: 1
        Interleave Position: 2
        Interleaved Data Depth: 1

Handle 0x0014, DMI type 130, 20 bytes
OEM-specific Type
        Header and Data:
                82 14 14 00 24 41 4D 54 00 00 00 00 00 A5 AF 02
                C0 00 00 00

Handle 0x0015, DMI type 131, 64 bytes
OEM-specific Type
        Header and Data:
                83 40 15 00 31 00 00 00 00 00 00 00 00 00 00 00
                F8 00 C9 A2 00 00 00 00 01 00 00 00 08 00 0B 00
                16 0E 41 00 00 00 00 00 FE 00 B8 15 00 00 00 00
                00 00 00 00 22 00 00 00 76 50 72 6F 00 00 00 00

Handle 0x0016, DMI type 221, 33 bytes
OEM-specific Type
        Header and Data:
                DD 21 16 00 04 01 00 03 06 03 00 00 02 00 00 00
                00 C6 00 03 00 00 05 00 00 00 04 00 FF FF FF FF
                FF
        Strings:
                Reference Code - CPU
                uCode Version
                TXT ACM Version
                BIOS Guard Version

Handle 0x0017, DMI type 221, 26 bytes
OEM-specific Type
        Header and Data:
                DD 1A 17 00 03 01 00 03 06 03 00 00 02 00 00 00
                00 00 00 03 04 0B 08 41 16 0E
        Strings:
                Reference Code - ME 11.0
                MEBx version
                ME Firmware Version
                Consumer SKU

Handle 0x0018, DMI type 221, 75 bytes
OEM-specific Type
        Header and Data:
                DD 4B 18 00 0A 01 00 03 06 03 00 00 02 03 FF FF
                FF FF FF 04 00 FF FF FF 00 00 05 00 FF FF FF 00
                00 06 00 FF FF FF FF FF 07 00 3E 00 00 00 00 08
                00 34 00 00 00 00 09 00 0B 00 00 00 00 0A 00 3E
                00 00 00 00 0B 00 34 00 00 00 00
        Strings:
                Reference Code - SKL PCH
                PCH-CRID Status
                Disabled
                PCH-CRID Original Value
                PCH-CRID New Value
                OPROM - RST - RAID
                SKL PCH H Bx Hsio Version
                SKL PCH H Dx Hsio Version
                KBL PCH H Ax Hsio Version
                SKL PCH LP Bx Hsio Version
                SKL PCH LP Cx Hsio Version

Handle 0x0019, DMI type 221, 54 bytes
OEM-specific Type
        Header and Data:
                DD 36 19 00 07 01 00 03 06 03 00 00 02 00 03 03
                00 00 00 03 00 03 06 03 00 00 04 05 FF FF FF FF
                FF 06 00 FF FF FF 07 00 07 00 FF FF FF 07 00 08
                00 FF FF FF FF FF
        Strings:
                Reference Code - SA - System Agent
                Reference Code - MRC
                SA - PCIe Version
                SA-CRID Status
                Disabled
                SA-CRID Original Value
                SA-CRID New Value
                OPROM - VBIOS

Handle 0x001A, DMI type 136, 6 bytes
OEM-specific Type
        Header and Data:
                88 06 1A 00 00 00

Handle 0x001B, DMI type 41, 11 bytes
Onboard Device
        Reference Designation: Onboard - Other
        Type: Other
        Status: Enabled
        Type Instance: 1
        Bus Address: 0000:00:00.0

Handle 0x001C, DMI type 41, 11 bytes
Onboard Device
        Reference Designation: Onboard - Other
        Type: Other
        Status: Enabled
        Type Instance: 2
        Bus Address: 0000:00:14.0

Handle 0x001D, DMI type 41, 11 bytes
Onboard Device
        Reference Designation: Onboard - Other
        Type: Other
        Status: Enabled
        Type Instance: 3
        Bus Address: 0000:00:14.2

Handle 0x001E, DMI type 41, 11 bytes
Onboard Device
        Reference Designation: Onboard - Other
        Type: Other
        Status: Enabled
        Type Instance: 4
        Bus Address: 0000:00:16.0

Handle 0x001F, DMI type 41, 11 bytes
Onboard Device
        Reference Designation: Onboard - SATA
        Type: SATA Controller
        Status: Enabled
        Type Instance: 1
        Bus Address: 0000:00:17.0

Handle 0x0020, DMI type 41, 11 bytes
Onboard Device
        Reference Designation: Onboard - Other
        Type: Other
        Status: Enabled
        Type Instance: 5
        Bus Address: 0000:00:1f.0

Handle 0x0021, DMI type 41, 11 bytes
Onboard Device
        Reference Designation: Onboard - Other
        Type: Other
        Status: Enabled
        Type Instance: 6
        Bus Address: 0000:00:1f.2

Handle 0x0022, DMI type 41, 11 bytes
Onboard Device
        Reference Designation: Onboard - Sound
        Type: Sound
        Status: Enabled
        Type Instance: 1
        Bus Address: 0000:00:1f.3

Handle 0x0023, DMI type 41, 11 bytes
Onboard Device
        Reference Designation: Onboard - Other
        Type: Other
        Status: Enabled
        Type Instance: 7
        Bus Address: 0000:00:1f.4

Handle 0x0024, DMI type 41, 11 bytes
Onboard Device
        Reference Designation: Onboard - Ethernet
        Type: Ethernet
        Status: Enabled
        Type Instance: 1
        Bus Address: 0000:00:1f.6

Handle 0x0025, DMI type 14, 8 bytes
Group Associations
        Name: $MEI
        Items: 1
                0x0000 (OEM-specific)

Handle 0x0026, DMI type 219, 81 bytes
OEM-specific Type
        Header and Data:
                DB 51 26 00 01 03 01 45 02 00 90 06 01 00 66 20
                00 00 00 04 40 08 00 00 00 00 00 00 00 00 40 02
                FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
                FF FF FF FF FF FF FF FF 03 00 00 00 80 00 00 00
                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                00
        Strings:
                MEI1
                MEI2
                MEI3

Handle 0x0027, DMI type 127, 4 bytes
End Of Table
```
