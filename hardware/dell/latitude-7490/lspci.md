# latitude PCIe Devices

```
alex@latitude7490:~$ lspci
00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers (rev 08)
00:02.0 VGA compatible controller: Intel Corporation UHD Graphics 620 (rev 07)
00:04.0 Signal processing controller: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem (rev 08)
00:14.0 USB controller: Intel Corporation Sunrise Point-LP USB 3.0 xHCI Controller (rev 21)
00:14.2 Signal processing controller: Intel Corporation Sunrise Point-LP Thermal subsystem (rev 21)
00:15.0 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #0 (rev 21)
00:15.1 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #1 (rev 21)
00:15.2 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #2 (rev 21)
00:15.3 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #3 (rev 21)
00:16.0 Communication controller: Intel Corporation Sunrise Point-LP CSME HECI #1 (rev 21)
00:16.3 Serial controller: Intel Corporation Sunrise Point-LP Active Management Technology - SOL (rev 21)
00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #1 (rev f1)
00:1c.2 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #3 (rev f1)
00:1d.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #9 (rev f1)
00:1f.0 ISA bridge: Intel Corporation Sunrise Point LPC/eSPI Controller (rev 21)
00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC (rev 21)
00:1f.3 Audio device: Intel Corporation Sunrise Point-LP HD Audio (rev 21)
00:1f.4 SMBus: Intel Corporation Sunrise Point-LP SMBus (rev 21)
00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (4) I219-LM (rev 21)
01:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A PCI Express Card Reader (rev 01)
02:00.0 Network controller: Intel Corporation Wi-Fi 6E(802.11ax) AX210/AX1675* 2x2 [Typhoon Peak] (rev 1a)
03:00.0 Non-Volatile memory controller: Sandisk Corp SanDisk Ultra 3D / WD Blue SN550 NVMe SSD (rev 01)
```

Device tree
```
alex@latitude7490:~$ lspci -tv
-[0000:00]-+-00.0  Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
           +-02.0  Intel Corporation UHD Graphics 620
           +-04.0  Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem
           +-14.0  Intel Corporation Sunrise Point-LP USB 3.0 xHCI Controller
           +-14.2  Intel Corporation Sunrise Point-LP Thermal subsystem
           +-15.0  Intel Corporation Sunrise Point-LP Serial IO I2C Controller #0
           +-15.1  Intel Corporation Sunrise Point-LP Serial IO I2C Controller #1
           +-15.2  Intel Corporation Sunrise Point-LP Serial IO I2C Controller #2
           +-15.3  Intel Corporation Sunrise Point-LP Serial IO I2C Controller #3
           +-16.0  Intel Corporation Sunrise Point-LP CSME HECI #1
           +-16.3  Intel Corporation Sunrise Point-LP Active Management Technology - SOL
           +-1c.0-[01]----00.0  Realtek Semiconductor Co., Ltd. RTS525A PCI Express Card Reader
           +-1c.2-[02]----00.0  Intel Corporation Wi-Fi 6E(802.11ax) AX210/AX1675* 2x2 [Typhoon Peak]
           +-1d.0-[03]----00.0  Sandisk Corp SanDisk Ultra 3D / WD Blue SN550 NVMe SSD
           +-1f.0  Intel Corporation Sunrise Point LPC/eSPI Controller
           +-1f.2  Intel Corporation Sunrise Point-LP PMC
           +-1f.3  Intel Corporation Sunrise Point-LP HD Audio
           +-1f.4  Intel Corporation Sunrise Point-LP SMBus
           \-1f.6  Intel Corporation Ethernet Connection (4) I219-LM
```

Device Details
```
alex@latitude7490:~$ sudo lspci -v
00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers (rev 08)
        Subsystem: Dell Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
        Flags: bus master, fast devsel, latency 0, IOMMU group 0
        Capabilities: [e0] Vendor Specific Information: Len=10 <?>
        Kernel driver in use: skl_uncore

00:02.0 VGA compatible controller: Intel Corporation UHD Graphics 620 (rev 07) (prog-if 00 [VGA controller])
        DeviceName:  Onboard IGD
        Subsystem: Dell UHD Graphics 620
        Flags: bus master, fast devsel, latency 0, IRQ 154
        Memory at ee000000 (64-bit, non-prefetchable) [size=16M]
        Memory at d0000000 (64-bit, prefetchable) [size=256M]
        I/O ports at f000 [size=64]
        Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
        Capabilities: [40] Vendor Specific Information: Len=0c <?>
        Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
        Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Capabilities: [d0] Power Management version 2
        Capabilities: [100] Process Address Space ID (PASID)
        Capabilities: [200] Address Translation Service (ATS)
        Capabilities: [300] Page Request Interface (PRI)
        Kernel driver in use: i915
        Kernel modules: i915

00:04.0 Signal processing controller: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem (rev 08)
        Subsystem: Dell Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem
        Flags: fast devsel, IRQ 16, IOMMU group 1
        Memory at ef340000 (64-bit, non-prefetchable) [size=32K]
        Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
        Capabilities: [d0] Power Management version 3
        Capabilities: [e0] Vendor Specific Information: Len=0c <?>
        Kernel driver in use: proc_thermal
        Kernel modules: processor_thermal_device_pci_legacy

00:14.0 USB controller: Intel Corporation Sunrise Point-LP USB 3.0 xHCI Controller (rev 21) (prog-if 30 [XHCI])
        Subsystem: Dell Sunrise Point-LP USB 3.0 xHCI Controller
        Flags: bus master, medium devsel, latency 0, IRQ 124, IOMMU group 2
        Memory at ef330000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [70] Power Management version 2
        Capabilities: [80] MSI: Enable+ Count=8/8 Maskable- 64bit+
        Kernel driver in use: xhci_hcd
        Kernel modules: xhci_pci

00:14.2 Signal processing controller: Intel Corporation Sunrise Point-LP Thermal subsystem (rev 21)
        Subsystem: Dell Sunrise Point-LP Thermal subsystem
        Flags: fast devsel, IRQ 18, IOMMU group 2
        Memory at ef357000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 3
        Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Kernel driver in use: intel_pch_thermal
        Kernel modules: intel_pch_thermal

00:15.0 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #0 (rev 21)
        Subsystem: Dell Sunrise Point-LP Serial IO I2C Controller
        Flags: bus master, fast devsel, latency 0, IRQ 16, IOMMU group 3
        Memory at ef356000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [80] Power Management version 3
        Capabilities: [90] Vendor Specific Information: Len=14 <?>
        Kernel driver in use: intel-lpss
        Kernel modules: intel_lpss_pci

00:15.1 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #1 (rev 21)
        Subsystem: Dell Sunrise Point-LP Serial IO I2C Controller
        Flags: bus master, fast devsel, latency 0, IRQ 17, IOMMU group 3
        Memory at ef355000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [80] Power Management version 3
        Capabilities: [90] Vendor Specific Information: Len=14 <?>
        Kernel driver in use: intel-lpss
        Kernel modules: intel_lpss_pci

00:15.2 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #2 (rev 21)
        Subsystem: Dell Sunrise Point-LP Serial IO I2C Controller
        Flags: bus master, fast devsel, latency 0, IRQ 18, IOMMU group 3
        Memory at ef354000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [80] Power Management version 3
        Capabilities: [90] Vendor Specific Information: Len=14 <?>
        Kernel driver in use: intel-lpss
        Kernel modules: intel_lpss_pci

00:15.3 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #3 (rev 21)
        Subsystem: Dell Sunrise Point-LP Serial IO I2C Controller
        Flags: bus master, fast devsel, latency 0, IRQ 19, IOMMU group 3
        Memory at ef353000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [80] Power Management version 3
        Capabilities: [90] Vendor Specific Information: Len=14 <?>
        Kernel driver in use: intel-lpss
        Kernel modules: intel_lpss_pci

00:16.0 Communication controller: Intel Corporation Sunrise Point-LP CSME HECI #1 (rev 21)
        Subsystem: Dell Sunrise Point-LP CSME HECI
        Flags: bus master, fast devsel, latency 0, IRQ 143, IOMMU group 4
        Memory at ef352000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 3
        Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Kernel driver in use: mei_me
        Kernel modules: mei_me

00:16.3 Serial controller: Intel Corporation Sunrise Point-LP Active Management Technology - SOL (rev 21) (prog-if 02 [16550])
        Subsystem: Dell Sunrise Point-LP Active Management Technology - SOL
        Flags: 66MHz, fast devsel, IRQ 19, IOMMU group 4
        I/O ports at f060 [size=8]
        Memory at ef351000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [50] Power Management version 3
        Kernel driver in use: serial

00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #1 (rev f1) (prog-if 00 [Normal decode])
        Subsystem: Dell Sunrise Point-LP PCI Express Root Port
        Flags: bus master, fast devsel, latency 0, IRQ 121, IOMMU group 5
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: [disabled] [16-bit]
        Memory behind bridge: ef200000-ef2fffff [size=1M] [32-bit]
        Prefetchable memory behind bridge: [disabled] [64-bit]
        Capabilities: [40] Express Root Port (Slot+), MSI 00
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Capabilities: [90] Subsystem: Dell Sunrise Point-LP PCI Express Root Port
        Capabilities: [a0] Power Management version 3
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Access Control Services
        Capabilities: [200] L1 PM Substates
        Capabilities: [220] Secondary PCI Express
        Kernel driver in use: pcieport

00:1c.2 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #3 (rev f1) (prog-if 00 [Normal decode])
        Subsystem: Dell Sunrise Point-LP PCI Express Root Port
        Flags: bus master, fast devsel, latency 0, IRQ 122, IOMMU group 6
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: [disabled] [16-bit]
        Memory behind bridge: ef100000-ef1fffff [size=1M] [32-bit]
        Prefetchable memory behind bridge: [disabled] [64-bit]
        Capabilities: [40] Express Root Port (Slot+), MSI 00
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Capabilities: [90] Subsystem: Dell Sunrise Point-LP PCI Express Root Port
        Capabilities: [a0] Power Management version 3
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Access Control Services
        Capabilities: [200] L1 PM Substates
        Capabilities: [220] Secondary PCI Express
        Kernel driver in use: pcieport

00:1d.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #9 (rev f1) (prog-if 00 [Normal decode])
        Subsystem: Dell Sunrise Point-LP PCI Express Root Port
        Flags: bus master, fast devsel, latency 0, IRQ 123, IOMMU group 7
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: [disabled] [16-bit]
        Memory behind bridge: ef000000-ef0fffff [size=1M] [32-bit]
        Prefetchable memory behind bridge: [disabled] [64-bit]
        Capabilities: [40] Express Root Port (Slot+), MSI 00
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Capabilities: [90] Subsystem: Dell Sunrise Point-LP PCI Express Root Port
        Capabilities: [a0] Power Management version 3
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Access Control Services
        Capabilities: [200] L1 PM Substates
        Capabilities: [220] Secondary PCI Express
        Kernel driver in use: pcieport

00:1f.0 ISA bridge: Intel Corporation Sunrise Point LPC/eSPI Controller (rev 21)
        Subsystem: Dell Sunrise Point LPC/eSPI Controller
        Flags: bus master, fast devsel, latency 0, IOMMU group 8

00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC (rev 21)
        Subsystem: Dell Sunrise Point-LP PMC
        Flags: bus master, fast devsel, latency 0, IOMMU group 8
        Memory at ef34c000 (32-bit, non-prefetchable) [size=16K]

00:1f.3 Audio device: Intel Corporation Sunrise Point-LP HD Audio (rev 21) (prog-if 80)
        Subsystem: Dell Sunrise Point-LP HD Audio
        Flags: bus master, fast devsel, latency 32, IRQ 155, IOMMU group 8
        Memory at ef348000 (64-bit, non-prefetchable) [size=16K]
        Memory at ef320000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 3
        Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd_hda_intel, snd_soc_skl, snd_soc_avs, snd_sof_pci_intel_skl

00:1f.4 SMBus: Intel Corporation Sunrise Point-LP SMBus (rev 21)
        Subsystem: Dell Sunrise Point-LP SMBus
        Flags: medium devsel, IRQ 16, IOMMU group 8
        Memory at ef350000 (64-bit, non-prefetchable) [size=256]
        I/O ports at f040 [size=32]
        Kernel driver in use: i801_smbus
        Kernel modules: i2c_i801

00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (4) I219-LM (rev 21)
        Subsystem: Dell Ethernet Connection (4) I219-LM
        Flags: bus master, fast devsel, latency 0, IRQ 133, IOMMU group 8
        Memory at ef300000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [e0] PCI Advanced Features
        Kernel driver in use: e1000e
        Kernel modules: e1000e

01:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A PCI Express Card Reader (rev 01)
        Subsystem: Dell RTS525A PCI Express Card Reader
        Flags: bus master, fast devsel, latency 0, IRQ 132, IOMMU group 9
        Memory at ef200000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [80] Power Management version 3
        Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [b0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [148] Device Serial Number 00-00-00-01-00-4c-e0-00
        Capabilities: [158] Latency Tolerance Reporting
        Capabilities: [160] L1 PM Substates
        Kernel driver in use: rtsx_pci
        Kernel modules: rtsx_pci

02:00.0 Network controller: Intel Corporation Wi-Fi 6E(802.11ax) AX210/AX1675* 2x2 [Typhoon Peak] (rev 1a)
        Subsystem: Intel Corporation Wi-Fi 6 AX210 160MHz
        Flags: bus master, fast devsel, latency 0, IRQ 18, IOMMU group 10
        Memory at ef100000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [40] Express Endpoint, MSI 00
        Capabilities: [80] MSI-X: Enable+ Count=16 Masked-
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [14c] Latency Tolerance Reporting
        Capabilities: [154] L1 PM Substates
        Kernel driver in use: iwlwifi
        Kernel modules: iwlwifi

03:00.0 Non-Volatile memory controller: Sandisk Corp SanDisk Ultra 3D / WD Blue SN550 NVMe SSD (rev 01) (prog-if 02 [NVM Express])
        Subsystem: Sandisk Corp WD Blue SN550 NVMe SSD
        Flags: bus master, fast devsel, latency 0, IRQ 16, IOMMU group 11
        Memory at ef000000 (64-bit, non-prefetchable) [size=16K]
        Memory at ef004000 (64-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 3
        Capabilities: [90] MSI: Enable- Count=1/32 Maskable- 64bit+
        Capabilities: [b0] MSI-X: Enable+ Count=17 Masked-
        Capabilities: [c0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [150] Device Serial Number 00-00-00-00-00-00-00-00
        Capabilities: [1b8] Latency Tolerance Reporting
        Capabilities: [300] Secondary PCI Express
        Capabilities: [900] L1 PM Substates
        Kernel driver in use: nvme
        Kernel modules: nvme

```
