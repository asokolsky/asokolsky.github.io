# Lenovo Thinkpad P52

## Specifications

[Specs]()

Component|Details
---------|-------
CPU|[Intel i7-8750H 6c/12T 2.20GHz-4.10GHz, 45W Coffee Lake](https://ark.intel.com/content/www/us/en/ark/products/134906/intel-core-i7-8750h-processor-9m-cache-up-to-4-10-ghz.html)
Chipset|Intel CM246
RAM|SODIM DDR4-2400<br>2x8GB DDR4-2667 1333MHz<br>2x8GB 8ATF1G64HZ-2G6E1 2666 MT/s
SSDs|Crucial P3 1TB PCIe Gen3 3D NAND NVMe M.2 SSD CT1000P3SSD8<br>Intel 256GB SSD PCIe-NVMe OPAL2.0 M.2<br>Crucial 1TB SATA SSD
Ethernet|[I219-LM](https://www.intel.com/content/www/us/en/products/sku/82185/intel-ethernet-connection-i219lm/specifications.html?wapkw=I219-LM)
WiFi|[Intel® 9560 vPro 802.11AC (2 x 2) & Bluetooth 5.1 CNVio](https://www.intel.com/content/www/us/en/products/sku/99446/intel-wirelessac-9560/specifications.html)
GPU|NVIDIA Quadro P1000 4GB
Screen|15.6” FHD (1920 x 1080, 300nits) IPS anti-glare, 72% color gamut
webcam|720p HD Camera with ThinkShutter and microphone
Battery|6 cell Li-Ion 90Wh
Power Supply|170W AC Adapter (2pin) - USB Type C

## BIOS

During the boot up press F1 when logo is displayed.

## Thunderbolt

* [Update Thunderbolt firmware with Powershell](https://www.reddit.com/r/thinkpad/comments/12cx8n5/psa_update_thunderbolt_firmware_despite_the_patch/)
* [Thunderbolt 3.0 on ThinkPad P52 - More info in comment](https://www.reddit.com/r/thinkpad/comments/133z2rr/thunderbolt_30_on_thinkpad_p52_more_info_in/)

## PCIe Devices

```
alex@p52:~$ lspci -nnkq
00:00.0 Host bridge [0600]: Intel Corporation 8th Gen Core Processor Host Bridge/DRAM Registers [8086:3ec4] (rev 07)
	Subsystem: Lenovo 8th Gen Core Processor Host Bridge/DRAM Registers [17aa:225f]
	Kernel driver in use: skl_uncore
00:01.0 PCI bridge [0604]: Intel Corporation 6th-10th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 07)
	Kernel driver in use: pcieport
00:02.0 VGA compatible controller [0300]: Intel Corporation CoffeeLake-H GT2 [UHD Graphics 630] [8086:3e9b]
	Subsystem: Lenovo CoffeeLake-H GT2 [UHD Graphics 630] [17aa:225f]
	Kernel driver in use: i915
	Kernel modules: i915
00:04.0 Signal processing controller [1180]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem [8086:1903] (rev 07)
	Subsystem: Lenovo Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem [17aa:225f]
	Kernel driver in use: proc_thermal
	Kernel modules: processor_thermal_device_pci_legacy
00:08.0 System peripheral [0880]: Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v5 / 6th/7th/8th Gen Core Processor Gaussian Mixture Model [8086:1911]
	Subsystem: Lenovo Xeon E3-1200 v5/v6 / E3-1500 v5 / 6th/7th/8th Gen Core Processor Gaussian Mixture Model [17aa:225f]
00:12.0 Signal processing controller [1180]: Intel Corporation Cannon Lake PCH Thermal Controller [8086:a379] (rev 10)
	Subsystem: Lenovo Cannon Lake PCH Thermal Controller [17aa:225f]
	Kernel driver in use: intel_pch_thermal
	Kernel modules: intel_pch_thermal
00:14.0 USB controller [0c03]: Intel Corporation Cannon Lake PCH USB 3.1 xHCI Host Controller [8086:a36d] (rev 10)
	Subsystem: Lenovo Cannon Lake PCH USB 3.1 xHCI Host Controller [17aa:225f]
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci
00:14.2 RAM memory [0500]: Intel Corporation Cannon Lake PCH Shared SRAM [8086:a36f] (rev 10)
	Subsystem: Lenovo Cannon Lake PCH Shared SRAM [17aa:225f]
00:14.3 Network controller [0280]: Intel Corporation Cannon Lake PCH CNVi WiFi [8086:a370] (rev 10)
	Subsystem: Intel Corporation Cannon Lake PCH CNVi WiFi [8086:0030]
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi
00:15.0 Serial bus controller [0c80]: Intel Corporation Cannon Lake PCH Serial IO I2C Controller #0 [8086:a368] (rev 10)
	Subsystem: Lenovo Cannon Lake PCH Serial IO I2C Controller [17aa:225f]
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci
00:16.0 Communication controller [0780]: Intel Corporation Cannon Lake PCH HECI Controller [8086:a360] (rev 10)
	Subsystem: Lenovo Cannon Lake PCH HECI Controller [17aa:225f]
	Kernel driver in use: mei_me
	Kernel modules: mei_me
00:17.0 SATA controller [0106]: Intel Corporation Cannon Lake Mobile PCH SATA AHCI Controller [8086:a353] (rev 10)
	Subsystem: Lenovo Cannon Lake Mobile PCH SATA AHCI Controller [17aa:225f]
	Kernel driver in use: ahci
	Kernel modules: ahci
00:1c.0 PCI bridge [0604]: Intel Corporation Cannon Lake PCH PCI Express Root Port #1 [8086:a338] (rev f0)
	Kernel driver in use: pcieport
00:1c.7 PCI bridge [0604]: Intel Corporation Cannon Lake PCH PCI Express Root Port #8 [8086:a33f] (rev f0)
	Kernel driver in use: pcieport
00:1d.0 PCI bridge [0604]: Intel Corporation Cannon Lake PCH PCI Express Root Port #9 [8086:a330] (rev f0)
	Kernel driver in use: pcieport
00:1e.0 Communication controller [0780]: Intel Corporation Cannon Lake PCH Serial IO UART Host Controller [8086:a328] (rev 10)
	Subsystem: Lenovo Cannon Lake PCH Serial IO UART Host Controller [17aa:225f]
	Kernel driver in use: intel-lpss
	Kernel modules: intel_lpss_pci
00:1f.0 ISA bridge [0601]: Intel Corporation Cannon Lake LPC Controller [8086:a30e] (rev 10)
	Subsystem: Lenovo Cannon Lake LPC Controller [17aa:225f]
00:1f.3 Audio device [0403]: Intel Corporation Cannon Lake PCH cAVS [8086:a348] (rev 10)
	Subsystem: Lenovo Cannon Lake PCH cAVS [17aa:225f]
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel, snd_sof_pci_intel_cnl
00:1f.4 SMBus [0c05]: Intel Corporation Cannon Lake PCH SMBus Controller [8086:a323] (rev 10)
	Subsystem: Lenovo Cannon Lake PCH SMBus Controller [17aa:225f]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c_i801
00:1f.5 Serial bus controller [0c80]: Intel Corporation Cannon Lake PCH SPI Controller [8086:a324] (rev 10)
	Subsystem: Lenovo Cannon Lake PCH SPI Controller [17aa:225f]
	Kernel driver in use: intel-spi
	Kernel modules: spi_intel_pci
00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet Connection (7) I219-V [8086:15bc] (rev 10)
	Subsystem: Lenovo Ethernet Connection (7) I219-V [17aa:225f]
	Kernel driver in use: e1000e
	Kernel modules: e1000e
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GP107GLM [Quadro P1000 Mobile] [10de:1cbb] (rev a1)
	Subsystem: Lenovo GP107GLM [Quadro P1000 Mobile] [17aa:225f]
	Kernel driver in use: nvidia
	Kernel modules: nvidiafb, nouveau, nvidia_drm, nvidia
01:00.1 Audio device [0403]: NVIDIA Corporation GP107GL High Definition Audio Controller [10de:0fb9] (rev a1)
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel
70:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A PCI Express Card Reader [10ec:525a] (rev 01)
	Subsystem: Lenovo RTS525A PCI Express Card Reader [17aa:225f]
	Kernel driver in use: rtsx_pci
	Kernel modules: rtsx_pci
71:00.0 Non-Volatile memory controller [0108]: Micron Technology Inc 2550 NVMe SSD (DRAM-less) [1344:5416] (rev 01)
	Subsystem: Micron Technology Inc Device [1344:1100]
	Kernel driver in use: nvme
	Kernel modules: nvme
```
