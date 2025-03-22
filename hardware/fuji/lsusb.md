# Fuji USB Devices

```
root@fuji:~# lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 002: ID 051d:0002 American Power Conversion Uninterruptible Power Supply
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

root@fuji:~# lsusb -t
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/10p, 5000M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/16p, 480M
    |__ Port 7: Dev 2, If 0, Class=Human Interface Device, Driver=usbfs, 12M
```
