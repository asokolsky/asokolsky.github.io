# EXI PCIe Devices

```
root@exi > lspci -nnkq
00:00.0 Host bridge [0600]: Intel Corporation 12th Gen Core Processor Host Bridge [8086:4650] (rev 02)
	Subsystem: ASRock Incorporation Device [1849:4650]
00:01.0 PCI bridge [0604]: Intel Corporation 12th Gen Core Processor PCI Express x16 Controller #1 [8086:460d] (rev 02)
	Subsystem: ASRock Incorporation 12th Gen Core Processor PCI Express x16 Controller [1849:460d]
	Kernel driver in use: pcieport
00:06.0 PCI bridge [0604]: Intel Corporation 12th Gen Core Processor PCI Express x4 Controller #0 [8086:464d] (rev 02)
	Kernel driver in use: pcieport
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
00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:7a3c] (rev 11)
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
02:00.0 Non-Volatile memory controller [0108]: Sandisk Corp SanDisk Ultra 3D / WD Blue SN550 NVMe SSD [15b7:5009] (rev 01)
	Subsystem: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009]
	Kernel driver in use: nvme
	Kernel modules: nvme
03:00.0 System peripheral [0880]: Global Unichip Corp. Coral Edge TPU [1ac1:089a]
	Subsystem: Global Unichip Corp. Coral Edge TPU [1ac1:089a]
04:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller [10ec:8125] (rev 05)
	Subsystem: ASRock Incorporation RTL8125 2.5GbE Controller [1849:8125]
	Kernel driver in use: r8169
	Kernel modules: r8169
```
