# DUO PCIe Devices

```
alex@duo > lspci -nnkq
00:00.0 Host bridge [0600]: Intel Corporation 8th Gen Core Processor Host Bridge/DRAM Registers [8086:3ec2] (rev 07)
        DeviceName: Onboard - Other
        Subsystem: ASRock Incorporation 8th Gen Core Processor Host Bridge/DRAM Registers [1849:3ec2]
        Kernel driver in use: skl_uncore
        Kernel modules: ie31200_edac
00:01.0 PCI bridge [0604]: Intel Corporation 6th-10th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 07)
        Subsystem: ASRock Incorporation 6th-10th Gen Core Processor PCIe Controller (x16) [1849:1901]
        Kernel driver in use: pcieport
00:02.0 VGA compatible controller [0300]: Intel Corporation CoffeeLake-S GT2 [UHD Graphics 630] [8086:3e92]
        DeviceName: Onboard - Video
        Subsystem: ASRock Incorporation CoffeeLake-S GT2 [UHD Graphics 630] [1849:3e92]
        Kernel driver in use: i915
        Kernel modules: i915
00:14.0 USB controller [0c03]: Intel Corporation 200 Series/Z370 Chipset Family USB 3.0 xHCI Controller [8086:a2af]
        DeviceName: Onboard - Other
        Subsystem: ASRock Incorporation 200 Series/Z370 Chipset Family USB 3.0 xHCI Controller [1849:a2af]
        Kernel driver in use: xhci_hcd
        Kernel modules: xhci_pci
00:14.2 Signal processing controller [1180]: Intel Corporation 200 Series PCH Thermal Subsystem [8086:a2b1]
        DeviceName: Onboard - Other
        Subsystem: ASRock Incorporation 200 Series PCH Thermal Subsystem [1849:a2b1]
00:16.0 Communication controller [0780]: Intel Corporation 200 Series PCH CSME HECI #1 [8086:a2ba]
        DeviceName: Onboard - Other
        Subsystem: ASRock Incorporation 200 Series PCH CSME HECI [1849:a2ba]
        Kernel driver in use: mei_me
        Kernel modules: mei_me
00:17.0 SATA controller [0106]: Intel Corporation 200 Series PCH SATA controller [AHCI mode] [8086:a282]
        DeviceName: Onboard - SATA
        Subsystem: ASRock Incorporation 200 Series PCH SATA controller [AHCI mode] [1849:a282]
        Kernel driver in use: ahci
        Kernel modules: ahci
00:1c.0 PCI bridge [0604]: Intel Corporation 200 Series PCH PCI Express Root Port #1 [8086:a290] (rev f0)
        Subsystem: ASRock Incorporation 200 Series PCH PCI Express Root Port [1849:a290]
        Kernel driver in use: pcieport
00:1c.5 PCI bridge [0604]: Intel Corporation 200 Series PCH PCI Express Root Port #6 [8086:a295] (rev f0)
        Subsystem: ASRock Incorporation 200 Series PCH PCI Express Root Port [1849:a295]
        Kernel driver in use: pcieport
00:1c.6 PCI bridge [0604]: Intel Corporation 200 Series PCH PCI Express Root Port #7 [8086:a296] (rev f0)
        Subsystem: ASRock Incorporation 200 Series PCH PCI Express Root Port [1849:a296]
        Kernel driver in use: pcieport
00:1d.0 PCI bridge [0604]: Intel Corporation 200 Series PCH PCI Express Root Port #9 [8086:a298] (rev f0)
        Subsystem: ASRock Incorporation 200 Series PCH PCI Express Root Port [1849:a298]
        Kernel driver in use: pcieport
00:1f.0 ISA bridge [0601]: Intel Corporation Z370 Chipset LPC/eSPI Controller [8086:a2c9]
        DeviceName: Onboard - Other
        Subsystem: ASRock Incorporation Z370 Chipset LPC/eSPI Controller [1849:a2c9]
00:1f.2 Memory controller [0580]: Intel Corporation 200 Series/Z370 Chipset Family Power Management Controller [8086:a2a1]
        DeviceName: Onboard - Other
        Subsystem: ASRock Incorporation 200 Series/Z370 Chipset Family Power Management Controller [1849:a2a1]
00:1f.3 Audio device [0403]: Intel Corporation 200 Series PCH HD Audio [8086:a2f0]
        DeviceName: Onboard - Sound
        Subsystem: ASRock Incorporation 200 Series PCH HD Audio [1849:5892]
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd_hda_intel, snd_soc_avs
00:1f.4 SMBus [0c05]: Intel Corporation 200 Series/Z370 Chipset Family SMBus Controller [8086:a2a3]
        DeviceName: Onboard - Other
        Subsystem: ASRock Incorporation 200 Series/Z370 Chipset Family SMBus Controller [1849:a2a3]
        Kernel driver in use: i801_smbus
        Kernel modules: i2c_i801
00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet Connection (2) I219-V [8086:15b8]
        DeviceName: Onboard - Ethernet
        Subsystem: ASRock Incorporation Ethernet Connection (2) I219-V [1849:15b8]
        Kernel driver in use: e1000e
        Kernel modules: e1000e
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GP108 [GeForce GT 1030] [10de:1d01] (rev a1)
        Subsystem: Micro-Star International Co., Ltd. [MSI] GP108 [GeForce GT 1030] [1462:8c98]
        Kernel modules: nvidiafb, nouveau, nvidia_drm, nvidia
01:00.1 Audio device [0403]: NVIDIA Corporation GP108 High Definition Audio Controller [10de:0fb8] (rev a1)
        Subsystem: Micro-Star International Co., Ltd. [MSI] GP108 High Definition Audio Controller [1462:8c98]
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd_hda_intel
03:00.0 Ethernet controller [0200]: Intel Corporation I211 Gigabit Network Connection [8086:1539] (rev 03)
        Subsystem: ASRock Incorporation I211 Gigabit Network Connection [1849:1539]
        Kernel driver in use: igb
        Kernel modules: igb
04:00.0 Network controller [0280]: Intel Corporation Dual Band Wireless-AC 3168NGW [Stone Peak] [8086:24fb] (rev 10)
        Subsystem: Intel Corporation Dual Band Wireless-AC 3168NGW [Stone Peak] [8086:2110]
        Kernel driver in use: iwlwifi
        Kernel modules: iwlwifi
05:00.0 Non-Volatile memory controller [0108]: Sandisk Corp SanDisk Ultra 3D / WD Blue SN550 NVMe SSD [15b7:5009] (rev 01)
        Subsystem: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009]
        Kernel driver in use: nvme
        Kernel modules: nvme
```
