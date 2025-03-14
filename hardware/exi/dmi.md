# exi dmi

[Desktop Management Interface](https://en.wikipedia.org/wiki/Desktop_Management_Interface)

```
alex@exi > sudo dmidecode
[sudo] password for alex:
# dmidecode 3.5
Getting SMBIOS data from sysfs.
SMBIOS 3.5.0 present.
Table at 0x69AE5000.

Handle 0x0000, DMI type 0, 26 bytes
BIOS Information
	Vendor: American Megatrends International, LLC.
	Version: 10.01
	Release Date: 09/30/2024
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
		Japanese floppy for NEC 9800 1.2 MB is supported (int 13h)
		Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
		5.25"/360 kB floppy services are supported (int 13h)
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 kB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
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
	BIOS Revision: 5.27

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: ASRock
	Product Name: B760M Pro RS
	Version: To Be Filled By O.E.M.
	Serial Number: To Be Filled By O.E.M.
	UUID: 13006b9c-67db-0000-0000-000000000000
	Wake-up Type: Power Switch
	SKU Number: To Be Filled By O.E.M.
	Family: To Be Filled By O.E.M.

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
	Manufacturer: ASRock
	Product Name: B760M Pro RS
	Version:
	Serial Number: M80-G2017201792
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
	SKU Number: To Be Filled By O.E.M.

Handle 0x0004, DMI type 9, 17 bytes
System Slot Information
	Designation: Slot1
	Type: x16 PCI Express
	Current Usage: In Use
	Length: Long
	ID: 17
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:01:00.0

Handle 0x0005, DMI type 9, 17 bytes
System Slot Information
	Designation: Slot2
	Type: x1 PCI Express
	Current Usage: Available
	Length: Short
	ID: 18
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:1c:00.7

Handle 0x0006, DMI type 9, 17 bytes
System Slot Information
	Designation: Slot3
	Type: x1 PCI Express
	Current Usage: Available
	Length: Long
	ID: 19
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:1c:00.4

Handle 0x0007, DMI type 9, 17 bytes
System Slot Information
	Designation: Slot4
	Type: x1 PCI Express
	Current Usage: Available
	Length: Long
	ID: 20
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:1d:00.6

Handle 0x0008, DMI type 9, 17 bytes
System Slot Information
	Designation: M2_1
	Type: x1 PCI Express
	Current Usage: Available
	Length: Short
	ID: 33
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:06:00.0

Handle 0x0009, DMI type 9, 17 bytes
System Slot Information
	Designation: M2_2
	Type: x4 PCI Express
	Current Usage: In Use
	Length: Short
	ID: 34
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:02:00.0

Handle 0x000A, DMI type 9, 17 bytes
System Slot Information
	Designation: M2_Wifi
	Type: x1 PCI Express
	Current Usage: Available
	Length: Short
	ID: 49
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:1d:00.7

Handle 0x000B, DMI type 11, 5 bytes
OEM Strings
	String 1: To Be Filled By O.E.M.

Handle 0x000C, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x000D, DMI type 44, 9 bytes
Unknown Type
	Header and Data:
		2C 09 0D 00 FF FF 01 01 00

Handle 0x000E, DMI type 16, 23 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 128 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x000F, DMI type 17, 92 bytes
Memory Device
	Array Handle: 0x000E
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 16 GB
	Form Factor: DIMM
	Set: None
	Locator: Controller0-ChannelA-DIMM0
	Bank Locator: BANK 0
	Type: DDR5
	Type Detail: Synchronous
	Speed: 5600 MT/s
	Manufacturer: Micron Technology
	Serial Number: EA1C8BC0
	Asset Tag: 9876543210
	Part Number: CP16G60C36U5B.M8D1
	Rank: 1
	Configured Memory Speed: 5600 MT/s
	Minimum Voltage: 1.25 V
	Maximum Voltage: 1.25 V
	Configured Voltage: 1.25 V
	Memory Technology: DRAM
	Memory Operating Mode Capability: Volatile memory
	Firmware Version: Not Specified
	Module Manufacturer ID: Bank 1, Hex 0x2C
	Module Product ID: Unknown
	Memory Subsystem Controller Manufacturer ID: Unknown
	Memory Subsystem Controller Product ID: Unknown
	Non-Volatile Size: None
	Volatile Size: 16 GB
	Cache Size: None
	Logical Size: None

Handle 0x0010, DMI type 17, 92 bytes
Memory Device
	Array Handle: 0x000E
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 16 GB
	Form Factor: DIMM
	Set: None
	Locator: Controller0-ChannelA-DIMM1
	Bank Locator: BANK 0
	Type: DDR5
	Type Detail: Synchronous
	Speed: 5600 MT/s
	Manufacturer: Micron Technology
	Serial Number: EA1C8BE3
	Asset Tag: 9876543210
	Part Number: CP16G60C36U5B.M8D1
	Rank: 1
	Configured Memory Speed: 5600 MT/s
	Minimum Voltage: 1.25 V
	Maximum Voltage: 1.25 V
	Configured Voltage: 1.25 V
	Memory Technology: DRAM
	Memory Operating Mode Capability: Volatile memory
	Firmware Version: Not Specified
	Module Manufacturer ID: Bank 1, Hex 0x2C
	Module Product ID: Unknown
	Memory Subsystem Controller Manufacturer ID: Unknown
	Memory Subsystem Controller Product ID: Unknown
	Non-Volatile Size: None
	Volatile Size: 16 GB
	Cache Size: None
	Logical Size: None

Handle 0x0011, DMI type 17, 92 bytes
Memory Device
	Array Handle: 0x000E
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 16 GB
	Form Factor: DIMM
	Set: None
	Locator: Controller1-ChannelA-DIMM0
	Bank Locator: BANK 0
	Type: DDR5
	Type Detail: Synchronous
	Speed: 5600 MT/s
	Manufacturer: Micron Technology
	Serial Number: EA1C8BD4
	Asset Tag: 9876543210
	Part Number: CP16G60C36U5B.M8D1
	Rank: 1
	Configured Memory Speed: 5600 MT/s
	Minimum Voltage: 1.25 V
	Maximum Voltage: 1.25 V
	Configured Voltage: 1.25 V
	Memory Technology: DRAM
	Memory Operating Mode Capability: Volatile memory
	Firmware Version: Not Specified
	Module Manufacturer ID: Bank 1, Hex 0x2C
	Module Product ID: Unknown
	Memory Subsystem Controller Manufacturer ID: Unknown
	Memory Subsystem Controller Product ID: Unknown
	Non-Volatile Size: None
	Volatile Size: 16 GB
	Cache Size: None
	Logical Size: None

Handle 0x0012, DMI type 17, 92 bytes
Memory Device
	Array Handle: 0x000E
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 16 GB
	Form Factor: DIMM
	Set: None
	Locator: Controller1-ChannelA-DIMM1
	Bank Locator: BANK 0
	Type: DDR5
	Type Detail: Synchronous
	Speed: 5600 MT/s
	Manufacturer: Micron Technology
	Serial Number: EA1C8BD8
	Asset Tag: 9876543210
	Part Number: CP16G60C36U5B.M8D1
	Rank: 1
	Configured Memory Speed: 5600 MT/s
	Minimum Voltage: 1.25 V
	Maximum Voltage: 1.25 V
	Configured Voltage: 1.25 V
	Memory Technology: DRAM
	Memory Operating Mode Capability: Volatile memory
	Firmware Version: Not Specified
	Module Manufacturer ID: Bank 1, Hex 0x2C
	Module Product ID: Unknown
	Memory Subsystem Controller Manufacturer ID: Unknown
	Memory Subsystem Controller Product ID: Unknown
	Non-Volatile Size: None
	Volatile Size: 16 GB
	Cache Size: None
	Logical Size: None

Handle 0x0013, DMI type 19, 31 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x00FFFFFFFFF
	Range Size: 64 GB
	Physical Array Handle: 0x000E
	Partition Width: 4

Handle 0x0014, DMI type 43, 31 bytes
TPM Device
	Vendor ID: INTC
	Specification Version: 2.0
	Firmware Revision: 600.18
	Description: INTEL
	Characteristics:
		Family configurable via platform software support
	OEM-specific Information: 0x00000000

Handle 0x0015, DMI type 45, 26 bytes
Firmware Inventory Information
	Firmware Component Name: TPM Firmware
	Firmware Version: 2580012:1E08D8..
	Firmware ID: Not Specified
	Release Date: 2021-05-15T00:00:00Z
	Manufacturer: INTEL
	Lowest Supported Firmware Version: Not Specified
	Image Size: Unknown
	Characteristics:
		Updatable: No
		Write-Protect: No
	State: Enabled
	Associated Components: 1
		0x0014

Handle 0x0017, DMI type 20, 35 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x003FFFFFFFF
	Range Size: 16 GB
	Physical Device Handle: 0x000F
	Memory Array Mapped Address Handle: 0x0013
	Partition Row Position: 1
	Interleave Position: 1
	Interleaved Data Depth: 2

Handle 0x0018, DMI type 20, 35 bytes
Memory Device Mapped Address
	Starting Address: 0x00400000000
	Ending Address: 0x007FFFFFFFF
	Range Size: 16 GB
	Physical Device Handle: 0x0010
	Memory Array Mapped Address Handle: 0x0013
	Partition Row Position: 1
	Interleave Position: 1
	Interleaved Data Depth: 2

Handle 0x0019, DMI type 20, 35 bytes
Memory Device Mapped Address
	Starting Address: 0x00800000000
	Ending Address: 0x00BFFFFFFFF
	Range Size: 16 GB
	Physical Device Handle: 0x0011
	Memory Array Mapped Address Handle: 0x0013
	Partition Row Position: 1
	Interleave Position: 2
	Interleaved Data Depth: 2

Handle 0x001A, DMI type 20, 35 bytes
Memory Device Mapped Address
	Starting Address: 0x00C00000000
	Ending Address: 0x00FFFFFFFFF
	Range Size: 16 GB
	Physical Device Handle: 0x0012
	Memory Array Mapped Address Handle: 0x0013
	Partition Row Position: 1
	Interleave Position: 2
	Interleaved Data Depth: 2

Handle 0x001B, DMI type 221, 12 bytes
OEM-specific Type
	Header and Data:
		DD 0C 1B 00 01 01 00 04 00 00 00 00
	Strings:
		FSP Binary Version

Handle 0x001C, DMI type 221, 26 bytes
OEM-specific Type
	Header and Data:
		DD 1A 1C 00 03 01 00 0C 00 AD 50 00 02 00 00 00
		00 36 00 03 00 FF FF FF FF FF
	Strings:
		Reference Code - CPU
		uCode Version
		TXT ACM version

Handle 0x001D, DMI type 221, 26 bytes
OEM-specific Type
	Header and Data:
		DD 1A 1D 00 03 01 00 0C 00 AD 50 00 02 00 00 00
		00 00 00 03 04 10 01 1E D8 08
	Strings:
		Reference Code - ME
		MEBx version
		ME Firmware Version
		Consumer SKU

Handle 0x001E, DMI type 221, 47 bytes
OEM-specific Type
	Header and Data:
		DD 2F 1E 00 06 01 00 0C 00 AD 50 00 02 03 FF FF
		FF FF FF 04 00 FF FF FF 11 00 05 00 FF FF FF 11
		00 06 00 02 46 00 00 00 07 00 04 00 00 00 00
	Strings:
		Reference Code - PCH
		PCH-CRID Status
		Disabled
		PCH-CRID Original Value
		PCH-CRID New Value
		OPROM - RST - RAID
		PCH Hsio Version

Handle 0x001F, DMI type 221, 82 bytes
OEM-specific Type
	Header and Data:
		DD 52 1F 00 0B 01 00 0C 00 AD 50 00 02 00 00 00
		04 85 00 03 00 0C 00 AD 50 00 04 05 FF FF FF FF
		FF 06 00 00 00 00 02 00 07 00 00 00 00 02 00 08
		00 FF FF FF FF FF 09 00 FF FF FF FF FF 0A 00 FF
		FF FF FF FF 0B 00 FF FF FF FF FF 0C 00 FF FF FF
		FF FF
	Strings:
		Reference Code - SA - System Agent
		Reference Code - MRC
		SA - PCIe Version
		SA-CRID Status
		Disabled
		SA-CRID Original Value
		SA-CRID New Value
		OPROM - VBIOS
		IO Manageability Engine FW Version
		PHY Build Version
		Thunderbolt(TM) FW Version
		System Agent Manageability Engine FW Version

Handle 0x0020, DMI type 7, 27 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 288 kB
	Maximum Size: 288 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Parity
	System Type: Data
	Associativity: 12-way Set-associative

Handle 0x0021, DMI type 7, 27 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 192 kB
	Maximum Size: 192 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Parity
	System Type: Instruction
	Associativity: 8-way Set-associative

Handle 0x0022, DMI type 7, 27 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 7680 kB
	Maximum Size: 7680 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: Other

Handle 0x0023, DMI type 7, 27 bytes
Cache Information
	Socket Designation: L3 Cache
	Configuration: Enabled, Not Socketed, Level 3
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 18 MB
	Maximum Size: 18 MB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Multi-bit ECC
	System Type: Unified
	Associativity: Other

Handle 0x0024, DMI type 4, 48 bytes
Processor Information
	Socket Designation: CPUSocket
	Type: Central Processor
	Family: Core i5
	Manufacturer: Intel(R) Corporation
	ID: 72 06 09 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 151, Stepping 2
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
	Version: 12th Gen Intel(R) Core(TM) i5-12400F
	Voltage: 1.0 V
	External Clock: 100 MHz
	Max Speed: 4400 MHz
	Current Speed: 3960 MHz
	Status: Populated, Enabled
	Upgrade: Socket LGA1700
	L1 Cache Handle: 0x0021
	L2 Cache Handle: 0x0022
	L3 Cache Handle: 0x0023
	Serial Number: To Be Filled By O.E.M.
	Asset Tag: To Be Filled By O.E.M.
	Part Number: To Be Filled By O.E.M.
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

Handle 0x0025, DMI type 130, 24 bytes
OEM-specific Type
	Header and Data:
		82 18 25 00 24 41 4D 54 00 00 00 00 00 A5 EF 02
		80 00 00 00 00 00 00 00

Handle 0x0026, DMI type 131, 64 bytes
OEM-specific Type
	Header and Data:
		83 40 26 00 31 00 00 00 00 00 00 00 00 00 00 00
		F8 00 06 7A 00 00 00 00 21 20 00 00 01 00 10 00
		D8 08 1E 00 00 00 00 00 FE 00 FF FF 00 00 00 00
		00 00 00 00 22 00 00 00 76 50 72 6F 00 00 00 00

Handle 0x0027, DMI type 221, 103 bytes
OEM-specific Type
	Header and Data:
		DD 67 27 00 0E 01 00 FF FF FF FF FF 02 00 FF FF
		FF FF FF 03 04 FF FF FF FF FF 05 06 FF FF FF FF
		FF 07 08 FF FF FF FF FF 09 00 FF FF FF FF FF 0A
		00 FF FF FF FF FF 0B 00 FF FF 00 00 00 0C 00 FF
		FF FF FF FF 0D 00 FF FF FF FF FF 0E 00 00 07 00
		00 00 0F 00 13 05 00 2C 16 10 00 FF FF FF FF FF
		11 00 FF FF FF FF FF
	Strings:
		Lan Phy Version
		Sensor Firmware Version
		Debug Mode Status
		Disabled
		Performance Mode Status
		Disabled
		Debug Use USB(Disabled:Serial)
		Disabled
		ICC Overclocking Version
		UNDI Version
		EC FW Version
		GOP Version
		Royal Park Version
		Platform Version
		RST PreOS Version
		TCSS PD0 Version
		TCSS PD1 Version

Handle 0x0028, DMI type 14, 8 bytes
Group Associations
	Name: $MEI
	Items: 1
		0x0000 (OEM-specific)

Handle 0x0029, DMI type 219, 106 bytes
OEM-specific Type
	Header and Data:
		DB 6A 29 00 01 04 01 55 02 00 90 06 01 85 39 20
		00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 02
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

Handle 0x002A, DMI type 136, 6 bytes
OEM-specific Type
	Header and Data:
		88 06 2A 00 00 00

Handle 0x002B, DMI type 127, 4 bytes
End Of Table
```
