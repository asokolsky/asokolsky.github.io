```
alex@duo > lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 0bda:5409 Realtek Semiconductor Corp. USB2.1 Hub
Bus 001 Device 003: ID 8087:0aa7 Intel Corp. Wireless-AC 3168 Bluetooth
Bus 001 Device 004: ID c0f4:08f5 Usb KeyBoard Usb KeyBoard
Bus 001 Device 006: ID 0bda:1100 Realtek Semiconductor Corp. HID Device
Bus 001 Device 007: ID 046d:c52b Logitech, Inc. Unifying Receiver
Bus 001 Device 008: ID 05ac:024f Apple, Inc. Aluminium Keyboard (ANSI)
Bus 001 Device 010: ID 1686:0575 ZOOM Corporation ZOOM P4 Audio
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 002 Device 002: ID 0bda:0409 Realtek Semiconductor Corp. USB3.2 Hub
Bus 002 Device 003: ID 328f:009b EMEET EMEET SmartCam S800
```

```
alex@duo > lsusb -t
/:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/16p, 480M
    |__ Port 004: Dev 008, If 0, Class=Human Interface Device, Driver=usbhid, 12M
    |__ Port 004: Dev 008, If 1, Class=Human Interface Device, Driver=usbhid, 12M
    |__ Port 008: Dev 002, If 0, Class=Hub, Driver=hub/5p, 480M
        |__ Port 001: Dev 004, If 0, Class=Human Interface Device, Driver=usbhid, 1.5M
        |__ Port 001: Dev 004, If 1, Class=Human Interface Device, Driver=usbhid, 1.5M
        |__ Port 002: Dev 010, If 0, Class=Audio, Driver=snd-usb-audio, 12M
        |__ Port 002: Dev 010, If 1, Class=Audio, Driver=snd-usb-audio, 12M
        |__ Port 002: Dev 010, If 2, Class=Audio, Driver=snd-usb-audio, 12M
        |__ Port 004: Dev 007, If 0, Class=Human Interface Device, Driver=usbhid, 12M
        |__ Port 004: Dev 007, If 1, Class=Human Interface Device, Driver=usbhid, 12M
        |__ Port 004: Dev 007, If 2, Class=Human Interface Device, Driver=usbhid, 12M
        |__ Port 005: Dev 006, If 0, Class=Human Interface Device, Driver=usbhid, 480M
    |__ Port 013: Dev 003, If 0, Class=Wireless, Driver=btusb, 12M
    |__ Port 013: Dev 003, If 1, Class=Wireless, Driver=btusb, 12M
/:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/10p, 5000M
    |__ Port 004: Dev 002, If 0, Class=Hub, Driver=hub/4p, 5000M
    |__ Port 006: Dev 003, If 0, Class=Video, Driver=uvcvideo, 5000M
    |__ Port 006: Dev 003, If 1, Class=Video, Driver=uvcvideo, 5000M
    |__ Port 006: Dev 003, If 2, Class=Audio, Driver=snd-usb-audio, 5000M
    |__ Port 006: Dev 003, If 3, Class=Audio, Driver=snd-usb-audio, 5000M
    |__ Port 006: Dev 003, If 4, Class=Human Interface Device, Driver=usbhid, 5000M
    |__ Port 006: Dev 003, If 5, Class=Communications, Driver=cdc_acm, 5000M
    |__ Port 006: Dev 003, If 6, Class=CDC Data, Driver=cdc_acm, 5000M
 ```
