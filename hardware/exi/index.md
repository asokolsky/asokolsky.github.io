# exi

HTPC with GPU for gaming and playing k8s and, maybe, frigate.

## Hardware

Item|Description
----|----------
CPU|Intel Core i5-12400F Alder Lake 6C 12T 2.5GHz LGA1700 65W BX8071512400F
CPU Cooler|Cooler Master Hyper 212 EVO
CPU Fan|PWM 120x120x25 mm, 650-1800 rpm
Motherboard|ASRock B760M PRO RS LGA1700 MicroATX
RAM|Team Elite 16GB (2 x 8GB) DDR5 5200 (PC5 41600) TED516G5200C42DC016, 42-42-42-84 1.10V
M.2_0|Key E, supports type 2230 WiFi/BT PCIe WiFi module and Intel® CNVio/CNVio2
&nbsp;|Intel WiFi6 AX201 Bt 5.2
M.2_1|Key M, supports type 2242/2260/2280 PCIe Gen4x4 (64 Gb/s)
&nbsp;|500GB WD Blue SN550 NVMe SSD - Gen3x4 PCIe 8Gb/s, M.2 2280, 3D NAND WDS500G2B0C
M.2_2|Key M, supports type 2280 PCIe Gen4x4 (64 Gb/s)
&nbsp;|Edge TPU ML compute accelerator, CORAL TPU M.2 B+M
M.2_3|Key M, supports type 2280 PCIe Gen4x4 (64 Gb/s)
SATA|4 x SATA3 6.0 Gb/s Connectors
PCIe1|PCIe 5.0 x16 slot, supports x16 mode
&nbsp;|MSI Ventus GeForce RTX 3050 8GB GDDR6 PCIx 4.0 x8, HDMI 2.1, DP v1.4a 115W
PCIe2|PCIe 3.0 x16 slot, supports x4 mode
Ethernet|onboard RTL8125BG
BIOS|3.04
Case|Antec
PSU|SeaSonic SS-400FL2 Active PFC F3 400W 80 PLUS Platinum Fanless ATX12V / EPS12V
OS|Ubuntu Studio 23.10
Monitor|Samsung QN75Q80TAFXZA
Speakers|SAMSUNG HW-Q950T 9.1.4 Soundbar + Sub + Surrounds

<p align="center" width="100%">
    <img width="100%" src="front.jpg">
    <img width="100%" src="top.jpg">
</p>

## PCIe Devices

```
> lspci -nnkq
00:00.0 Host bridge [0600]: Intel Corporation 12th Gen Core Processor Host Bridge [8086:4650] (rev 02)
	Subsystem: ASRock Incorporation Device [1849:4650]
00:01.0 PCI bridge [0604]: Intel Corporation 12th Gen Core Processor PCI Express x16 Controller #1 [8086:460d] (rev 02)
	Subsystem: ASRock Incorporation 12th Gen Core Processor PCI Express x16 Controller [1849:460d]
	Kernel driver in use: pcieport
00:06.0 PCI bridge [0604]: Intel Corporation 12th Gen Core Processor PCI Express x4 Controller #0 [8086:464d] (rev 02)
	Kernel driver in use: pcieport
00:08.0 System peripheral [0880]: Intel Corporation 12th Gen Core Processor Gaussian & Neural Accelerator [8086:464f] (rev 02)
	Subsystem: ASRock Incorporation 12th Gen Core Processor Gaussian & Neural Accelerator [1849:464f]
00:0e.0 RAID bus controller [0104]: Intel Corporation Volume Management Device NVMe RAID Controller [8086:467f]
	Subsystem: Intel Corporation Volume Management Device NVMe RAID Controller [8086:0000]
	Kernel driver in use: vmd
	Kernel modules: vmd
00:14.0 USB controller [0c03]: Intel Corporation Raptor Lake USB 3.2 Gen 2x2 (20 Gb/s) XHCI Host Controller [8086:7a60] (rev 11)
	Subsystem: ASRock Incorporation Device [1849:7a60]
	Kernel driver in use: xhci_hcd
	Kernel modules: mei_me, xhci_pci
00:14.2 RAM memory [0500]: Intel Corporation Raptor Lake-S PCH Shared SRAM [8086:7a27] (rev 11)
00:14.3 Network controller [0280]: Intel Corporation Raptor Lake-S PCH CNVi WiFi [8086:7a70] (rev 11)
	Subsystem: Intel Corporation Device [8086:4070]
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi
00:15.0 Serial bus controller [0c80]: Intel Corporation Raptor Lake Serial IO I2C Host Controller #0 [8086:7a4c] (rev 11)
	Subsystem: ASRock Incorporation Device [1849:7a4c]
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci
00:16.0 Communication controller [0780]: Intel Corporation Raptor Lake CSME HECI #1 [8086:7a68] (rev 11)
	Subsystem: ASRock Incorporation Device [1849:7a68]
	Kernel driver in use: mei_me
	Kernel modules: mei_me
00:17.0 SATA controller [0106]: Intel Corporation Raptor Lake SATA AHCI Controller [8086:7a62] (rev 11)
	Subsystem: ASRock Incorporation Device [1849:7a62]
	Kernel driver in use: ahci
	Kernel modules: ahci
00:1c.0 PCI bridge [0604]: Intel Corporation Raptor Lake PCI Express Root Port #1 [8086:7a38] (rev 11)
	Subsystem: ASRock Incorporation Device [1849:7a38]
	Kernel driver in use: pcieport
00:1c.4 PCI bridge [0604]: Intel Corporation Device [8086:7a3c] (rev 11)
	Subsystem: ASRock Incorporation Device [1849:7a3c]
	Kernel driver in use: pcieport
00:1d.0 PCI bridge [0604]: Intel Corporation Device [8086:7a36] (rev 11)
	Subsystem: ASRock Incorporation Device [1849:7a36]
	Kernel driver in use: pcieport
00:1f.0 ISA bridge [0601]: Intel Corporation Device [8086:7a06] (rev 11)
	Subsystem: ASRock Incorporation Device [1849:7a06]
00:1f.3 Audio device [0403]: Intel Corporation Raptor Lake High Definition Audio Controller [8086:7a50] (rev 11)
	Subsystem: ASRock Incorporation Device [1849:1897]
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel, snd_sof_pci_intel_tgl
00:1f.4 SMBus [0c05]: Intel Corporation Raptor Lake-S PCH SMBus Controller [8086:7a23] (rev 11)
	Subsystem: ASRock Incorporation Device [1849:7a23]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c_i801
00:1f.5 Serial bus controller [0c80]: Intel Corporation Raptor Lake SPI (flash) Controller [8086:7a24] (rev 11)
	Subsystem: ASRock Incorporation Device [1849:7a24]
	Kernel driver in use: intel-spi
	Kernel modules: spi_intel_pci
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GA106 [Geforce RTX 3050] [10de:2507] (rev a1)
	Subsystem: Micro-Star International Co., Ltd. [MSI] GA106 [Geforce RTX 3050] [1462:c978]
	Kernel driver in use: nvidia
	Kernel modules: nvidiafb, nouveau, nvidia_drm, nvidia
01:00.1 Audio device [0403]: NVIDIA Corporation GA106 High Definition Audio Controller [10de:228e] (rev a1)
	Subsystem: Micro-Star International Co., Ltd. [MSI] GA106 High Definition Audio Controller [1462:c978]
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel
02:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009] (rev 01)
	Subsystem: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009]
	Kernel driver in use: nvme
	Kernel modules: nvme
03:00.0 SATA controller [0106]: ASMedia Technology Inc. ASM1064 Serial ATA Controller [1b21:1064] (rev 02)
	Subsystem: ZyDAS Technology Corp. Device [2116:2116]
	Kernel driver in use: ahci
	Kernel modules: ahci
04:00.0 System peripheral [0880]: Global Unichip Corp. Coral Edge TPU [1ac1:089a]
	Subsystem: Global Unichip Corp. Coral Edge TPU [1ac1:089a]
	Kernel driver in use: apex
	Kernel modules: apex
05:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller [10ec:8125] (rev 05)
	Subsystem: ASRock Incorporation RTL8125 2.5GbE Controller [1849:8125]
	Kernel driver in use: r8169
	Kernel modules: r8169
```

## USB

```
alex@exi > lsusb
Bus 002 Device 002: ID 174c:3074 ASMedia Technology Inc. ASM1074 SuperSpeed hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 004: ID a604:0715 2.4G Composite Devic Wireless Devic
Bus 001 Device 003: ID 046d:c548 Logitech, Inc. Logi Bolt Receiver
Bus 001 Device 002: ID 174c:2074 ASMedia Technology Inc. ASM1074 High-Speed hub
Bus 001 Device 006: ID 8087:0026 Intel Corp. AX201 Bluetooth
Bus 001 Device 005: ID 26ce:01a2 ASRock LED Controller
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

## Power Consumption

While serving a single video stream over SMB and with CPU consumption <4%: 88W
