```
alex@p52 > sudo dmidecode
# dmidecode 3.5
Getting SMBIOS data from sysfs.
SMBIOS 3.1.1 present.
Table at 0x4D450000.

Handle 0x0000, DMI type 222, 14 bytes
OEM-specific Type
        Header and Data:
                DE 0E 00 00 01 99 00 03 10 01 20 02 30 03
        Strings:
                Memory Init Complete
                End of DXE Phase
                BIOS Boot Complete

Handle 0x0001, DMI type 14, 8 bytes
Group Associations
        Name: Intel(R) Silicon View Technology
        Items: 1
                0x0000 (OEM-specific)

Handle 0x0002, DMI type 16, 23 bytes
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: None
        Maximum Capacity: 64 GB
        Error Information Handle: Not Provided
        Number Of Devices: 4

Handle 0x0003, DMI type 17, 40 bytes
Memory Device
        Array Handle: 0x0002
        Error Information Handle: Not Provided
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 8 GB
        Form Factor: SODIMM
        Set: None
        Locator: ChannelA-DIMM0
        Bank Locator: BANK 0
        Type: DDR4
        Type Detail: Synchronous
        Speed: 2667 MT/s
        Manufacturer: Samsung
        Serial Number: 410C6036
        Asset Tag: None
        Part Number: M471A1K43CB1-CTD
        Rank: 1
        Configured Memory Speed: 2667 MT/s
        Minimum Voltage: Unknown
        Maximum Voltage: Unknown
        Configured Voltage: 1.2 V

Handle 0x0004, DMI type 17, 40 bytes
Memory Device
        Array Handle: 0x0002
        Error Information Handle: Not Provided
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 8 GB
        Form Factor: SODIMM
        Set: None
        Locator: ChannelA-DIMM1
        Bank Locator: BANK 1
        Type: DDR4
        Type Detail: Synchronous
        Speed: 2667 MT/s
        Manufacturer: Micron
        Serial Number: 212DCB8B
        Asset Tag: None
        Part Number: 8ATF1G64HZ-2G6E1
        Rank: 1
        Configured Memory Speed: 2667 MT/s
        Minimum Voltage: Unknown
        Maximum Voltage: Unknown
        Configured Voltage: 1.2 V

Handle 0x0005, DMI type 17, 40 bytes
Memory Device
        Array Handle: 0x0002
        Error Information Handle: Not Provided
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 8 GB
        Form Factor: SODIMM
        Set: None
        Locator: ChannelB-DIMM0
        Bank Locator: BANK 2
        Type: DDR4
        Type Detail: Synchronous
        Speed: 2667 MT/s
        Manufacturer: Samsung
        Serial Number: 410C60C6
        Asset Tag: None
        Part Number: M471A1K43CB1-CTD
        Rank: 1
        Configured Memory Speed: 2667 MT/s
        Minimum Voltage: Unknown
        Maximum Voltage: Unknown
        Configured Voltage: 1.2 V

Handle 0x0006, DMI type 17, 40 bytes
Memory Device
        Array Handle: 0x0002
        Error Information Handle: Not Provided
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 8 GB
        Form Factor: SODIMM
        Set: None
        Locator: ChannelB-DIMM1
        Bank Locator: BANK 3
        Type: DDR4
        Type Detail: Synchronous
        Speed: 2667 MT/s
        Manufacturer: Micron
        Serial Number: 1DFE21C7
        Asset Tag: None
        Part Number: 8ATF1G64HZ-2G6E1
        Rank: 1
        Configured Memory Speed: 2667 MT/s
        Minimum Voltage: Unknown
        Maximum Voltage: Unknown
        Configured Voltage: 1.2 V

Handle 0x0007, DMI type 19, 31 bytes
Memory Array Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x007FFFFFFFF
        Range Size: 32 GB
        Physical Array Handle: 0x0002
        Partition Width: 4

Handle 0x0008, DMI type 221, 12 bytes
OEM-specific Type
        Header and Data:
                DD 0C 08 00 01 01 00 02 00 00 BD 10
        Strings:
                BIOS Guard

Handle 0x0009, DMI type 221, 26 bytes
OEM-specific Type
        Header and Data:
                DD 1A 09 00 03 01 00 07 00 68 40 00 02 00 00 00
                00 F6 00 03 00 01 08 00 00 00
        Strings:
                Reference Code - CPU
                uCode Version
                TXT ACM version

Handle 0x000A, DMI type 221, 26 bytes
OEM-specific Type
        Header and Data:
                DD 1A 0A 00 03 01 00 07 00 68 40 00 02 00 0C 00
                00 0B 00 03 04 0C 00 5D 1B 09
        Strings:
                Reference Code - ME
                MEBx version
                ME Firmware Version
                Consumer SKU

Handle 0x000B, DMI type 221, 82 bytes
OEM-specific Type
        Header and Data:
                DD 52 0B 00 0B 01 00 07 00 68 40 00 02 03 FF FF
                FF FF FF 04 00 FF FF FF 10 00 05 00 FF FF FF 10
                00 06 00 02 0A 00 00 00 07 00 02 00 00 00 00 08
                00 09 00 00 00 00 09 00 0A 00 00 00 00 0A 00 07
                00 00 00 00 0B 00 06 00 00 00 00 0C 00 07 00 00
                00 00
        Strings:
                Reference Code - CNL PCH
                PCH-CRID Status
                Disabled
                PCH-CRID Original Value
                PCH-CRID New Value
                OPROM - RST - RAID
                CNL PCH H A0 Hsio Version
                CNL PCH H Ax Hsio Version
                CNL PCH H Bx Hsio Version
                CNL PCH LP B0 Hsio Version
                CNL PCH LP Bx Hsio Version
                CNL PCH LP Dx Hsio Version

Handle 0x000C, DMI type 221, 54 bytes
OEM-specific Type
        Header and Data:
                DD 36 0C 00 07 01 00 07 00 68 40 00 02 00 00 07
                01 6E 00 03 00 07 00 68 40 00 04 05 FF FF FF FF
                FF 06 00 00 00 00 07 00 07 00 00 00 00 07 00 08
                00 FF FF FF FF FF
        Strings:
                Reference Code - SA - System Agent
                Reference Code - MRC
                SA - PCIe Version
                SA-CRID Status
                Enabled
                SA-CRID Original Value
                SA-CRID New Value
                OPROM - VBIOS

Handle 0x000D, DMI type 221, 12 bytes
OEM-specific Type
        Header and Data:
                DD 0C 0D 00 01 01 00 04 00 00 00 00
        Strings:
                FSP Binary Version

Handle 0x000E, DMI type 7, 27 bytes
Cache Information
        Socket Designation: L1 Cache
        Configuration: Enabled, Not Socketed, Level 1
        Operational Mode: Write Back
        Location: Internal
        Installed Size: 384 kB
        Maximum Size: 384 kB
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
        Installed Size: 1536 kB
        Maximum Size: 1536 kB
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
        Installed Size: 9 MB
        Maximum Size: 9 MB
        Supported SRAM Types:
                Synchronous
        Installed SRAM Type: Synchronous
        Speed: Unknown
        Error Correction Type: Multi-bit ECC
        System Type: Unified
        Associativity: 12-way Set-associative

Handle 0x0011, DMI type 4, 48 bytes
Processor Information
        Socket Designation: U3E1
        Type: Central Processor
        Family: Core i7
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
        Version: Intel(R) Core(TM) i7-8750H CPU @ 2.20GHz
        Voltage: 0.8 V
        External Clock: 100 MHz
        Max Speed: 2200 MHz
        Current Speed: 2200 MHz
        Status: Populated, Enabled
        Upgrade: Socket BGA1440
        L1 Cache Handle: 0x000E
        L2 Cache Handle: 0x000F
        L3 Cache Handle: 0x0010
        Serial Number: None
        Asset Tag: None
        Part Number: None
        Core Count: 6
        Core Enabled: 6
        Thread Count: 12
        Characteristics:
                64-bit capable
                Multi-Core
                Hardware Thread
                Execute Protection
                Enhanced Virtualization
                Power/Performance Control

Handle 0x0012, DMI type 134, 13 bytes
OEM-specific Type
        Header and Data:
                86 0D 12 00 29 12 18 20 00 00 00 00 00

Handle 0x0013, DMI type 0, 24 bytes
BIOS Information
        Vendor: LENOVO
        Version: N2CET70W (1.53 )
        Release Date: 03/11/2024
        Address: 0xE0000
        Runtime Size: 128 kB
        ROM Size: 16 MB
        Characteristics:
                PCI is supported
                PNP is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                Boot from CD is supported
                Selectable boot is supported
                EDD is supported
                3.5"/720 kB floppy services are supported (int 13h)
                Print screen service is supported (int 5h)
                8042 keyboard services are supported (int 9h)
                Serial services are supported (int 14h)
                Printer services are supported (int 17h)
                CGA/mono video services are supported (int 10h)
                ACPI is supported
                USB legacy is supported
                BIOS boot specification is supported
                Targeted content distribution is supported
                UEFI is supported
        BIOS Revision: 1.53
        Firmware Revision: 1.16

Handle 0x0014, DMI type 1, 27 bytes
System Information
        Manufacturer: LENOVO
        Product Name: 20M9CTO1WW
        Version: ThinkPad P52
        Serial Number: PF1JZKC1
        UUID: 5eaa53cc-352f-11b2-a85c-eba42e829a7f
        Wake-up Type: Power Switch
        SKU Number: LENOVO_MT_20M9_BU_Think_FM_ThinkPad P52
        Family: ThinkPad P52

Handle 0x0015, DMI type 2, 15 bytes
Base Board Information
        Manufacturer: LENOVO
        Product Name: 20M9CTO1WW
        Version: SDK0R32862 WIN
        Serial Number: L1HF8CM02TD
        Asset Tag: Not Available
        Features:
                Board is a hosting board
                Board is replaceable
        Location In Chassis: Not Available
        Chassis Handle: 0x0000
        Type: Motherboard
        Contained Object Handles: 0

Handle 0x0016, DMI type 3, 22 bytes
Chassis Information
        Manufacturer: LENOVO
        Type: Notebook
        Lock: Not Present
        Version: None
        Serial Number: PF1JZKC1
        Asset Tag: No Asset Information
        Boot-up State: Unknown
        Power Supply State: Unknown
        Thermal State: Unknown
        Security Status: Unknown
        OEM Information: 0x00000000
        Height: Unspecified
        Number Of Power Cords: Unspecified
        Contained Elements: 0
        SKU Number: Not Specified

Handle 0x0017, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Not Available
        Internal Connector Type: None
        External Reference Designator: USB 1
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x0018, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Not Available
        Internal Connector Type: None
        External Reference Designator: USB 2
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x0019, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Not Available
        Internal Connector Type: None
        External Reference Designator: USB 3
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x001A, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Not Available
        Internal Connector Type: None
        External Reference Designator: USB 4
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x001B, DMI type 126, 9 bytes
Inactive

Handle 0x001C, DMI type 126, 9 bytes
Inactive

Handle 0x001D, DMI type 126, 9 bytes
Inactive

Handle 0x001E, DMI type 126, 9 bytes
Inactive

Handle 0x001F, DMI type 126, 9 bytes
Inactive

Handle 0x0020, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Not Available
        Internal Connector Type: None
        External Reference Designator: Ethernet
        External Connector Type: RJ-45
        Port Type: Network Port

Handle 0x0021, DMI type 126, 9 bytes
Inactive

Handle 0x0022, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Not Available
        Internal Connector Type: None
        External Reference Designator: Hdmi1
        External Connector Type: Other
        Port Type: Video Port

Handle 0x0023, DMI type 126, 9 bytes
Inactive

Handle 0x0024, DMI type 126, 9 bytes
Inactive

Handle 0x0025, DMI type 126, 9 bytes
Inactive

Handle 0x0026, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Not Available
        Internal Connector Type: None
        External Reference Designator: Headphone/Microphone Combo Jack1
        External Connector Type: Mini Jack (headphones)
        Port Type: Audio Port

Handle 0x0027, DMI type 126, 9 bytes
Inactive

Handle 0x0028, DMI type 9, 17 bytes
System Slot Information
        Designation: Media Card Slot
        Type: Other
        Current Usage: Available
        Length: Other
        Characteristics:
                Hot-plug devices are supported
        Bus Address: 0000:00:00.0

Handle 0x0029, DMI type 9, 17 bytes
System Slot Information
        Designation: SimCard Slot
        Type: Other
        Current Usage: Available
        Length: Other
        Characteristics: None
        Bus Address: 0000:00:00.0

Handle 0x002A, DMI type 12, 5 bytes
System Configuration Options

Handle 0x002B, DMI type 13, 22 bytes
BIOS Language Information
        Language Description Format: Abbreviated
        Installable Languages: 1
                en-US
        Currently Installed Language: en-US

Handle 0x002C, DMI type 22, 26 bytes
Portable Battery
        Location: Front
        Manufacturer: SMP
        Name: 01AV496
        Design Capacity: 90000 mWh
        Design Voltage: 11250 mV
        SBDS Version: 03.01
        Maximum Error: Unknown
        SBDS Serial Number: 09FF
        SBDS Manufacture Date: 2018-12-06
        SBDS Chemistry: LiP
        OEM-specific Information: 0x00000000

Handle 0x002D, DMI type 126, 26 bytes
Inactive

Handle 0x002E, DMI type 133, 5 bytes
OEM-specific Type
        Header and Data:
                85 05 2E 00 01
        Strings:
                KHOIHGIUCCHHII

Handle 0x002F, DMI type 135, 83 bytes
OEM-specific Type
        Header and Data:
                87 53 2F 00 54 50 07 02 42 41 59 20 49 2F 4F 20
                04 00 01 01 40 00 17 00 06 00 00 00 00 01 00 FF
                00 00 00 00 00 00 01 01 04 00 00 00 00 00 00 01
                02 00 00 00 00 00 00 00 01 03 FF 00 00 00 00 00
                00 01 04 04 00 00 00 00 00 00 01 05 FF 00 00 00
                00 00 00

Handle 0x0030, DMI type 130, 20 bytes
OEM-specific Type
        Header and Data:
                82 14 30 00 24 41 4D 54 00 00 00 00 00 A5 AF 02
                C0 00 00 00

Handle 0x0031, DMI type 131, 64 bytes
OEM-specific Type
        Header and Data:
                83 40 31 00 31 00 00 00 0C 00 00 00 00 00 0B 00
                F8 00 0E A3 00 00 00 00 01 00 00 00 00 00 0C 00
                1B 09 5D 00 00 00 00 00 FE 00 BC 15 00 00 00 00
                00 00 00 00 22 00 00 00 76 50 72 6F 00 00 00 00

Handle 0x0032, DMI type 24, 5 bytes
Hardware Security
        Power-On Password Status: Disabled
        Keyboard Password Status: Not Implemented
        Administrator Password Status: Disabled
        Front Panel Reset Status: Not Implemented

Handle 0x0033, DMI type 132, 7 bytes
OEM-specific Type
        Header and Data:
                84 07 33 00 01 C3 36

Handle 0x0034, DMI type 18, 23 bytes
32-bit Memory Error Information
        Type: OK
        Granularity: Unknown
        Operation: Unknown
        Vendor Syndrome: Unknown
        Memory Array Address: Unknown
        Device Address: Unknown
        Resolution: Unknown

Handle 0x0035, DMI type 21, 7 bytes
Built-in Pointing Device
        Type: Track Point
        Interface: PS/2
        Buttons: 3

Handle 0x0036, DMI type 21, 7 bytes
Built-in Pointing Device
        Type: Touch Pad
        Interface: PS/2
        Buttons: 2

Handle 0x0037, DMI type 131, 22 bytes
ThinkVantage Technologies
        Version: 1
        Diagnostics: No

Handle 0x0038, DMI type 136, 6 bytes
OEM-specific Type
        Header and Data:
                88 06 38 00 5A 5A

Handle 0x0039, DMI type 15, 31 bytes
System Event Log
        Area Length: 786 bytes
        Header Start Offset: 0x0000
        Header Length: 16 bytes
        Data Start Offset: 0x0010
        Access Method: General-purpose non-volatile data functions
        Access Address: 0x00F0
        Status: Valid, Not Full
        Change Token: 0x00000030
        Header Format: Type 1
        Supported Log Type Descriptors: 4
        Descriptor 1: POST error
        Data Format 1: POST results bitmap
        Descriptor 2: PCI system error
        Data Format 2: None
        Descriptor 3: System reconfigured
        Data Format 3: None
        Descriptor 4: Log area reset/cleared
        Data Format 4: None

Handle 0x003A, DMI type 140, 19 bytes
OEM-specific Type
        Header and Data:
                8C 13 3A 00 4C 45 4E 4F 56 4F 0B 04 01 B2 00 4D
                53 20 00

Handle 0x003B, DMI type 140, 19 bytes
OEM-specific Type
        Header and Data:
                8C 13 3B 00 4C 45 4E 4F 56 4F 0B 05 01 07 00 00
                00 00 00

Handle 0x003C, DMI type 140, 23 bytes
OEM-specific Type
        Header and Data:
                8C 17 3C 00 4C 45 4E 4F 56 4F 0B 06 01 CB 06 C7
                0D 03 50 00 00 00 00

Handle 0x003D, DMI type 14, 8 bytes
Group Associations
        Name: $MEI
        Items: 1
                0x0000 (OEM-specific)

Handle 0x003E, DMI type 219, 106 bytes
OEM-specific Type
        Header and Data:
                DB 6A 3E 00 01 04 01 45 02 00 90 06 01 85 30 20
                00 00 00 04 40 00 00 01 1F 00 00 C9 0A 40 44 02
                FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
                FF FF FF FF FF FF FF FF 03 00 00 00 80 00 00 00
                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                00 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                00 00 00 00 00 00 00 00 00 00
        Strings:
                MEI1
                MEI2
                MEI3
                MEI4

Handle 0x003F, DMI type 140, 15 bytes
ThinkPad Embedded Controller Program
        Version ID: N2CHT26W
        Release Date: 11/29/2019

Handle 0x0040, DMI type 140, 43 bytes
OEM-specific Type
        Header and Data:
                8C 2B 40 00 4C 45 4E 4F 56 4F 0B 08 01 FF FF FF
                FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
                FF FF FF FF FF FF FF FF FF FF FF

Handle 0x0041, DMI type 135, 18 bytes
OEM-specific Type
        Header and Data:
                87 12 41 00 54 50 07 01 01 00 03 00 01 00 02 00
                01 00

Handle 0xFEFF, DMI type 127, 4 bytes
End Of Table
```
