# latitude USB Devices

```
alex@latitude7490:~$ lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 0bda:58ca Realtek Semiconductor Corp. Integrated_Webcam_HD
Bus 001 Device 003: ID 8087:0032 Intel Corp. AX210 Bluetooth
Bus 001 Device 004: ID 046d:c52b Logitech, Inc. Unifying Receiver
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
```

Device tree:
```
alex@latitude7490:~$ lsusb -tv
/:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/12p, 480M
    ID 1d6b:0002 Linux Foundation 2.0 root hub
    |__ Port 005: Dev 002, If 0, Class=Video, Driver=uvcvideo, 480M
        ID 0bda:58ca Realtek Semiconductor Corp. 
    |__ Port 005: Dev 002, If 1, Class=Video, Driver=uvcvideo, 480M
        ID 0bda:58ca Realtek Semiconductor Corp. 
    |__ Port 005: Dev 002, If 2, Class=Video, Driver=uvcvideo, 480M
        ID 0bda:58ca Realtek Semiconductor Corp. 
    |__ Port 005: Dev 002, If 3, Class=Video, Driver=uvcvideo, 480M
        ID 0bda:58ca Realtek Semiconductor Corp. 
    |__ Port 007: Dev 003, If 0, Class=Wireless, Driver=btusb, 12M
        ID 8087:0032 Intel Corp. AX210 Bluetooth
    |__ Port 007: Dev 003, If 1, Class=Wireless, Driver=btusb, 12M
        ID 8087:0032 Intel Corp. AX210 Bluetooth
    |__ Port 009: Dev 004, If 0, Class=Human Interface Device, Driver=usbhid, 12M
        ID 046d:c52b Logitech, Inc. Unifying Receiver
    |__ Port 009: Dev 004, If 1, Class=Human Interface Device, Driver=usbhid, 12M
        ID 046d:c52b Logitech, Inc. Unifying Receiver
    |__ Port 009: Dev 004, If 2, Class=Human Interface Device, Driver=usbhid, 12M
        ID 046d:c52b Logitech, Inc. Unifying Receiver
/:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/6p, 5000M
    ID 1d6b:0003 Linux Foundation 3.0 root hub

```
