# NASS IOMMU

```
alex@nass:~/ > cat /proc/cmdline; for d in /sys/kernel/iommu_groups/*/devices/*; do     n=${d#*/iommu_groups/*}; n=${n%%/*}; printf 'IOMMU group %s ' "$n"; lspci -nns "${d##*/}"; done
BOOT_IMAGE=/ROOT/23.10.2@/boot/vmlinuz-6.1.74-production+truenas root=ZFS=boot-pool/ROOT/23.10.2 ro libata.allow_tpm=1 amd_iommu=on iommu=pt kvm_amd.npt=1 kvm_amd.avic=1 intel_iommu=on zfsforce=1 nvme_core.multipath=N
IOMMU group 0 00:00.0 Host bridge [0600]: Intel Corporation Atom Processor C3000 Series System Agent [8086:1980] (rev 11)
IOMMU group 1 00:04.0 Host bridge [0600]: Intel Corporation Atom Processor C3000 Series Error Registers [8086:19a1] (rev 11)
IOMMU group 10 00:16.0 PCI bridge [0604]: Intel Corporation Atom Processor C3000 Series Integrated LAN Root Port #0 [8086:19d1] (rev 11)
IOMMU group 11 00:17.0 PCI bridge [0604]: Intel Corporation Atom Processor C3000 Series Integrated LAN Root Port #1 [8086:19d2] (rev 11)
IOMMU group 12 00:18.0 Communication controller [0780]: Intel Corporation Atom Processor C3000 Series ME HECI 1 [8086:19d3] (rev 11)
IOMMU group 13 00:1f.0 ISA bridge [0601]: Intel Corporation Atom Processor C3000 Series LPC or eSPI [8086:19dc] (rev 11)
IOMMU group 13 00:1f.2 Memory controller [0580]: Intel Corporation Atom Processor C3000 Series Power Management Controller [8086:19de] (rev 11)
IOMMU group 13 00:1f.4 SMBus [0c05]: Intel Corporation Atom Processor C3000 Series SMBus controller [8086:19df] (rev 11)
IOMMU group 13 00:1f.5 Serial bus controller [0c80]: Intel Corporation Atom Processor C3000 Series SPI Controller [8086:19e0] (rev 11)
IOMMU group 14 01:00.0 Co-processor [0b40]: Intel Corporation Atom Processor C3000 Series QuickAssist Technology [8086:19e2] (rev 11)
IOMMU group 15 03:00.0 PCI bridge [0604]: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge [1a03:1150] (rev 03)
IOMMU group 15 04:00.0 VGA compatible controller [0300]: ASPEED Technology, Inc. ASPEED Graphics Family [1a03:2000] (rev 30)
IOMMU group 16 05:00.0 Ethernet controller [0200]: Intel Corporation Ethernet Connection X553 1GbE [8086:15e4] (rev 11)
IOMMU group 17 05:00.1 Ethernet controller [0200]: Intel Corporation Ethernet Connection X553 1GbE [8086:15e4] (rev 11)
IOMMU group 18 06:00.0 Ethernet controller [0200]: Intel Corporation Ethernet Connection X553 1GbE [8086:15e5] (rev 11)
IOMMU group 19 06:00.1 Ethernet controller [0200]: Intel Corporation Ethernet Connection X553 1GbE [8086:15e5] (rev 11)
IOMMU group 2 00:05.0 Generic system peripheral [0807]: Intel Corporation Atom Processor C3000 Series Root Complex Event Collector [8086:19a2] (rev 11)
IOMMU group 3 00:06.0 PCI bridge [0604]: Intel Corporation Atom Processor C3000 Series Integrated QAT Root Port [8086:19a3] (rev 11)
IOMMU group 4 00:10.0 PCI bridge [0604]: Intel Corporation Atom Processor C3000 Series PCI Express Root Port #6 [8086:19aa] (rev 11)
IOMMU group 5 00:11.0 PCI bridge [0604]: Intel Corporation Atom Processor C3000 Series PCI Express Root Port #7 [8086:19ab] (rev 11)
IOMMU group 6 00:12.0 System peripheral [0880]: Intel Corporation Atom Processor C3000 Series SMBus Contoller - Host [8086:19ac] (rev 11)
IOMMU group 7 00:13.0 SATA controller [0106]: Intel Corporation Atom Processor C3000 Series SATA Controller 0 [8086:19b2] (rev 11)
IOMMU group 8 00:14.0 SATA controller [0106]: Intel Corporation Atom Processor C3000 Series SATA Controller 1 [8086:19c2] (rev 11)
IOMMU group 9 00:15.0 USB controller [0c03]: Intel Corporation Atom Processor C3000 Series USB 3.0 xHCI Controller [8086:19d0] (rev 11)
```
