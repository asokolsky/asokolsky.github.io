# EXI USB Devices

```
alex@exi > lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 174c:2074 ASMedia Technology Inc. ASM1074 High-Speed hub
Bus 001 Device 003: ID 0764:0501 Cyber Power System, Inc. CP1500 AVR UPS
Bus 001 Device 004: ID 05e3:0610 Genesys Logic, Inc. Hub
Bus 001 Device 005: ID 0bda:0301 Realtek Semiconductor Corp. multicard reader
Bus 001 Device 006: ID 1bcf:0b16 Sunplus Innovation Technology Inc. UC40M Audio
Bus 001 Device 008: ID 214b:7250 Huasheng Electronics USB2.0 HUB
Bus 001 Device 009: ID 26ce:01a2 ASRock LED Controller
Bus 001 Device 010: ID 046d:c52b Logitech, Inc. Unifying Receiver
Bus 001 Device 011: ID 8087:0026 Intel Corp. AX201 Bluetooth
Bus 001 Device 012: ID 05ac:024f Apple, Inc. Aluminium Keyboard (ANSI)
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 002 Device 002: ID 174c:3074 ASMedia Technology Inc. ASM1074 SuperSpeed hub
```

```
alex@exi > lsusb -t
/:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/16p, 480M
    |__ Port 002: Dev 002, If 0, Class=Hub, Driver=hub/4p, 480M
        |__ Port 004: Dev 004, If 0, Class=Hub, Driver=hub/4p, 480M
            |__ Port 002: Dev 006, If 0, Class=Video, Driver=uvcvideo, 480M
            |__ Port 002: Dev 006, If 1, Class=Video, Driver=uvcvideo, 480M
            |__ Port 002: Dev 006, If 2, Class=Audio, Driver=snd-usb-audio, 480M
            |__ Port 002: Dev 006, If 3, Class=Audio, Driver=snd-usb-audio, 480M
            |__ Port 004: Dev 008, If 0, Class=Hub, Driver=hub/4p, 480M
                |__ Port 001: Dev 010, If 0, Class=Human Interface Device, Driver=usbhid, 12M
                |__ Port 001: Dev 010, If 1, Class=Human Interface Device, Driver=usbhid, 12M
                |__ Port 001: Dev 010, If 2, Class=Human Interface Device, Driver=usbhid, 12M
                |__ Port 004: Dev 012, If 0, Class=Human Interface Device, Driver=usbhid, 12M
                |__ Port 004: Dev 012, If 1, Class=Human Interface Device, Driver=usbhid, 12M
    |__ Port 004: Dev 003, If 0, Class=Human Interface Device, Driver=usbfs, 1.5M
    |__ Port 005: Dev 005, If 0, Class=Mass Storage, Driver=usb-storage, 480M
    |__ Port 011: Dev 009, If 0, Class=Human Interface Device, Driver=usbhid, 12M
    |__ Port 014: Dev 011, If 0, Class=Wireless, Driver=btusb, 12M
    |__ Port 014: Dev 011, If 1, Class=Wireless, Driver=btusb, 12M
/:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/10p, 20000M/x2
    |__ Port 003: Dev 002, If 0, Class=Hub, Driver=hub/4p, 5000M
```
