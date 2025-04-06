# exi

Used to be an HTPC with GPU for gaming and playing with k8s and, maybe, frigate.
Now this is a video editing workstation.

## Hardware

Item|Description
----|----------
CPU|Intel Core i5-12400F Alder Lake 6C 12T 2.5GHz LGA1700 65W BX8071512400F
CPU Cooler|Cooler Master Hyper 212 EVO
CPU Fan|PWM 120x25 mm, 650-1800 rpm
Motherboard|ASRock B760M PRO RS LGA1700 MicroATX
RAM|2x Crucial Pro DDR5 (2x16GB) 6000MHz CL36, CP2K16G60C36U5B
M.2_0|Key E, supports type 2230 WiFi/BT PCIe WiFi module and Intel® CNVio/CNVio2
&nbsp;|Intel WiFi6 AX201 Bt 5.2
M.2_1|Key M, supports type 2242/2260/2280 PCIe Gen4x4 (64 Gb/s)
&nbsp;|500GB WD Blue SN550 NVMe SSD - Gen3x4 PCIe 8Gb/s, M.2 2280, 3D NAND WDS500G2B0C
M.2_2|Key M, supports type 2280 PCIe Gen4x4 (64 Gb/s)
&nbsp;|[Edge TPU ML compute accelerator, Coral TPU M.2 B+M](../coral.html)
M.2_3|Key M, supports type 2280 PCIe Gen4x4 (64 Gb/s)
SATA|4 x SATA3 6.0 Gb/s Connectors
PCIe1|PCIe 5.0 x16 slot, supports x16 mode
&nbsp;|NVIDIA MSI Ventus GeForce RTX 3050 8GB GDDR6 PCIx 4.0 x8, HDMI 2.1, DP v1.4a 115W [more](nvidia-smi.html)
PCIe2|PCIe 3.0 x16 slot, supports x4 mode
&nbsp;|[1xPCIe to 4xSATA M.2 adapter](../1xPCIe-4xSATA-M.2.html)
Ethernet|onboard RTL8125BG
BIOS|3.04
Case|LIAN LI PC-A05FNB Black Aluminum ATX Mid Tower 8.27" x 15.16" x 19.69"
PSU|SeaSonic SS-400FL2 Active PFC F3 400W 80 PLUS Platinum Fanless ATX12V / EPS12V
OS|Ubuntu Studio 23.10
Monitor|Samsung QN75Q80TAFXZA
Speakers|SAMSUNG HW-Q950T 9.1.4 Soundbar + Sub + Surrounds

* [DMI Info](dmi.html)
* [Info](info.html)
* [PCIe Devices](lspci.html)
* [USB Devices](lsusb.html)

## Power Consumption

* when turned off - 2W!
* while serving a single video stream over SMB and with CPU consumption <4%: 88W
