# Suprox DMI Info

[Desktop Management Interface](https://en.wikipedia.org/wiki/Desktop_Management_Interface)

```
root@suprox:~# dmidecode
# dmidecode 3.4
Getting SMBIOS data from sysfs.
SMBIOS 3.2.1 present.
Table at 0x8EC1E000.

Handle 0x0000, DMI type 0, 26 bytes
BIOS Information
	Vendor: American Megatrends Inc.
	Version: 2.2
	Release Date: 10/27/2023
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 32 MB
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
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported
		Targeted content distribution is supported
		UEFI is supported
	BIOS Revision: 5.13

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Supermicro
	Product Name: Super Server
	Version: 0123456789
	Serial Number: 0123456789
	UUID: 00000000-0000-0000-0000-3cecef563e02
	Wake-up Type: Power Switch
	SKU Number: To be filled by O.E.M.
	Family: To be filled by O.E.M.

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
	Manufacturer: Supermicro
	Product Name: X11SCL-IF
	Version: 1.01
	Serial Number: OM20BS018919
	Asset Tag: To be filled by O.E.M.
	Features:
		Board is a hosting board
		Board is replaceable
	Location In Chassis: To be filled by O.E.M.
	Chassis Handle: 0x0003
	Type: Motherboard
	Contained Object Handles: 0

Handle 0x0003, DMI type 3, 22 bytes
Chassis Information
	Manufacturer: Supermicro
	Type: Main Server Chassis
	Lock: Not Present
	Version: 0123456789
	Serial Number: 0123456789
	Asset Tag: To be filled by O.E.M.
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000
	Height: Unspecified
	Number Of Power Cords: 1
	Contained Elements: 0
	SKU Number: To be filled by O.E.M.

Handle 0x0004, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JCOM1
	Internal Connector Type: None
	External Reference Designator: COM1
	External Connector Type: DB-9 male
	Port Type: Serial Port 16550A Compatible

Handle 0x0005, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JUSBRJ45
	Internal Connector Type: None
	External Reference Designator: USB 0/1
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0006, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JUSBRJ45
	Internal Connector Type: None
	External Reference Designator: IPMI LAN
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0007, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JUSB31
	Internal Connector Type: None
	External Reference Designator: USB 4/5(3.0)
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JLAN1
	Internal Connector Type: None
	External Reference Designator: LAN1/2
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: JVGA
	Internal Connector Type: None
	External Reference Designator: VGA
	External Connector Type: DB-15 female
	Port Type: Video Port

Handle 0x000A, DMI type 9, 17 bytes
System Slot Information
	Designation: CPU SLOT1 PCI-E 3.0 X16
	Type: x16 PCI Express 3 x16
	Current Usage: In Use
	Length: Short
	ID: 1
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:01:00.0

Handle 0x000D, DMI type 9, 17 bytes
System Slot Information
	Designation: M.2-H
	Type: x4 M.2 Socket 3
	Current Usage: In Use
	Length: Short
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported
	Bus Address: 0000:07:00.0

Handle 0x000E, DMI type 11, 5 bytes
OEM Strings
	String 1: Intel CoffeeLake-S/CannonLake-H/MehlowSVR
	String 2: Supermicro motherboard-X11 Series

Handle 0x000F, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x0010, DMI type 26, 22 bytes
Voltage Probe
	Description: LM78A
	Location: Power Unit
	Status: OK
	Maximum Value: Unknown
	Minimum Value: Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000
	Nominal Value: Unknown

Handle 0x0011, DMI type 28, 22 bytes
Temperature Probe
	Description: LM78A
	Location: Power Unit
	Status: OK
	Maximum Value: Unknown
	Minimum Value: Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000
	Nominal Value: Unknown

Handle 0x0012, DMI type 27, 15 bytes
Cooling Device
	Temperature Probe Handle: 0x0011
	Type: Power Supply Fan
	Status: OK
	Cooling Unit Group: 1
	OEM-specific Information: 0x00000000
	Nominal Speed: Unknown Or Non-rotating
	Description: Cooling Dev 1

Handle 0x0013, DMI type 29, 22 bytes
Electrical Current Probe
	Description: ABC
	Location: Power Unit
	Status: OK
	Maximum Value: Unknown
	Minimum Value: Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000
	Nominal Value: Unknown

Handle 0x0014, DMI type 39, 22 bytes
System Power Supply
	Power Unit Group: 1
	Location: PSU1
	Name: To Be Filled By O.E.M.
	Manufacturer: To Be Filled By O.E.M.
	Serial Number: To Be Filled By O.E.M.
	Asset Tag: To Be Filled By O.E.M.
	Model Part Number: To Be Filled By O.E.M.
	Revision: To Be Filled By O.E.M.
	Max Power Capacity: Unknown
	Status: Not Present
	Type: Switching
	Input Voltage Range Switching: Auto-switch
	Plugged: Yes
	Hot Replaceable: No
	Input Voltage Probe Handle: 0x0010
	Cooling Device Handle: 0x0012
	Input Current Probe Handle: 0x0013

Handle 0x0015, DMI type 39, 22 bytes
System Power Supply
	Power Unit Group: 2
	Location: PSU2
	Name: To Be Filled By O.E.M.
	Manufacturer: To Be Filled By O.E.M.
	Serial Number: To Be Filled By O.E.M.
	Asset Tag: To Be Filled By O.E.M.
	Model Part Number: To Be Filled By O.E.M.
	Revision: To Be Filled By O.E.M.
	Max Power Capacity: Unknown
	Status: Not Present
	Type: Switching
	Input Voltage Range Switching: Auto-switch
	Plugged: Yes
	Hot Replaceable: No

Handle 0x0016, DMI type 41, 11 bytes
Onboard Device
	Reference Designation:  ASPEED Video AST2500
	Type: Video
	Status: Enabled
	Type Instance: 1
	Bus Address: 0000:06:00.0

Handle 0x0017, DMI type 41, 11 bytes
Onboard Device
	Reference Designation:  Intel Ethernet I210 #1
	Type: Ethernet
	Status: Enabled
	Type Instance: 1
	Bus Address: 0000:02:00.0

Handle 0x0018, DMI type 41, 11 bytes
Onboard Device
	Reference Designation:  Intel Ethernet I210 #2
	Type: Ethernet
	Status: Enabled
	Type Instance: 2
	Bus Address: 0000:03:00.0

Handle 0x0019, DMI type 38, 18 bytes
IPMI Device Information
	Interface Type: KCS (Keyboard Control Style)
	Specification Version: 2.0
	I2C Slave Address: 0x10
	NV Storage Device: Not Present
	Base Address: 0x0000000000000CA2 (I/O)
	Register Spacing: Successive Byte Boundaries

Handle 0x001A, DMI type 42, 12 bytes
Management Controller Host Interface

Handle 0x001F, DMI type 16, 23 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Single-bit ECC
	Maximum Capacity: 64 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x0024, DMI type 19, 31 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x007FFFFFFFF
	Range Size: 32 GB
	Physical Array Handle: 0x001F
	Partition Width: 2

Handle 0x0025, DMI type 15, 73 bytes
System Event Log
	Area Length: 65535 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: Memory-mapped physical 32-bit address
	Access Address: 0xFF670000
	Status: Valid, Not Full
	Change Token: 0x00000001
	Header Format: Type 1
	Supported Log Type Descriptors: 25
	Descriptor 1: Single-bit ECC memory error
	Data Format 1: Multiple-event handle
	Descriptor 2: Multi-bit ECC memory error
	Data Format 2: Multiple-event handle
	Descriptor 3: Parity memory error
	Data Format 3: None
	Descriptor 4: Bus timeout
	Data Format 4: None
	Descriptor 5: I/O channel block
	Data Format 5: None
	Descriptor 6: Software NMI
	Data Format 6: None
	Descriptor 7: POST memory resize
	Data Format 7: None
	Descriptor 8: POST error
	Data Format 8: POST results bitmap
	Descriptor 9: PCI parity error
	Data Format 9: Multiple-event handle
	Descriptor 10: PCI system error
	Data Format 10: Multiple-event handle
	Descriptor 11: CPU failure
	Data Format 11: None
	Descriptor 12: EISA failsafe timer timeout
	Data Format 12: None
	Descriptor 13: Correctable memory log disabled
	Data Format 13: None
	Descriptor 14: Logging disabled
	Data Format 14: None
	Descriptor 15: System limit exceeded
	Data Format 15: None
	Descriptor 16: Asynchronous hardware timer expired
	Data Format 16: None
	Descriptor 17: System configuration information
	Data Format 17: None
	Descriptor 18: Hard disk information
	Data Format 18: None
	Descriptor 19: System reconfigured
	Data Format 19: None
	Descriptor 20: Uncorrectable CPU-complex error
	Data Format 20: None
	Descriptor 21: Log area reset/cleared
	Data Format 21: None
	Descriptor 22: System boot
	Data Format 22: None
	Descriptor 23: End of log
	Data Format 23: None
	Descriptor 24: OEM-specific
	Data Format 24: OEM-specific
	Descriptor 25: OEM-specific
	Data Format 25: OEM-specific

Handle 0x0026, DMI type 221, 26 bytes
OEM-specific Type
	Header and Data:
		DD 1A 26 00 03 01 00 07 00 58 40 00 02 00 00 00
		00 F0 00 03 00 FF FF FF FF FF
	Strings:
		Reference Code - CPU
		uCode Version
		TXT ACM version

Handle 0x0027, DMI type 221, 26 bytes
OEM-specific Type
	Header and Data:
		DD 1A 27 00 03 01 00 07 00 58 40 00 02 00 00 00
		00 00 00 03 04 FF FF FF FF FF
	Strings:
		Reference Code - ME
		MEBx version
		ME Firmware Version
		Consumer SKU

Handle 0x0028, DMI type 221, 82 bytes
OEM-specific Type
	Header and Data:
		DD 52 28 00 0B 01 00 07 00 58 40 00 02 03 FF FF
		FF FF FF 04 00 FF FF FF 10 00 05 00 FF FF FF 10
		00 06 00 FF FF FF FF FF 07 00 02 00 00 00 00 08
		00 09 00 00 00 00 09 00 0D 00 00 00 00 0A 00 07
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

Handle 0x0029, DMI type 221, 54 bytes
OEM-specific Type
	Header and Data:
		DD 36 29 00 07 01 00 07 00 58 40 00 02 00 00 07
		01 73 00 03 00 07 00 58 40 00 04 05 FF FF FF FF
		FF 06 00 00 00 00 08 00 07 00 00 00 00 08 00 08
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

Handle 0x002A, DMI type 7, 27 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 256 kB
	Maximum Size: 256 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Parity
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x002B, DMI type 7, 27 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 1 MB
	Maximum Size: 1 MB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 4-way Set-associative

Handle 0x002C, DMI type 7, 27 bytes
Cache Information
	Socket Designation: L3 Cache
	Configuration: Enabled, Not Socketed, Level 3
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 6 MB
	Maximum Size: 6 MB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Multi-bit ECC
	System Type: Unified
	Associativity: 12-way Set-associative

Handle 0x002D, DMI type 4, 48 bytes
Processor Information
	Socket Designation: CPU
	Type: Central Processor
	Family: Core i3
	Manufacturer: Intel(R) Corporation
	ID: EB 06 09 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 158, Stepping 11
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
	Version: Intel(R) Core(TM) i3-8100 CPU @ 3.60GHz
	Voltage: 1.0 V
	External Clock: 100 MHz
	Max Speed: 8300 MHz
	Current Speed: 3600 MHz
	Status: Populated, Enabled
	Upgrade: Socket LGA1151
	L1 Cache Handle: 0x002A
	L2 Cache Handle: 0x002B
	L3 Cache Handle: 0x002C
	Serial Number: To Be Filled By O.E.M.
	Asset Tag: To Be Filled By O.E.M.
	Part Number: To Be Filled By O.E.M.
	Core Count: 4
	Core Enabled: 4
	Thread Count: 4
	Characteristics:
		64-bit capable
		Multi-Core
		Execute Protection
		Enhanced Virtualization
		Power/Performance Control

Handle 0x002E, DMI type 17, 84 bytes
Memory Device
	Array Handle: 0x001F
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 16 GB
	Form Factor: DIMM
	Set: None
	Locator: DIMMA1
	Bank Locator: P0_Node0_Channel0_Dimm0
	Type: DDR4
	Type Detail: Synchronous
	Speed: 2667 MT/s
	Manufacturer: Micron
	Serial Number: E75606A4
	Asset Tag: 9876543210
	Part Number: 18ASF2G72AZ-2G6E1
	Rank: 2
	Configured Memory Speed: 2400 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V
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

Handle 0x0030, DMI type 17, 84 bytes
Memory Device
	Array Handle: 0x001F
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 16 GB
	Form Factor: DIMM
	Set: None
	Locator: DIMMB1
	Bank Locator: P0_Node0_Channel1_Dimm0
	Type: DDR4
	Type Detail: Synchronous
	Speed: 2667 MT/s
	Manufacturer: Micron
	Serial Number: E75606A4
	Asset Tag: 9876543210
	Part Number: 18ASF2G72AZ-2G6E1
	Rank: 2
	Configured Memory Speed: 2400 MT/s
	Minimum Voltage: 1.2 V
	Maximum Voltage: 1.2 V
	Configured Voltage: 1.2 V
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

Handle 0x0032, DMI type 20, 35 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x003FFFFFFFF
	Range Size: 16 GB
	Physical Device Handle: 0x002E
	Memory Array Mapped Address Handle: 0x0024
	Partition Row Position: Unknown
	Interleave Position: 1
	Interleaved Data Depth: 2

Handle 0x0033, DMI type 20, 35 bytes
Memory Device Mapped Address
	Starting Address: 0x00400000000
	Ending Address: 0x007FFFFFFFF
	Range Size: 16 GB
	Physical Device Handle: 0x0030
	Memory Array Mapped Address Handle: 0x0024
	Partition Row Position: Unknown
	Interleave Position: 2
	Interleaved Data Depth: 2

Handle 0x0034, DMI type 199, 5 bytes
OEM-specific Type
	Header and Data:
		C7 05 34 00 01
	Strings:


Handle 0x0035, DMI type 40, 27 bytes
Additional Information 1
	Referenced Handle: 0x000a
	Referenced Offset: 0x00
	String: Not Specified
	Value: Unexpected size

Handle 0x0036, DMI type 40, 27 bytes
Additional Information 1
	Referenced Handle: 0x000b
	Referenced Offset: 0x00
	String: Not Specified
	Value: Unexpected size

Handle 0x0037, DMI type 40, 27 bytes
Additional Information 1
	Referenced Handle: 0x000c
	Referenced Offset: 0x00
	String: Not Specified
	Value: Unexpected size

Handle 0x0038, DMI type 40, 27 bytes
Additional Information 1
	Referenced Handle: 0x000d
	Referenced Offset: 0x00
	String: Not Specified
	Value: Unexpected size

Handle 0x0039, DMI type 40, 27 bytes
Additional Information 1
	Referenced Handle: 0x0016
	Referenced Offset: 0x00
	String: Not Specified
	Value: Unexpected size

Handle 0x003A, DMI type 40, 27 bytes
Additional Information 1
	Referenced Handle: 0x0017
	Referenced Offset: 0x00
	String: Not Specified
	Value: Unexpected size

Handle 0x003B, DMI type 40, 27 bytes
Additional Information 1
	Referenced Handle: 0x0018
	Referenced Offset: 0x00
	String: Not Specified
	Value: Unexpected size

Handle 0x003C, DMI type 221, 89 bytes
OEM-specific Type
	Header and Data:
		DD 59 3C 00 0C 01 00 FF FF FF FF FF 02 00 FF FF
		FF FF FF 03 04 FF FF FF FF FF 05 06 FF FF FF FF
		FF 07 08 FF FF FF FF FF 09 00 00 00 00 00 00 0A
		00 FF FF FF FF FF 0B 00 FF FF 00 00 00 0C 00 FF
		FF FF FF FF 0D 0E 01 04 03 00 00 0F 00 00 07 00
		00 00 10 00 00 02 00 0E 00
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
		BP1.4.3.0_RP01
		Platform Version
		Client Silicon Version

Handle 0x003D, DMI type 136, 6 bytes
OEM-specific Type
	Header and Data:
		88 06 3D 00 00 00

Handle 0x003E, DMI type 14, 20 bytes
Group Associations
	Name: Firmware Version Info
	Items: 5
		0x0026 (OEM-specific)
		0x0027 (OEM-specific)
		0x0028 (OEM-specific)
		0x0029 (OEM-specific)
		0x003C (OEM-specific)

Handle 0x003F, DMI type 127, 4 bytes
End Of Table
```
