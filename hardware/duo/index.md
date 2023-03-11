# duo

Runs an HTPC VM with GPU passed through.

Item|Description
----|----------
CPU|Intel i5-9400 6C/6T 2.90 GHz up to 4.10 GHz Turbo LGA1151 65W BX80684I59400
CPU Fan|Noctua NF-P14s redux-1200 PWM, Quiet Fan, 4-Pin, 1200rpm
CPU Cooler|Cooler Master GeminII S524 Version 2 with 5 Direct Contact Heat Pipes (RR-G5V2-20PK-R1)
Motherboard|ASRock Z370M-ITX/ac LGA 1151 (300 Series) Intel Z370 HDMI SATA 6Gb/s USB 3.1 Mini ITX
RAM|ADATA XPG Z1 DDR4 PC4 25600 3200MHz 2x8GB AX4U320038G16A-DSZ1
Ethernet|I219-V, I211
Graphics|Intel UHD Graphics 630
GPU|MSI Graphic Cards GeForce GT 1030  2GB GDDR5 LP OC HDMI 2.0b / DisplayPort V1.4
SSD|500GB WD Blue SN550 NVMe M.2 2280, 3D NAND, Up to 2,400 MB/s - WDS500G2B0C
PSU|SeaSonic SS-400FL2 Active PFC F3 400W 80 PLUS Platinum Fanless ATX12V / EPS12V
Case|Antec
OS|ProxMox, Ubuntu
Monitor|Samsung QN75Q80TAFXZA
Speakers|SAMSUNG HW-Q950T 9.1.4 Soundbar + Sub + Surrounds



* [front](front.jpg)
* [top](top.jpg)


## PCI

```
root@duo:~# lspci
00:00.0 Host bridge: Intel Corporation 8th Gen Core Processor Host Bridge/DRAM Registers (rev 07)
00:01.0 PCI bridge: Intel Corporation 6th-10th Gen Core Processor PCIe Controller (x16) (rev 07)
00:02.0 VGA compatible controller: Intel Corporation CometLake-S GT2 [UHD Graphics 630]
00:14.0 USB controller: Intel Corporation 200 Series/Z370 Chipset Family USB 3.0 xHCI Controller
00:14.2 Signal processing controller: Intel Corporation 200 Series PCH Thermal Subsystem
00:16.0 Communication controller: Intel Corporation 200 Series PCH CSME HECI #1
00:1c.0 PCI bridge: Intel Corporation 200 Series PCH PCI Express Root Port #1 (rev f0)
00:1c.5 PCI bridge: Intel Corporation 200 Series PCH PCI Express Root Port #6 (rev f0)
00:1d.0 PCI bridge: Intel Corporation 200 Series PCH PCI Express Root Port #9 (rev f0)
00:1f.0 ISA bridge: Intel Corporation Z370 Chipset LPC/eSPI Controller
00:1f.2 Memory controller: Intel Corporation 200 Series/Z370 Chipset Family Power Management Controller
00:1f.3 Audio device: Intel Corporation 200 Series PCH HD Audio
00:1f.4 SMBus: Intel Corporation 200 Series/Z370 Chipset Family SMBus Controller
00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (2) I219-V
01:00.0 VGA compatible controller: NVIDIA Corporation GP108 [GeForce GT 1030] (rev a1)
01:00.1 Audio device: NVIDIA Corporation GP108 High Definition Audio Controller (rev a1)
03:00.0 Ethernet controller: Intel Corporation I211 Gigabit Network Connection (rev 03)
04:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue SN550 NVMe SSD (rev 01)
```

## USB

```
root@duo:~# lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 003: ID 046d:c52b Logitech, Inc. Unifying Receiver
Bus 001 Device 002: ID 0471:0815 Philips (or NXP) eHome Infrared Receiver
Bus 001 Device 004: ID 1bcf:28c4 Sunplus Innovation Technology Inc. FHD Camera Microphone
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

## VMs

[htpc](htpc.html)
