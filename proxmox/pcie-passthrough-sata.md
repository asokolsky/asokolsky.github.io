# SATA Controller Passthrough

## Source

[prevent-host-driver-in-pci-pass](https://gist.github.com/kiler129/4f765e8fdc41e1709f1f34f7f8f41706)

## Status

```
root@suprox:~# lspci -nnk
...
00:17.0 SATA controller [0106]: Intel Corporation Cannon Lake PCH SATA AHCI Controller [8086:a352] (rev 10)
	Subsystem: Super Micro Computer Inc Cannon Lake PCH SATA AHCI Controller [15d9:1b0e]
	Kernel driver in use: vfio-pci
	Kernel modules: ahci
```

lsblk does NOT list sdX:
```
# lsblk
NAME                         MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
nvme0n1                      259:0    0 465.8G  0 disk
```

Listing IOMMU groups:
```
root@suprox:~# for d in /sys/kernel/iommu_groups/*/devices/*; do n=${d#*/iommu_groups/*}; n=${n%%/*}; printf 'IOMMU group %s ' "$n"; lspci -nns "${d##*/}"; done
IOMMU group 0 00:00.0 Host bridge [0600]: Intel Corporation 8th Gen Core 4-core Desktop Processor Host Bridge/DRAM Registers [Coffee Lake S] [8086:3e1f] (rev 08)
IOMMU group 10 00:1c.0 PCI bridge [0604]: Intel Corporation Cannon Lake PCH PCI Express Root Port #1 [8086:a338] (rev f0)
IOMMU group 11 00:1c.1 PCI bridge [0604]: Intel Corporation Cannon Lake PCH PCI Express Root Port #2 [8086:a339] (rev f0)
IOMMU group 12 00:1d.0 PCI bridge [0604]: Intel Corporation Cannon Lake PCH PCI Express Root Port #9 [8086:a330] (rev f0)
IOMMU group 13 00:1e.0 Communication controller [0780]: Intel Corporation Cannon Lake PCH Serial IO UART Host Controller [8086:a328] (rev 10)
IOMMU group 14 00:1f.0 ISA bridge [0601]: Intel Corporation Device [8086:a30a] (rev 10)
IOMMU group 14 00:1f.4 SMBus [0c05]: Intel Corporation Cannon Lake PCH SMBus Controller [8086:a323] (rev 10)
IOMMU group 14 00:1f.5 Serial bus controller [0c80]: Intel Corporation Cannon Lake PCH SPI Controller [8086:a324] (rev 10)
IOMMU group 15 02:00.0 Ethernet controller [0200]: Intel Corporation I210 Gigabit Network Connection [8086:1533] (rev 03)
IOMMU group 16 03:00.0 Ethernet controller [0200]: Intel Corporation I210 Gigabit Network Connection [8086:1533] (rev 03)
IOMMU group 17 05:00.0 PCI bridge [0604]: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge [1a03:1150] (rev 04)
IOMMU group 17 06:00.0 VGA compatible controller [0300]: ASPEED Technology, Inc. ASPEED Graphics Family [1a03:2000] (rev 41)
IOMMU group 18 07:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009] (rev 01)
IOMMU group 1 00:01.0 PCI bridge [0604]: Intel Corporation 6th-10th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 08)
IOMMU group 1 01:00.0 Ethernet controller [0200]: Intel Corporation I350 Gigabit Network Connection [8086:1521] (rev 01)
IOMMU group 1 01:00.1 Ethernet controller [0200]: Intel Corporation I350 Gigabit Network Connection [8086:1521] (rev 01)
IOMMU group 2 00:08.0 System peripheral [0880]: Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v5 / 6th/7th/8th Gen Core Processor Gaussian Mixture Model [8086:1911]
IOMMU group 3 00:12.0 Signal processing controller [1180]: Intel Corporation Cannon Lake PCH Thermal Controller [8086:a379] (rev 10)
IOMMU group 4 00:14.0 USB controller [0c03]: Intel Corporation Cannon Lake PCH USB 3.1 xHCI Host Controller [8086:a36d] (rev 10)
IOMMU group 4 00:14.2 RAM memory [0500]: Intel Corporation Cannon Lake PCH Shared SRAM [8086:a36f] (rev 10)
IOMMU group 5 00:15.0 Serial bus controller [0c80]: Intel Corporation Cannon Lake PCH Serial IO I2C Controller #0 [8086:a368] (rev 10)
IOMMU group 5 00:15.1 Serial bus controller [0c80]: Intel Corporation Cannon Lake PCH Serial IO I2C Controller #1 [8086:a369] (rev 10)
IOMMU group 6 00:16.0 Communication controller [0780]: Intel Corporation Cannon Lake PCH HECI Controller [8086:a360] (rev 10)
IOMMU group 6 00:16.4 Communication controller [0780]: Intel Corporation Cannon Lake PCH HECI Controller #2 [8086:a364] (rev 10)
IOMMU group 7 00:17.0 SATA controller [0106]: Intel Corporation Cannon Lake PCH SATA AHCI Controller [8086:a352] (rev 10)
IOMMU group 8 00:1b.0 PCI bridge [0604]: Intel Corporation Cannon Lake PCH PCI Express Root Port #22 [8086:a32d] (rev f0)
IOMMU group 9 00:1b.6 PCI bridge [0604]: Intel Corporation Cannon Lake PCH PCI Express Root Port #23 [8086:a32e] (rev f0)
```

## Failure

```
Feb 27 11:28:46 suprox kernel: [  33005]     0 33005     7131     1026    61440        0             0 (udev-worker)
Feb 27 11:28:46 suprox kernel: oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=ns,mems_allowed=0,global_oom,task_memcg=/qemu.slice/101.scope,task=kvm,pid=32969,uid=0
Feb 27 11:28:46 suprox kernel: Out of memory: Killed process 32969 (kvm) total-vm:17339840kB, anon-rss:15797740kB, file-rss:1536kB, shmem-rss:0kB, UID:0 pgtables:31152kB oom_score_adj:0
Feb 27 11:28:46 suprox systemd[1]: 101.scope: A process of this unit has been killed by the OOM killer.
Feb 27 11:28:46 suprox pvedaemon[1598]: VM 101 qmp command failed - VM 101 not running
Feb 27 11:28:46 suprox systemd[1]: 101.scope: Failed with result 'oom-kill'.
Feb 27 11:28:46 suprox systemd[1]: 101.scope: Consumed 3.377s CPU time.
Feb 27 11:28:46 suprox kernel: vmbr0: port 6(tap101i0) entered disabled state
Feb 27 11:28:46 suprox kernel: tap101i0 (unregistering): left allmulticast mode
Feb 27 11:28:46 suprox kernel: vmbr0: port 6(tap101i0) entered disabled state
Feb 27 11:28:46 suprox pvedaemon[32957]: start failed: QEMU exited with code 1
Feb 27 11:28:46 suprox pvedaemon[1599]: <root@pam> end task UPID:suprox:000080BD:000C41F2:65DE37EA:qmstart:101:root@pam: start failed: QEMU exited with code 1
```

## Resolution

Ensured that RAM is NOT ballooning, reduced it to 12GB.  This solved
the problem.
