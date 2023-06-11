# Linux BlueTooth CLI

[https://wiki.archlinux.org/title/Bluetooth](https://wiki.archlinux.org/title/Bluetooth)

## Install


## Use

```
alex@latitude7490:~/ > hciconfig -a
hci0:   Type: Primary  Bus: USB
        BD Address: 10:3D:1C:AF:63:C3  ACL MTU: 1021:4  SCO MTU: 96:6
        UP RUNNING
        RX bytes:32033 acl:0 sco:0 events:3074 errors:0
        TX bytes:645909 acl:0 sco:0 commands:2766 errors:0
        Features: 0xbf 0xfe 0x0f 0xfe 0xdb 0xff 0x7b 0x87
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH SNIFF
        Link mode: SLAVE ACCEPT
        Name: 'latitude7490'
        Class: 0x1c010c
        Service Classes: Rendering, Capturing, Object Transfer
        Device Class: Computer, Laptop
        HCI Version:  (0xb)  Revision: 0x35af
        LMP Version:  (0xb)  Subversion: 0x35af
        Manufacturer: Intel Corp. (2)
```
Bluetooth version can be deduced from HCI version:

| HCI version | Bluetooth version |
|-------------|-------------------|
| 0 (0x0)     | 1.0b              |
| 1 (0x1)     | 1.1               |
| 2 (0x2)     | 1.2               |
| 3 (0x3)     | 2.0               |
| 4 (0x4)     | 2.1               |
| 5 (0x5)     | 3.0               |
| 6 (0x6)     | 4.0               |
| 7 (0x7)     | 4.1               |
| 8 (0x8)     | 4.2               |
| 9 (0x9)     | 5.0               |
| 10 (0xa)    | 5.1               |
| 10 (0xb)    | 5.2               |
