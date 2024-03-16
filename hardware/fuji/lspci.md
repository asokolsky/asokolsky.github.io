# Fuji PCIe Devices

```
root@fuji:~# lspci -nnkq
00:00.0 Host bridge [0600]: Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers [8086:5918] (rev 05)
	Subsystem: Fujitsu Technology Solutions Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers [1734:1221]
	Kernel driver in use: skl_uncore
	Kernel modules: ie31200_edac
00:01.0 PCI bridge [0604]: Intel Corporation 6th-10th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 05)
	DeviceName: Slot 4
	Subsystem: Fujitsu Technology Solutions 6th-10th Gen Core Processor PCIe Controller (x16) [1734:1221]
	Kernel driver in use: pcieport
00:14.0 USB controller [0c03]: Intel Corporation 100 Series/C230 Series Chipset Family USB 3.0 xHCI Controller [8086:a12f] (rev 31)
	Subsystem: Fujitsu Technology Solutions 100 Series/C230 Series Chipset Family USB 3.0 xHCI Controller [1734:1222]
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci
00:14.2 Signal processing controller [1180]: Intel Corporation 100 Series/C230 Series Chipset Family Thermal Subsystem [8086:a131] (rev 31)
	Subsystem: Fujitsu Technology Solutions 100 Series/C230 Series Chipset Family Thermal Subsystem [1734:1222]
	Kernel driver in use: intel_pch_thermal
	Kernel modules: intel_pch_thermal
00:16.0 Communication controller [0780]: Intel Corporation 100 Series/C230 Series Chipset Family MEI Controller #1 [8086:a13a] (rev 31)
	Subsystem: Fujitsu Technology Solutions 100 Series/C230 Series Chipset Family MEI Controller [1734:1222]
	Kernel modules: mei_me
00:16.1 Communication controller [0780]: Intel Corporation 100 Series/C230 Series Chipset Family MEI Controller #2 [8086:a13b] (rev 31)
	Subsystem: Fujitsu Technology Solutions 100 Series/C230 Series Chipset Family MEI Controller [1734:1222]
	Kernel modules: mei_me
00:17.0 SATA controller [0106]: Intel Corporation Q170/Q150/B150/H170/H110/Z170/CM236 Chipset SATA Controller [AHCI Mode] [8086:a102] (rev 31)
	Subsystem: Fujitsu Technology Solutions Q170/Q150/B150/H170/H110/Z170/CM236 Chipset SATA Controller [AHCI Mode] [1734:1222]
	Kernel driver in use: vfio-pci
	Kernel modules: ahci
00:1c.0 PCI bridge [0604]: Intel Corporation 100 Series/C230 Series Chipset Family PCI Express Root Port #5 [8086:a114] (rev f1)
	DeviceName: Onboard PCH Unknown
	Subsystem: Fujitsu Technology Solutions 100 Series/C230 Series Chipset Family PCI Express Root Port [1734:1222]
	Kernel driver in use: pcieport
00:1c.5 PCI bridge [0604]: Intel Corporation 100 Series/C230 Series Chipset Family PCI Express Root Port #6 [8086:a115] (rev f1)
	DeviceName: Onboard LAN 1
	Subsystem: Fujitsu Technology Solutions 100 Series/C230 Series Chipset Family PCI Express Root Port [1734:1222]
	Kernel driver in use: pcieport
00:1c.6 PCI bridge [0604]: Intel Corporation 100 Series/C230 Series Chipset Family PCI Express Root Port #7 [8086:a116] (rev f1)
	DeviceName: Onboard LAN 2
	Subsystem: Fujitsu Technology Solutions 100 Series/C230 Series Chipset Family PCI Express Root Port [1734:1222]
	Kernel driver in use: pcieport
00:1d.0 PCI bridge [0604]: Intel Corporation 100 Series/C230 Series Chipset Family PCI Express Root Port #9 [8086:a118] (rev f1)
	DeviceName: Slot 2
	Subsystem: Fujitsu Technology Solutions 100 Series/C230 Series Chipset Family PCI Express Root Port [1734:1222]
	Kernel driver in use: pcieport
00:1f.0 ISA bridge [0601]: Intel Corporation C236 Chipset LPC/eSPI Controller [8086:a149] (rev 31)
	Subsystem: Fujitsu Technology Solutions C236 Chipset LPC/eSPI Controller [1734:1222]
00:1f.2 Memory controller [0580]: Intel Corporation 100 Series/C230 Series Chipset Family Power Management Controller [8086:a121] (rev 31)
	Subsystem: Fujitsu Technology Solutions 100 Series/C230 Series Chipset Family Power Management Controller [1734:1222]
00:1f.4 SMBus [0c05]: Intel Corporation 100 Series/C230 Series Chipset Family SMBus [8086:a123] (rev 31)
	Subsystem: Fujitsu Technology Solutions 100 Series/C230 Series Chipset Family SMBus [1734:1222]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c_i801
01:00.0 Non-Volatile memory controller [0108]: Phison Electronics Corporation E12 NVMe Controller [1987:5012] (rev 01)
	Subsystem: Phison Electronics Corporation E12 NVMe Controller [1987:5012]
	Kernel driver in use: nvme
	Kernel modules: nvme
02:00.0 VGA compatible controller [0300]: Matrox Electronics Systems Ltd. MGA G200e [Pilot] ServerEngines (SEP1) [102b:0522] (rev 05)
	DeviceName: VGA iRMC4
	Subsystem: Fujitsu Technology Solutions MGA G200e [Pilot] ServerEngines (SEP1) [1734:11cc]
	Kernel driver in use: mgag200
	Kernel modules: mgag200
02:00.1 Co-processor [0b40]: Emulex Corporation ServerView iRMC HTI [19a2:0800]
	Subsystem: Fujitsu Technology Solutions ServerView iRMC HTI [1734:11cc]
03:00.0 Ethernet controller [0200]: Intel Corporation I210 Gigabit Network Connection [8086:1533] (rev 03)
	DeviceName: LAN i210-AT
	Subsystem: Fujitsu Technology Solutions I210 Gigabit Network Connection [1734:11f1]
	Kernel driver in use: igb
	Kernel modules: igb
04:00.0 Ethernet controller [0200]: Intel Corporation I210 Gigabit Network Connection [8086:1533] (rev 03)
	DeviceName: LAN i210-AT
	Subsystem: Fujitsu Technology Solutions I210 Gigabit Network Connection [1734:11f1]
	Kernel driver in use: vfio-pci
	Kernel modules: igb
05:00.0 Ethernet controller [0200]: Intel Corporation I350 Gigabit Network Connection [8086:1521] (rev 01)
	Subsystem: Intel Corporation Ethernet Server Adapter I350-T2 [8086:5002]
	Kernel driver in use: vfio-pci
	Kernel modules: igb
05:00.1 Ethernet controller [0200]: Intel Corporation I350 Gigabit Network Connection [8086:1521] (rev 01)
	Subsystem: Intel Corporation Ethernet Server Adapter I350-T2 [8086:5002]
	Kernel driver in use: vfio-pci
	Kernel modules: igb
```
