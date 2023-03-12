# HTPC

This is a VM with GPU, NIC and some USB ports passed through.

## PCI

```
alex@htpc:~$ lspci
00:00.0 Host bridge: Intel Corporation 82G33/G31/P35/P31 Express DRAM Controller
00:1a.0 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #4 (rev 03)
00:1a.1 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #5 (rev 03)
00:1a.2 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #6 (rev 03)
00:1a.7 USB controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI Controller #2 (rev 03)
00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio Controller (rev 03)
00:1c.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
00:1c.1 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
00:1c.2 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
00:1c.3 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
00:1d.0 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #1 (rev 03)
00:1d.1 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #2 (rev 03)
00:1d.2 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #3 (rev 03)
00:1d.7 USB controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI Controller #1 (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 92)
00:1f.0 ISA bridge: Intel Corporation 82801IB (ICH9) LPC Interface Controller (rev 02)
00:1f.2 SATA controller: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 6 port SATA Controller [AHCI mode] (rev 02)
00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev 02)
01:00.0 VGA compatible controller: NVIDIA Corporation GP108 [GeForce GT 1030] (rev a1)
01:00.1 Audio device: NVIDIA Corporation GP108 High Definition Audio Controller (rev a1)
02:00.0 Ethernet controller: Intel Corporation I211 Gigabit Network Connection (rev 03)
05:01.0 PCI bridge: Red Hat, Inc. QEMU PCI-PCI bridge
05:02.0 PCI bridge: Red Hat, Inc. QEMU PCI-PCI bridge
05:03.0 PCI bridge: Red Hat, Inc. QEMU PCI-PCI bridge
05:04.0 PCI bridge: Red Hat, Inc. QEMU PCI-PCI bridge
06:03.0 Unclassified device [00ff]: Red Hat, Inc. Virtio memory balloon
06:08.0 Communication controller: Red Hat, Inc. Virtio console
07:1b.0 USB controller: Red Hat, Inc. QEMU XHCI Host Controller (rev 01)
09:01.0 SCSI storage controller: Red Hat, Inc. Virtio SCSI
```

## USB

```
alex@htpc:~$ lsusb
Bus 009 Device 003: ID 046d:c52b Logitech, Inc. Unifying Receiver
Bus 009 Device 002: ID 0471:0815 Philips (or NXP) eHome Infrared Receiver
Bus 009 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 010 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 008 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
```
