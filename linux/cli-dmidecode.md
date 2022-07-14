# dmidecode

[man page](https://manpage.me/?dmidecode)

## Install

It is already installed.  Otherwise:

```sh
sudo apt install dmidecode
```


## Use

`sudo dmidecode` will produce lots of output.
Consider instead using any of these:

* `sudo dmidecode -t processor` for CPU info
* `sudo dmidecode -t memory` for RAM info
* `sudo dmidecode -t bios` for BIOS info
* `sudo dmidecode -t system` for system info, e.g. manufacturer, model,
serial number, SKU, uuid
* `sudo dmidecode -t baseboard` displays info on components built into the
motherboard.  Apparently my laptop has an 1394 controller!
* `sudo dmidecode -t chassis` displays type, e.g. `Notebook`, serial number,
asset tag, etc.

E.g.

```sh
> sudo dmidecode -t memory
# dmidecode 3.2
Getting SMBIOS data from sysfs.
SMBIOS 3.1.0 present.

Handle 0x004D, DMI type 16, 23 bytes
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: None
        Maximum Capacity: 32 GB
        Error Information Handle: Not Provided
        Number Of Devices: 2

Handle 0x004E, DMI type 17, 40 bytes
Memory Device
        Array Handle: 0x004D
        Error Information Handle: Not Provided
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 16384 MB
        Form Factor: SODIMM
        Set: None
        Locator: DIMM A
        Bank Locator: BANK 0
        Type: DDR4
        Type Detail: Synchronous Unbuffered (Unregistered)
        Speed: 3200 MT/s
        Manufacturer: 859B0000802C
        Serial Number: E6610B32
        Asset Tag: 00221300
        Part Number: CT16G4SFRA32A.C16FR
        Rank: 2
        Configured Memory Speed: 2400 MT/s
        Minimum Voltage: 1.2 V
        Maximum Voltage: 1.2 V
        Configured Voltage: 1.2 V

Handle 0x004F, DMI type 17, 40 bytes
Memory Device
        Array Handle: 0x004D
        Error Information Handle: Not Provided
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 16384 MB
        Form Factor: SODIMM
        Set: None
        Locator: DIMM B
        Bank Locator: BANK 2
        Type: DDR4
        Type Detail: Synchronous Unbuffered (Unregistered)
        Speed: 3200 MT/s
        Manufacturer: 859B0000802C
        Serial Number: E661112A
        Asset Tag: 00221300
        Part Number: CT16G4SFRA32A.C16FR
        Rank: 2
        Configured Memory Speed: 2400 MT/s
        Minimum Voltage: 1.2 V
        Maximum Voltage: 1.2 V
        Configured Voltage: 1.2 V
```

The above can be narrowed down:

```sh
> sudo dmidecode -q --type 17
Memory Device
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 16384 MB
        Form Factor: SODIMM
        Set: None
        Locator: DIMM A
        Bank Locator: BANK 0
        Type: DDR4
        Type Detail: Synchronous Unbuffered (Unregistered)
        Speed: 3200 MT/s
        Manufacturer: 859B0000802C
        Serial Number: E6610B32
        Asset Tag: 00221300
        Part Number: CT16G4SFRA32A.C16FR
        Rank: 2
        Configured Memory Speed: 2400 MT/s
        Minimum Voltage: 1.2 V
        Maximum Voltage: 1.2 V
        Configured Voltage: 1.2 V

Memory Device
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 16384 MB
        Form Factor: SODIMM
        Set: None
        Locator: DIMM B
        Bank Locator: BANK 2
        Type: DDR4
        Type Detail: Synchronous Unbuffered (Unregistered)
        Speed: 3200 MT/s
        Manufacturer: 859B0000802C
        Serial Number: E661112A
        Asset Tag: 00221300
        Part Number: CT16G4SFRA32A.C16FR
        Rank: 2
        Configured Memory Speed: 2400 MT/s
        Minimum Voltage: 1.2 V
        Maximum Voltage: 1.2 V
        Configured Voltage: 1.2 V
```

To find out the type of the remote system, its BIOS and its RAM:

```sh
> ssh root@192.168.10.17 'dmidecode -q -t 1,0,17'
BIOS Information
        Vendor: Dell Inc.
        Version: 1.15.0
        Release Date: 09/16/2021
        Address: 0xF0000
        Runtime Size: 64 kB
        ROM Size: 32 MB
        Characteristics:
                PCI is supported
                PNP is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                Boot from CD is supported
                Selectable boot is supported
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
                Function key-initiated network boot is supported
                Targeted content distribution is supported
                UEFI is supported
        BIOS Revision: 1.15

System Information
        Manufacturer: Dell Inc.
        Product Name: OptiPlex 7060
        Version: Not Specified
        Serial Number: G50ZRZ2
        UUID: 4c4c4544-0035-3010-805a-c7c04f525a32
        Wake-up Type: Power Switch
        SKU Number: 085A
        Family: OptiPlex

Memory Device
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 8 GB
        Form Factor: SODIMM
        Set: None
        Locator: DIMM1
        Bank Locator: Not Specified
        Type: DDR4
        Type Detail: Synchronous
        Speed: 3200 MT/s
        Manufacturer: 802C0000802C
        Serial Number: 32EF027E
        Asset Tag: 06214700
        Part Number: 8ATF1G64HZ-3G2R1
        Rank: 1
        Configured Memory Speed: 2666 MT/s
        Minimum Voltage: Unknown
        Maximum Voltage: Unknown
        Configured Voltage: 1.2 V

Memory Device
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 8 GB
        Form Factor: SODIMM
        Set: None
        Locator: DIMM2
        Bank Locator: Not Specified
        Type: DDR4
        Type Detail: Synchronous
        Speed: 3200 MT/s
        Manufacturer: 802C0000802C
        Serial Number: 32EF0255
        Asset Tag: 06214700
        Part Number: 8ATF1G64HZ-3G2R1
        Rank: 1
        Configured Memory Speed: 2666 MT/s
        Minimum Voltage: Unknown
        Maximum Voltage: Unknown
        Configured Voltage: 1.2 V
```

## Relevant
