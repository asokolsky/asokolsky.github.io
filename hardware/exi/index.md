# exi

Virtualization server with GPU and [HBA](../hba-lsi.html) passed through.

## Hardware

Item|Description
----|----------
CPU|Intel Core i5-12400F Alder Lake 6C 12T 2.5GHz LGA1700 65W BX8071512400F
CPU Cooler|Cooler Master Hyper 212 EVO
CPU Fan|PWM 120x120x25 mm, 650-1800 rpm
Motherboard|ASRock B760M PRO RS LGA1700 MicroATX
RAM|Team Elite 16GB (2 x 8GB) DDR5 5200 (PC5 41600) TED516G5200C42DC016, 42-42-42-84 1.10V
M.2_0|Key E, supports type 2230 WiFi/BT PCIe WiFi module and Intel® CNVio/CNVio2
M.2_1|Key M, supports type 2242/2260/2280 PCIe Gen4x4 (64 Gb/s), 500GB WD Blue SN550 NVMe SSD - Gen3x4 PCIe 8Gb/s, M.2 2280, 3D NAND WDS500G2B0C
M.2_2|Key M, supports type 2280 PCIe Gen4x4 (64 Gb/s)
M.2_3|Key M, supports type 2280 PCIe Gen4x4 (64 Gb/s)
SATA|4 x SATA3 6.0 Gb/s Connectors
PCIe1|PCIe 5.0 x16 Slot, supports x16 mode, ZOTAC GeForce GTX 750 Zone Edition 1 GB GDDR5 55W PCIe 3.0 ZT-70707-20M
PCIe2|PCIe 3.0 x16 Slot, supports x4 mode, HBA LSI SAS 9300-8i 8-port 12Gb/s SATA+SAS PCIe 3.0, 2x SFF-8643 mini-SAS, 13W
Ethernet|RTL8125BG, onboard
BIOS|3.04
Case|Fractal Design Define Mini Black Silent mATX
PSU|Seasonic FOCUS 450 Gold SSR-450FM 450W 80+ Gold ATX12V & EPS12V 140 mm PS
OS|Proxmox

## PCI

```
root@exi:~# lspci
00:00.0 Host bridge: Intel Corporation Device 4650 (rev 02)
00:01.0 PCI bridge: Intel Corporation 12th Gen Core Processor PCI Express x16 Controller #1 (rev 02)
00:06.0 PCI bridge: Intel Corporation 12th Gen Core Processor PCI Express x4 Controller #0 (rev 02)
00:14.0 USB controller: Intel Corporation Device 7a60 (rev 11)
00:14.2 RAM memory: Intel Corporation Device 7a27 (rev 11)
00:15.0 Serial bus controller: Intel Corporation Device 7a4c (rev 11)
00:16.0 Communication controller: Intel Corporation Device 7a68 (rev 11)
00:17.0 SATA controller: Intel Corporation Device 7a62 (rev 11)
00:1c.0 PCI bridge: Intel Corporation Device 7a38 (rev 11)
00:1d.0 PCI bridge: Intel Corporation Device 7a36 (rev 11)
00:1f.0 ISA bridge: Intel Corporation Device 7a06 (rev 11)
00:1f.3 Audio device: Intel Corporation Device 7a50 (rev 11)
00:1f.4 SMBus: Intel Corporation Device 7a23 (rev 11)
00:1f.5 Serial bus controller: Intel Corporation Device 7a24 (rev 11)
01:00.0 VGA compatible controller: NVIDIA Corporation GM107 [GeForce GTX 750] (rev a2)
01:00.1 Audio device: NVIDIA Corporation GM107 High Definition Audio Controller [GeForce 940MX] (rev a1)
02:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue SN550 NVMe SSD (rev 01)
03:00.0 Serial Attached SCSI controller: Broadcom / LSI SAS3008 PCI-Express Fusion-MPT SAS-3 (rev 02)
04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)
```

## USB

```
root@exi:~# lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 002 Device 002: ID 174c:3074 ASMedia Technology Inc. ASM1074 SuperSpeed hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 003: ID 26ce:01a2 ASRock LED Controller
Bus 001 Device 002: ID 174c:2074 ASMedia Technology Inc. ASM1074 High-Speed hub
```

## Power Consumption

While serving a single video stream over SMB and with CPU consumption <4%: 88W

## Update

Due to high power consumption, the server was immediately retired.  Components
were used to build a living room HTPC / gaming rig.
