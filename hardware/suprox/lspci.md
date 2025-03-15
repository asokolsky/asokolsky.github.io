# Suprox PCIe Devices

```
root@suprox:~# lspci -nnk
00:00.0 Host bridge [0600]: Intel Corporation 8th Gen Core 4-core Desktop Processor Host Bridge/DRAM Registers [Coffee Lake S] [8086:3e1f] (rev 08)
	Subsystem: Super Micro Computer Inc 8th Gen Core 4-core Desktop Processor Host Bridge/DRAM Registers [Coffee Lake S] [15d9:1b0e]
	Kernel driver in use: skl_uncore
	Kernel modules: ie31200_edac
00:01.0 PCI bridge [0604]: Intel Corporation 6th-10th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 08)
	Subsystem: Super Micro Computer Inc 6th-10th Gen Core Processor PCIe Controller (x16) [15d9:1b0e]
	Kernel driver in use: pcieport
00:08.0 System peripheral [0880]: Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v5 / 6th/7th/8th Gen Core Processor Gaussian Mixture Model [8086:1911]
	Subsystem: Super Micro Computer Inc Xeon E3-1200 v5/v6 / E3-1500 v5 / 6th/7th/8th Gen Core Processor Gaussian Mixture Model [15d9:1b0e]
00:12.0 Signal processing controller [1180]: Intel Corporation Cannon Lake PCH Thermal Controller [8086:a379] (rev 10)
	Subsystem: Super Micro Computer Inc Cannon Lake PCH Thermal Controller [15d9:1b0e]
	Kernel driver in use: intel_pch_thermal
	Kernel modules: intel_pch_thermal
00:14.0 USB controller [0c03]: Intel Corporation Cannon Lake PCH USB 3.1 xHCI Host Controller [8086:a36d] (rev 10)
	Subsystem: Super Micro Computer Inc Cannon Lake PCH USB 3.1 xHCI Host Controller [15d9:1b0e]
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci
00:14.2 RAM memory [0500]: Intel Corporation Cannon Lake PCH Shared SRAM [8086:a36f] (rev 10)
	Subsystem: Intel Corporation Cannon Lake PCH Shared SRAM [8086:7270]
00:15.0 Serial bus controller [0c80]: Intel Corporation Cannon Lake PCH Serial IO I2C Controller #0 [8086:a368] (rev 10)
	Subsystem: Super Micro Computer Inc Cannon Lake PCH Serial IO I2C Controller [15d9:1b0e]
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci
00:15.1 Serial bus controller [0c80]: Intel Corporation Cannon Lake PCH Serial IO I2C Controller #1 [8086:a369] (rev 10)
	Subsystem: Super Micro Computer Inc Cannon Lake PCH Serial IO I2C Controller [15d9:1b0e]
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci
00:16.0 Communication controller [0780]: Intel Corporation Cannon Lake PCH HECI Controller [8086:a360] (rev 10)
	Subsystem: Super Micro Computer Inc Cannon Lake PCH HECI Controller [15d9:1b0e]
	Kernel modules: mei_me
00:16.4 Communication controller [0780]: Intel Corporation Cannon Lake PCH HECI Controller #2 [8086:a364] (rev 10)
	Subsystem: Super Micro Computer Inc Cannon Lake PCH HECI Controller [15d9:1b0e]
	Kernel modules: mei_me
00:17.0 SATA controller [0106]: Intel Corporation Cannon Lake PCH SATA AHCI Controller [8086:a352] (rev 10)
	Subsystem: Super Micro Computer Inc Cannon Lake PCH SATA AHCI Controller [15d9:1b0e]
	Kernel driver in use: vfio-pci
	Kernel modules: ahci
00:1b.0 PCI bridge [0604]: Intel Corporation Cannon Lake PCH PCI Express Root Port #22 [8086:a32d] (rev f0)
	Subsystem: Intel Corporation Cannon Lake PCH PCI Express Root Port [8086:7270]
	Kernel driver in use: pcieport
00:1b.6 PCI bridge [0604]: Intel Corporation Cannon Lake PCH PCI Express Root Port #23 [8086:a32e] (rev f0)
	Subsystem: Intel Corporation Cannon Lake PCH PCI Express Root Port [8086:7270]
	Kernel driver in use: pcieport
00:1c.0 PCI bridge [0604]: Intel Corporation Cannon Lake PCH PCI Express Root Port #1 [8086:a338] (rev f0)
	Subsystem: Super Micro Computer Inc Cannon Lake PCH PCI Express Root Port [15d9:1b0e]
	Kernel driver in use: pcieport
00:1c.1 PCI bridge [0604]: Intel Corporation Cannon Lake PCH PCI Express Root Port #2 [8086:a339] (rev f0)
	Subsystem: Super Micro Computer Inc Cannon Lake PCH PCI Express Root Port [15d9:1b0e]
	Kernel driver in use: pcieport
00:1d.0 PCI bridge [0604]: Intel Corporation Cannon Lake PCH PCI Express Root Port #9 [8086:a330] (rev f0)
	Subsystem: Super Micro Computer Inc Cannon Lake PCH PCI Express Root Port [15d9:1b0e]
	Kernel driver in use: pcieport
00:1e.0 Communication controller [0780]: Intel Corporation Cannon Lake PCH Serial IO UART Host Controller [8086:a328] (rev 10)
	Subsystem: Super Micro Computer Inc Cannon Lake PCH Serial IO UART Host Controller [15d9:1b0e]
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci
00:1f.0 ISA bridge [0601]: Intel Corporation Device [8086:a30a] (rev 10)
	Subsystem: Super Micro Computer Inc Device [15d9:1b0e]
00:1f.4 SMBus [0c05]: Intel Corporation Cannon Lake PCH SMBus Controller [8086:a323] (rev 10)
	Subsystem: Super Micro Computer Inc Cannon Lake PCH SMBus Controller [15d9:1b0e]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c_i801
00:1f.5 Serial bus controller [0c80]: Intel Corporation Cannon Lake PCH SPI Controller [8086:a324] (rev 10)
	Subsystem: Super Micro Computer Inc Cannon Lake PCH SPI Controller [15d9:1b0e]
	Kernel driver in use: intel-spi
	Kernel modules: spi_intel_pci
01:00.0 Ethernet controller [0200]: Intel Corporation I350 Gigabit Network Connection [8086:1521] (rev 01)
	Subsystem: Intel Corporation Ethernet Server Adapter I350-T2 [8086:00a2]
	Kernel driver in use: vfio-pci
	Kernel modules: igb
01:00.1 Ethernet controller [0200]: Intel Corporation I350 Gigabit Network Connection [8086:1521] (rev 01)
	Subsystem: Intel Corporation Ethernet Server Adapter I350-T2 [8086:00a2]
	Kernel driver in use: vfio-pci
	Kernel modules: igb
02:00.0 Ethernet controller [0200]: Intel Corporation I210 Gigabit Network Connection [8086:1533] (rev 03)
	DeviceName:  Intel Ethernet I210 #1
	Subsystem: Super Micro Computer Inc I210 Gigabit Network Connection [15d9:1533]
	Kernel driver in use: igb
	Kernel modules: igb
03:00.0 Ethernet controller [0200]: Intel Corporation I210 Gigabit Network Connection [8086:1533] (rev 03)
	DeviceName:  Intel Ethernet I210 #2
	Subsystem: Super Micro Computer Inc I210 Gigabit Network Connection [15d9:1533]
	Kernel driver in use: igb
	Kernel modules: igb
05:00.0 PCI bridge [0604]: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge [1a03:1150] (rev 04)
	Subsystem: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge [1a03:1150]
06:00.0 VGA compatible controller [0300]: ASPEED Technology, Inc. ASPEED Graphics Family [1a03:2000] (rev 41)
	DeviceName:  ASPEED Video AST2500
	Subsystem: Super Micro Computer Inc ASPEED Graphics Family [15d9:1b0e]
	Kernel driver in use: ast
	Kernel modules: ast
07:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009] (rev 01)
	Subsystem: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009]
	Kernel driver in use: nvme
	Kernel modules: nvme
```
