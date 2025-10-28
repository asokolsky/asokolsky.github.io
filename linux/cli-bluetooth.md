# Linux BlueTooth CLI

[wiki.archlinux.org/title/Bluetooth](https://wiki.archlinux.org/title/Bluetooth)

## hciconfig

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

HCI version | Bluetooth version |
------------|-------------------|
0 (0x0)  |1.0b
1 (0x1)  |1.1
2 (0x2)  |1.2
3 (0x3)  |2.0
4 (0x4)  |2.1
5 (0x5)  |3.0
6 (0x6)  |4.0
7 (0x7)  |4.1
8 (0x8)  |4.2
9 (0x9)  |5.0
10 (0xa) |5.1
11 (0xb) |5.2
12 (0xc) |5.3
13 (0xd) |5.4

The above table is taken from Section 2.1 of
[BT Assigned Numbers Doc](https://btprodspecificationrefs.blob.core.windows.net/assigned-numbers/Assigned%20Number%20Types/Assigned_Numbers.pdf).


`hciconfig` has been [deprecated](https://github.com/chrippa/ds4drv/issues/123).
Use [btmgmt](https://manpages.debian.org/testing/bluez/btmgmt.1.en.html) and
[bluetoothctl](https://manpages.debian.org/testing/bluez/bluetoothctl.1.en.html)
instead, which are part of [bluez](http://www.bluez.org/) stack.

## bluetoothctl

[man page](https://manpages.ubuntu.com/manpages/questing/en/man1/bluetoothctl.1.html)

Useful commands:

* show
* devices
* scan on/off/bredr/le
* connect


Example:
```
> bluetoothctl
Agent registered to bluetoothd...[bluetooth]#         MX Master 2S
[MX Master 2S]# scan on
[MX Master 2S]# SetDiscoveryFilter success
[MX Master 2S]# Discovery started
[MX Master 2S]# [CHG] Controller 10:F6:0A:79:99:32 Discovering: yes
[MX Master 2S]# [NEW] Device EC:FA:5C:EA:26:0B MIBOX4
[MX Master 2S]# [NEW] Device FA:B4:6A:CC:FB:6A OfficeJet 5200 series
[MX Master 2S]# [NEW] Device 5B:5B:37:47:1F:79 5B-5B-37-47-1F-79

[MX MCHNCL M]# show
Controller 10:F6:0A:79:99:32 (public)
        Manufacturer: 0x0002 (2)
        Version: 0x0c (12)
        Name: t14g3
        Alias: t14g3
        Class: 0x007c010c (8126732)
        Powered: yes
        Discoverable: yes
        DiscoverableTimeout: 0x00000000 (0)
        Pairable: yes
        UUID: Message Notification Se.. (00001133-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
        UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9b34fb)
        UUID: Message Access Server     (00001132-0000-1000-8000-00805f9b34fb)
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
        UUID: IrMC Sync                 (00001104-0000-1000-8000-00805f9b34fb)
        UUID: Vendor specific           (00005005-0000-1000-8000-0002ee000001)
        UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
        UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
        UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9b34fb)
        UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
        UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
        UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
        UUID: Handsfree Audio Gateway   (0000111f-0000-1000-8000-00805f9b34fb)
        UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
        UUID: OBEX File Transfer        (00001106-0000-1000-8000-00805f9b34fb)
        UUID: Handsfree                 (0000111e-0000-1000-8000-00805f9b34fb)
        Modalias: usb:v1D6Bp0246d0548
        Discovering: no
        Roles: central
        Roles: peripheral
Advertising Features:
        ActiveInstances: 0x00 (0)
        SupportedInstances: 0x0c (12)
        SupportedIncludes: tx-power
        SupportedIncludes: appearance
        SupportedIncludes: local-name
        SupportedSecondaryChannels: 1M
        SupportedSecondaryChannels: 2M
        SupportedSecondaryChannels: Coded

[MX MCHNCL M]# devices
Device D9:40:18:F2:CD:BA MX MCHNCL M
Device CF:1D:A8:EF:7E:39 MX Master 2S
```
