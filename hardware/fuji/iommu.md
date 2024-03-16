# Fuji IOMMU

Use
```sh
cat /proc/cmdline; for d in /sys/kernel/iommu_groups/*/devices/*; do \
    n=${d#*/iommu_groups/*}; n=${n%%/*}; printf 'IOMMU group %s ' "$n"; lspci -nns "${d##*/}"; done
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
