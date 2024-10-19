# Video Streamer

This is [Dell Optiplex 7060 micro](../dell/optiplex7060micro.html) which I use for streaming and video recording.

## USB

Connected via USB:

* [Sony a7iv](../sony/a7iv.html)
* [Zoom Podtrack P4](../zoom/podtrack-p4.html)

```
alex@optiplex > sudo lsusb     
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 0bda:5409 Realtek Semiconductor Corp. USB2.1 Hub
Bus 001 Device 003: ID 1686:0575 ZOOM Corporation ZOOM P4 Audio
Bus 001 Device 004: ID 046d:c52b Logitech, Inc. Unifying Receiver
Bus 001 Device 005: ID 0bda:1100 Realtek Semiconductor Corp. HID Device
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 002 Device 002: ID 054c:0de7 Sony Corp. ILCE-7M4
Bus 002 Device 003: ID 0bda:0409 Realtek Semiconductor Corp. USB3.2 Hub

alex@optiplex > sudo lsusb -vt
/:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/16p, 480M
    ID 1d6b:0002 Linux Foundation 2.0 root hub
    |__ Port 006: Dev 002, If 0, Class=Hub, Driver=hub/5p, 480M
        ID 0bda:5409 Realtek Semiconductor Corp. 
        |__ Port 002: Dev 003, If 0, Class=Audio, Driver=snd-usb-audio, 12M
            ID 1686:0575 ZOOM Corporation 
        |__ Port 002: Dev 003, If 1, Class=Audio, Driver=snd-usb-audio, 12M
            ID 1686:0575 ZOOM Corporation 
        |__ Port 002: Dev 003, If 2, Class=Audio, Driver=snd-usb-audio, 12M
            ID 1686:0575 ZOOM Corporation 
        |__ Port 004: Dev 004, If 0, Class=Human Interface Device, Driver=usbhid, 12M
            ID 046d:c52b Logitech, Inc. Unifying Receiver
        |__ Port 004: Dev 004, If 1, Class=Human Interface Device, Driver=usbhid, 12M
            ID 046d:c52b Logitech, Inc. Unifying Receiver
        |__ Port 004: Dev 004, If 2, Class=Human Interface Device, Driver=usbhid, 12M
            ID 046d:c52b Logitech, Inc. Unifying Receiver
        |__ Port 005: Dev 005, If 0, Class=Human Interface Device, Driver=usbhid, 480M
            ID 0bda:1100 Realtek Semiconductor Corp. 
/:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/10p, 10000M
    ID 1d6b:0003 Linux Foundation 3.0 root hub
    |__ Port 002: Dev 002, If 0, Class=Audio, Driver=snd-usb-audio, 5000M
        ID 054c:0de7 Sony Corp. 
    |__ Port 002: Dev 002, If 1, Class=Audio, Driver=snd-usb-audio, 5000M
        ID 054c:0de7 Sony Corp. 
    |__ Port 002: Dev 002, If 2, Class=Video, Driver=uvcvideo, 5000M
        ID 054c:0de7 Sony Corp. 
    |__ Port 002: Dev 002, If 3, Class=Video, Driver=uvcvideo, 5000M
        ID 054c:0de7 Sony Corp. 
    |__ Port 006: Dev 003, If 0, Class=Hub, Driver=hub/4p, 5000M
        ID 0bda:0409 Realtek Semiconductor Corp. 
```

## PCI Devices

```
alex@optiplex > lspci
00:00.0 Host bridge: Intel Corporation 8th Gen Core Processor Host Bridge/DRAM Registers (rev 07)
00:02.0 VGA compatible controller: Intel Corporation CoffeeLake-S GT2 [UHD Graphics 630]
00:08.0 System peripheral: Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v5 / 6th/7th/8th Gen Core Processor Gaussian Mixture Model
00:12.0 Signal processing controller: Intel Corporation Cannon Lake PCH Thermal Controller (rev 10)
00:14.0 USB controller: Intel Corporation Cannon Lake PCH USB 3.1 xHCI Host Controller (rev 10)
00:14.2 RAM memory: Intel Corporation Cannon Lake PCH Shared SRAM (rev 10)
00:15.0 Serial bus controller: Intel Corporation Cannon Lake PCH Serial IO I2C Controller #0 (rev 10)
00:16.0 Communication controller: Intel Corporation Cannon Lake PCH HECI Controller (rev 10)
00:16.3 Serial controller: Intel Corporation Cannon Lake PCH Active Management Technology - SOL (rev 10)
00:17.0 SATA controller: Intel Corporation Cannon Lake PCH SATA AHCI Controller (rev 10)
00:1b.0 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root Port #17 (rev f0)
00:1f.0 ISA bridge: Intel Corporation Q370 Chipset LPC/eSPI Controller (rev 10)
00:1f.3 Audio device: Intel Corporation Cannon Lake PCH cAVS (rev 10)
00:1f.4 SMBus: Intel Corporation Cannon Lake PCH SMBus Controller (rev 10)
00:1f.5 Serial bus controller: Intel Corporation Cannon Lake PCH SPI Controller (rev 10)
00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (7) I219-LM (rev 10)
01:00.0 Non-Volatile memory controller: Intel Corporation SSD DC P4101/Pro 7600p/760p/E 6100p Series (rev 03)

alex@optiplex > lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda           8:0    0 232.9G  0 disk 
└─sda1        8:1    0 232.9G  0 part 
nvme0n1     259:0    0 238.5G  0 disk 
├─nvme0n1p1 259:1    0   512M  0 part /boot/efi
└─nvme0n1p2 259:2    0   238G  0 part /
```

## Apps

I run [OBS](/apps/obs/).
