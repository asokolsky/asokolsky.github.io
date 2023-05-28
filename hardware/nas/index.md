# NAS

## Hardware

Item|Description
----|----------
CPU|Intel Atom C3558, 4C4T, 2.20 GHz, TDP16W, Denverton
Motherboard|SuperMicro [A2SDi-4C-HLN4F](https://www.supermicro.com/en/products/motherboard/a2sdi-4c-hln4f) miniITX
BMC|ASpeed AST 2400
BIOS|1.5 5/17/2021
BMC Firmware|03.88 02/21/2020 Redfish Version: 1.0.1
RAM|4x Micron MTA18ASF1G72PDZ-2G6E1 8GB DDR4-2666 ECC RDIMM
.|18ASF1G72PDZ-2G6E1  2666 MT/s @2133 MT/s - cpu max
.|1x Crucial 8GB DDR4-2666 RDIMM,  p/n 18ASF1G72PDZ-2G6E1
Case Fan|Noctua NF-P12 redux-1700 PWM, High Performance Fan, 4-Pin, 1700rpm
Storage Controller|Intel Denverton AHCI SATA controller
Ethernet|Intel X553
PSU|Silverstone 300W SFX, model: SX300
Case|SST-DS380B-USA by SilverStone Tech
UPS|APC Back-UPS ES 550
OS|TrueNAS-SCALE-22.12.1

## PCI

```
root@nass[~]# lspci
00:00.0 Host bridge: Intel Corporation Atom Processor C3000 Series System Agent (rev 11)
00:04.0 Host bridge: Intel Corporation Atom Processor C3000 Series Error Registers (rev 11)
00:05.0 Generic system peripheral [0807]: Intel Corporation Atom Processor C3000 Series Root Complex Event Collector (rev 11)
00:06.0 PCI bridge: Intel Corporation Atom Processor C3000 Series Integrated QAT Root Port (rev 11)
00:10.0 PCI bridge: Intel Corporation Atom Processor C3000 Series PCI Express Root Port #6 (rev 11)
00:11.0 PCI bridge: Intel Corporation Atom Processor C3000 Series PCI Express Root Port #7 (rev 11)
00:12.0 System peripheral: Intel Corporation Atom Processor C3000 Series SMBus Contoller - Host (rev 11)
00:13.0 SATA controller: Intel Corporation Atom Processor C3000 Series SATA Controller 0 (rev 11)
00:14.0 SATA controller: Intel Corporation Atom Processor C3000 Series SATA Controller 1 (rev 11)
00:15.0 USB controller: Intel Corporation Atom Processor C3000 Series USB 3.0 xHCI Controller (rev 11)
00:16.0 PCI bridge: Intel Corporation Atom Processor C3000 Series Integrated LAN Root Port #0 (rev 11)
00:17.0 PCI bridge: Intel Corporation Atom Processor C3000 Series Integrated LAN Root Port #1 (rev 11)
00:18.0 Communication controller: Intel Corporation Atom Processor C3000 Series ME HECI 1 (rev 11)
00:1f.0 ISA bridge: Intel Corporation Atom Processor C3000 Series LPC or eSPI (rev 11)
00:1f.2 Memory controller: Intel Corporation Atom Processor C3000 Series Power Management Controller (rev 11)
00:1f.4 SMBus: Intel Corporation Atom Processor C3000 Series SMBus controller (rev 11)
00:1f.5 Serial bus controller [0c80]: Intel Corporation Atom Processor C3000 Series SPI Controller (rev 11)
01:00.0 Co-processor: Intel Corporation Atom Processor C3000 Series QuickAssist Technology (rev 11)
03:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge (rev 03)
04:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 30)
05:00.0 Ethernet controller: Intel Corporation Ethernet Connection X553 1GbE (rev 11)
05:00.1 Ethernet controller: Intel Corporation Ethernet Connection X553 1GbE (rev 11)
06:00.0 Ethernet controller: Intel Corporation Ethernet Connection X553 1GbE (rev 11)
06:00.1 Ethernet controller: Intel Corporation Ethernet Connection X553 1GbE (rev 11)
```
