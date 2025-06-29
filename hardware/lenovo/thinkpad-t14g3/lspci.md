```
alex@t14gen3 >  lspci -nnkq
00:00.0 Host bridge [0600]: Intel Corporation Device [8086:4621] (rev 02)
        Subsystem: Lenovo Device [17aa:22e8]
        Kernel driver in use: igen6_edac
        Kernel modules: igen6_edac
00:02.0 VGA compatible controller [0300]: Intel Corporation Alder Lake-P GT2 [Iris Xe Graphics] [8086:46a6] (rev 0c)
        Subsystem: Lenovo Device [17aa:22e8]
        Kernel driver in use: i915
        Kernel modules: i915, xe
00:04.0 Signal processing controller [1180]: Intel Corporation Alder Lake Innovation Platform Framework Processor Participant [8086:461d] (rev 02)
        Subsystem: Lenovo Device [17aa:22e8]
        Kernel driver in use: proc_thermal_pci
        Kernel modules: processor_thermal_device_pci
00:06.0 PCI bridge [0604]: Intel Corporation 12th Gen Core Processor PCI Express x4 Controller #0 [8086:464d] (rev 02)
        Subsystem: Lenovo Device [17aa:22e8]
        Kernel driver in use: pcieport
00:07.0 PCI bridge [0604]: Intel Corporation Alder Lake-P Thunderbolt 4 PCI Express Root Port #0 [8086:466e] (rev 02)
        Subsystem: Lenovo Device [17aa:22e8]
        Kernel driver in use: pcieport
00:07.2 PCI bridge [0604]: Intel Corporation Alder Lake-P Thunderbolt 4 PCI Express Root Port #2 [8086:462f] (rev 02)
        Subsystem: Lenovo Device [17aa:22e8]
        Kernel driver in use: pcieport
00:0a.0 Signal processing controller [1180]: Intel Corporation Platform Monitoring Technology [8086:467d] (rev 01)
        Subsystem: Lenovo Device [17aa:22e8]
        Kernel driver in use: intel_vsec
        Kernel modules: intel_vsec
00:0d.0 USB controller [0c03]: Intel Corporation Alder Lake-P Thunderbolt 4 USB Controller [8086:461e] (rev 02)
        Subsystem: Lenovo Device [17aa:22e8]
        Kernel driver in use: xhci_hcd
00:0d.2 USB controller [0c03]: Intel Corporation Alder Lake-P Thunderbolt 4 NHI #0 [8086:463e] (rev 02)
        Subsystem: Lenovo Device [17aa:22e8]
        Kernel driver in use: thunderbolt
        Kernel modules: thunderbolt
00:0d.3 USB controller [0c03]: Intel Corporation Alder Lake-P Thunderbolt 4 NHI #1 [8086:466d] (rev 02)
        Subsystem: Lenovo Device [17aa:22e8]
        Kernel driver in use: thunderbolt
        Kernel modules: thunderbolt
00:14.0 USB controller [0c03]: Intel Corporation Alder Lake PCH USB 3.2 xHCI Host Controller [8086:51ed] (rev 01)
        Subsystem: Lenovo Device [17aa:22e8]
        Kernel driver in use: xhci_hcd
00:14.2 RAM memory [0500]: Intel Corporation Alder Lake PCH Shared SRAM [8086:51ef] (rev 01)
        Subsystem: Lenovo Device [17aa:22e8]
00:14.3 Network controller [0280]: Intel Corporation Alder Lake-P PCH CNVi WiFi [8086:51f0] (rev 01)
        Subsystem: Intel Corporation Device [8086:0090]
        Kernel driver in use: iwlwifi
        Kernel modules: iwlwifi
00:15.0 Serial bus controller [0c80]: Intel Corporation Alder Lake PCH Serial IO I2C Controller #0 [8086:51e8] (rev 01)
        Subsystem: Lenovo Device [17aa:22e8]
        Kernel driver in use: intel-lpss
        Kernel modules: intel_lpss_pci
00:16.0 Communication controller [0780]: Intel Corporation Alder Lake PCH HECI Controller [8086:51e0] (rev 01)
        Subsystem: Lenovo Device [17aa:22e8]
        Kernel driver in use: mei_me
        Kernel modules: mei_me
00:16.3 Serial controller [0700]: Intel Corporation Alder Lake AMT SOL Redirection [8086:51e3] (rev 01)
        Subsystem: Lenovo Device [17aa:22e8]
        Kernel driver in use: serial
00:1f.0 ISA bridge [0601]: Intel Corporation Alder Lake PCH eSPI Controller [8086:5182] (rev 01)
        Subsystem: Lenovo Device [17aa:22e8]
00:1f.3 Audio device [0403]: Intel Corporation Alder Lake PCH-P High Definition Audio Controller [8086:51c8] (rev 01)
        Subsystem: Lenovo Device [17aa:22e8]
        Kernel driver in use: sof-audio-pci-intel-tgl
        Kernel modules: snd_hda_intel, snd_soc_avs, snd_sof_pci_intel_tgl
00:1f.4 SMBus [0c05]: Intel Corporation Alder Lake PCH-P SMBus Host Controller [8086:51a3] (rev 01)
        Subsystem: Lenovo Device [17aa:22e8]
        Kernel driver in use: i801_smbus
        Kernel modules: i2c_i801
00:1f.5 Serial bus controller [0c80]: Intel Corporation Alder Lake-P PCH SPI Controller [8086:51a4] (rev 01)
        Subsystem: Lenovo Device [17aa:22e8]
        Kernel driver in use: intel-spi
        Kernel modules: spi_intel_pci
00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet Connection (16) I219-LM [8086:1a1e] (rev 01)
        Subsystem: Lenovo Device [17aa:22e8]
        Kernel driver in use: e1000e
        Kernel modules: e1000e
02:00.0 Non-Volatile memory controller [0108]: Micron Technology Inc 2450 NVMe SSD [HendrixV] (DRAM-less) [1344:5411] (rev 01)
        Subsystem: Micron Technology Inc Device [1344:1100]
        Kernel driver in use: nvme
        Kernel modules: nvme
```
