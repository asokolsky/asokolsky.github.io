# fuji

Fujitsu PRIMERGY TX1320 M3 PYT1323T3S used as a virtualization server.

[Passing SATA controller to VM](https://forum.proxmox.com/threads/prevent-a-sata-controller-to-be-loaded-by-ahci.136983/).

## Hardware

Item|Description
----|----------
CPU|Xeon E3-1230v6 3.5Ghz 4C/8T 8MB 72W
Motherboard|D3373-B1x, Intel C236 chipset, 2x PCIx3 8-lane x2, 1x PCIx3 1-lane, 1 PCIx3 4-lane
RAM|UDIMM PC4-19200 unbuffered ECC DDR4-2400MHz, 4 slots, Max64GB
.|2x DDR4 ECC UDIMM 16GB 2Rx8 2666 CL19 MTA18ASF2G72AZ-2G6E2
.|16 GB 18ASF2G72AZ-2G6E2, 2667 MT/s, @2400 MT/s
.|16 GB 18ASF2G72AZ-2G6E2, 2667 MT/s, @2400 MT/s
M2 Adapter|PCIE Adapter for SATA or PCIE NVMe SSD
.|M.2 2280 Nvme PCIe SSD Sabrent 256GB Rocket SB-ROCKET-256
.|M.2 2280 SATA SSD Samsung 860 EVO 500GB MZ-N6E500BW
Storage Controller|onboard 4ports SATA 6G
Ethernet|onboard 2x i210, Dell Intel I350-T2, XP0NY
PSU|250W
UPS|APC RS1000G
OS|ProxMox VE

<p align="center" width="100%">
    <img width="45%" src="front-cover.jpg">
    <img width="45%" src="front.jpg">
    <img width="100%" src="internals-top.png">
    <img width="100%" src="internals.jpg">
    <img width="100%" src="overview.jpg">
</p>

## PCI

Use `lspci -nnk`, here is the output:
```
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

## IOMMU

Use
```sh
cat /proc/cmdline; for d in /sys/kernel/iommu_groups/*/devices/*; do n=${d#*/iommu_groups/*}; n=${n%%/*}; printf 'IOMMU group %s ' "$n"; lspci -nns\
 "${d##*/}"; done
```

Output:
```
BOOT_IMAGE=/boot/vmlinuz-6.5.11-8-pve root=/dev/mapper/pve-root ro quiet intel_iommu=on
IOMMU group 0 00:00.0 Host bridge [0600]: Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers [8086:5918] (rev 05)
IOMMU group 10 02:00.0 VGA compatible controller [0300]: Matrox Electronics Systems Ltd. MGA G200e [Pilot] ServerEngines (SEP1) [102b:0522] (rev 05)
IOMMU group 10 02:00.1 Co-processor [0b40]: Emulex Corporation ServerView iRMC HTI [19a2:0800]
IOMMU group 11 03:00.0 Ethernet controller [0200]: Intel Corporation I210 Gigabit Network Connection [8086:1533] (rev 03)
IOMMU group 12 04:00.0 Ethernet controller [0200]: Intel Corporation I210 Gigabit Network Connection [8086:1533] (rev 03)
IOMMU group 13 05:00.0 Ethernet controller [0200]: Intel Corporation I350 Gigabit Network Connection [8086:1521] (rev 01)
IOMMU group 14 05:00.1 Ethernet controller [0200]: Intel Corporation I350 Gigabit Network Connection [8086:1521] (rev 01)
IOMMU group 1 00:01.0 PCI bridge [0604]: Intel Corporation 6th-10th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 05)
IOMMU group 1 01:00.0 Non-Volatile memory controller [0108]: Phison Electronics Corporation E12 NVMe Controller [1987:5012] (rev 01)
IOMMU group 2 00:14.0 USB controller [0c03]: Intel Corporation 100 Series/C230 Series Chipset Family USB 3.0 xHCI Controller [8086:a12f] (rev 31)
IOMMU group 2 00:14.2 Signal processing controller [1180]: Intel Corporation 100 Series/C230 Series Chipset Family Thermal Subsystem [8086:a131] (rev 31)
IOMMU group 3 00:16.0 Communication controller [0780]: Intel Corporation 100 Series/C230 Series Chipset Family MEI Controller #1 [8086:a13a] (rev 31)
IOMMU group 3 00:16.1 Communication controller [0780]: Intel Corporation 100 Series/C230 Series Chipset Family MEI Controller #2 [8086:a13b] (rev 31)
IOMMU group 4 00:17.0 SATA controller [0106]: Intel Corporation Q170/Q150/B150/H170/H110/Z170/CM236 Chipset SATA Controller [AHCI Mode] [8086:a102] (rev 31)
IOMMU group 5 00:1c.0 PCI bridge [0604]: Intel Corporation 100 Series/C230 Series Chipset Family PCI Express Root Port #5 [8086:a114] (rev f1)
IOMMU group 6 00:1c.5 PCI bridge [0604]: Intel Corporation 100 Series/C230 Series Chipset Family PCI Express Root Port #6 [8086:a115] (rev f1)
IOMMU group 7 00:1c.6 PCI bridge [0604]: Intel Corporation 100 Series/C230 Series Chipset Family PCI Express Root Port #7 [8086:a116] (rev f1)
IOMMU group 8 00:1d.0 PCI bridge [0604]: Intel Corporation 100 Series/C230 Series Chipset Family PCI Express Root Port #9 [8086:a118] (rev f1)
IOMMU group 9 00:1f.0 ISA bridge [0601]: Intel Corporation C236 Chipset LPC/eSPI Controller [8086:a149] (rev 31)
IOMMU group 9 00:1f.2 Memory controller [0580]: Intel Corporation 100 Series/C230 Series Chipset Family Power Management Controller [8086:a121] (rev 31)
IOMMU group 9 00:1f.4 SMBus [0c05]: Intel Corporation 100 Series/C230 Series Chipset Family SMBus [8086:a123] (rev 31)
```

## USB

```
root@fuji:~# lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 002: ID 051d:0002 American Power Conversion Uninterruptible Power Supply
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

## VMs

pfSense

hass

```
root@fuji:~# cat /etc/pve/.vmlist|jq --sort-keys
{
  "ids": {
    "100": {
      "node": "fuji",
      "type": "lxc",
      "version": 9
    },
    "1000": {
      "node": "fuji",
      "type": "lxc",
      "version": 6
    },
    "1001": {
      "node": "fuji",
      "type": "lxc",
      "version": 10
    },
    "1003": {
      "node": "fuji",
      "type": "lxc",
      "version": 5
    },
    "1004": {
      "node": "fuji",
      "type": "lxc",
      "version": 3
    },
    "1005": {
      "node": "fuji",
      "type": "lxc",
      "version": 24
    },
    "101": {
      "node": "fuji",
      "type": "qemu",
      "version": 30
    },
    "102": {
      "node": "fuji",
      "type": "lxc",
      "version": 7
    },
    "103": {
      "node": "fuji",
      "type": "lxc",
      "version": 8
    },
    "104": {
      "node": "fuji",
      "type": "qemu",
      "version": 29
    },
    "105": {
      "node": "fuji",
      "type": "qemu",
      "version": 41
    }
  },
  "version": 32
}
```

```
root@fuji:~# ls -la /etc/pve/nodes/fuji/qemu-server/
total 2
drwxr-xr-x 2 root www-data   0 Feb  9  2020 .
drwxr-xr-x 2 root www-data   0 Feb  9  2020 ..
-rw-r----- 1 root www-data 549 Mar  4 10:58 101.conf
-rw-r----- 1 root www-data 497 Mar  5 12:17 104.conf
-rw-r----- 1 root www-data 505 Oct 18  2020 200.conf
-rw-r----- 1 root www-data 518 Nov 12  2020 300.conf
```
