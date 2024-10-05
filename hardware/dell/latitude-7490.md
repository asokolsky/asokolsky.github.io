# Dell Latitude 7490

## Specifications

Component|Details
---------|-------
CPU|Intel Core [i7-8650U](https://ark.intel.com/content/www/us/en/ark/products/124968/intel-core-i7-8650u-processor-8m-cache-up-to-4-20-ghz.html), 4C8T, 3.9 GHz, 8M Cache, 15W, vPro
RAM|2 x 16GB Crucial DDR4-3200 SODIMM 1.2V CL22 CT2K16G4SFRA32A
Graphics|Intel UHD Graphics 620
SSD|500GB WD Blue SN550 NVMe SSD - Gen3 x4 PCIe 8Gb/s, up to 2,400 MB/s - WDS500G2B0C
Ethernet|Intel i219LM Gigabit Ethernet Controller,10/100/1000 Mb/s Ethernet (RJ-45)
WiFi|Intel Tri-Band 6G/5.8G/2.4Ghz 802.11AX AX210NGW, Blue-Tooth 5.3

## BIOS

During the boot up press F2 when logo is displayed.

## PCIe Devices

Apparently my Dell Latitude 7490 has no thunderbolt controller:

```
> lspci
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
00:1f.0 ISA bridge: Intel Corporation Sunrise Point LPC Controller/eSPI Controller (rev 21)
00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC (rev 21)
00:1f.3 Audio device: Intel Corporation Sunrise Point-LP HD Audio (rev 21)
00:1f.4 SMBus: Intel Corporation Sunrise Point-LP SMBus (rev 21)
00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (4) I219-LM (rev 21)
01:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A PCI Express Card Reader (rev 01)
02:00.0 Network controller: Intel Corporation Wi-Fi 6E(802.11ax) AX210/AX1675* 2x2 [Typhoon Peak] (rev 1a)
03:00.0 Non-Volatile memory controller: Sandisk Corp SanDisk Ultra 3D / WD Blue SN550 NVMe SSD (rev 01)
```

No changes when dock is plugged in.
