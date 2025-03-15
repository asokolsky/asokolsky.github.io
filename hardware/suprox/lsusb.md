# Suprox USB Devices

```
root@suprox:~# lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 005: ID 0c45:636b Microdia USB  Live camera
Bus 001 Device 004: ID 2c99:0002 Prusa Original Prusa i3 MK3
Bus 001 Device 003: ID 1bcf:28c4 Sunplus Innovation Technology Inc. FHD Camera Microphone
Bus 001 Device 007: ID 0557:2419 ATEN International Co., Ltd Virtual mouse/keyboard device
Bus 001 Device 006: ID 0557:7000 ATEN International Co., Ltd Hub
Bus 001 Device 002: ID 0764:0501 Cyber Power System, Inc. CP1500 AVR UPS
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

root@suprox:~# lsusb -t
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/6p, 10000M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/16p, 480M
    |__ Port 1: Dev 2, If 0, Class=Human Interface Device, Driver=usbfs, 1.5M
    |__ Port 2: Dev 3, If 2, Class=Audio, Driver=snd-usb-audio, 480M
    |__ Port 2: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
    |__ Port 2: Dev 3, If 3, Class=Audio, Driver=snd-usb-audio, 480M
    |__ Port 2: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
    |__ Port 7: Dev 4, If 0, Class=Communications, Driver=cdc_acm, 12M
    |__ Port 7: Dev 4, If 1, Class=CDC Data, Driver=cdc_acm, 12M
    |__ Port 8: Dev 5, If 3, Class=Audio, Driver=snd-usb-audio, 480M
    |__ Port 8: Dev 5, If 1, Class=Video, Driver=uvcvideo, 480M
    |__ Port 8: Dev 5, If 2, Class=Audio, Driver=snd-usb-audio, 480M
    |__ Port 8: Dev 5, If 0, Class=Video, Driver=uvcvideo, 480M
    |__ Port 14: Dev 6, If 0, Class=Hub, Driver=hub/4p, 480M
        |__ Port 1: Dev 7, If 0, Class=Human Interface Device, Driver=usbhid, 1.5M
        |__ Port 1: Dev 7, If 1, Class=Human Interface Device, Driver=usbhid, 1.5M
```
