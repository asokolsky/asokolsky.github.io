# duo

Backup TrueNAS Server.

## Hardware

Item|Description
----|----------
CPU|Intel i5-9400 6C/6T 2.90 GHz up to 4.10 GHz Turbo LGA1151 65W BX80684I59400
CPU Cooler|Cooler Master Hyper 212 EVO
CPU Fan|PWM 120x120x25 mm, 650-1800 rpm
Motherboard|ASRock Z370M-ITX/ac LGA 1151 (300 Series) Intel Z370 HDMI SATA 6Gb/s USB 3.1 Mini ITX
RAM|Crucial Pro 2x16GB DDR4 3200MT/s CP2K16G4DFRA32A
Ethernet|onboard I219-V, I211
GPU|Intel UHD Graphics 630
SSD|500GB WD Blue SN550 NVMe M.2 2280, 3D NAND, Up to 2,400 MB/s - WDS500G2B0C
PSU|Seasonic FOCUS 450 Gold SSR-450FM 450W 80+ Gold ATX12V & EPS12V 140 mm PS
Case|[Fractal Design Define Mini Black Silent mATX](https://www.newegg.com/Product/Product.aspx?Item=N82E16811352011)
OS|TrueNAS

## PCIe Devices

```
alex@duo > lspci -nnkq
00:00.0 Host bridge [0600]: Intel Corporation 8th Gen Core Processor Host Bridge/DRAM Registers [8086:3ec2] (rev 07)
	DeviceName: Onboard - Other
	Subsystem: ASRock Incorporation 8th Gen Core Processor Host Bridge/DRAM Registers [1849:3ec2]
	Kernel driver in use: skl_uncore
	Kernel modules: ie31200_edac
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
00:1d.0 PCI bridge [0604]: Intel Corporation 200 Series PCH PCI Express Root Port #9 [8086:a298] (rev f0)
	Subsystem: ASRock Incorporation 200 Series PCH PCI Express Root Port [1849:a298]
	Kernel driver in use: pcieport
00:1f.0 ISA bridge [0601]: Intel Corporation Z370 Chipset LPC/eSPI Controller [8086:a2c9]
	DeviceName: Onboard - Other
	Subsystem: ASRock Incorporation Z370 Chipset LPC/eSPI Controller [1849:a2c9]
00:1f.2 Memory controller [0580]: Intel Corporation 200 Series/Z370 Chipset Family Power Management Controller [8086:a2a1]
	DeviceName: Onboard - Other
	Subsystem: ASRock Incorporation 200 Series/Z370 Chipset Family Power Management Controller [1849:a2a1]
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
02:00.0 Ethernet controller [0200]: Intel Corporation I211 Gigabit Network Connection [8086:1539] (rev 03)
	Subsystem: ASRock Incorporation I211 Gigabit Network Connection [1849:1539]
	Kernel driver in use: igb
	Kernel modules: igb
03:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009] (rev 01)
	Subsystem: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009]
	Kernel driver in use: nvme
	Kernel modules: nvme
```

## USB Devices

```
alex@duo > lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

## Networking

```
alex@duo > sudo lspci|grep -i eth
00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (2) I219-V
02:00.0 Ethernet controller: Intel Corporation I211 Gigabit Network Connection (rev 03)
```
Hence:
* [I219-V](https://ark.intel.com/content/www/us/en/ark/products/82186/intel-ethernet-connection-i219v.html)
is just a [PHY](https://en.wikipedia.org/wiki/Physical_layer) with TDP of just
0.5W, [datasheet](https://cdrdv2.intel.com/v1/dl/getcontent/612523)
* [I211](https://www.intel.com/content/www/us/en/products/sku/64404/intel-ethernet-controller-i211at/specifications.html),
[datasheet](https://cdrdv2.intel.com/v1/dl/getcontent/333017) is a PCIe NIC.


```
alex@duo > ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp2s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
    link/ether 70:85:c2:66:f8:7b brd ff:ff:ff:ff:ff:ff
3: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 70:85:c2:66:f8:7d brd ff:ff:ff:ff:ff:ff
    altname enp0s31f6

```

From the above you can see that:

* `eno1`, a.k.a `enp0s31f6`, is an `I219-V` NIC
* `enp2s0` is an `I211` NIC

Ethernet drivers used:

```
alex@duo > sudo ethtool -i enp0s31f6
driver: e1000e
version: 6.1.74-production+truenas
firmware-version: 0.2-4
expansion-rom-version:
bus-info: 0000:00:1f.6
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

alex@duo > sudo ethtool -i enp2s0
driver: igb
version: 6.1.74-production+truenas
firmware-version:  0. 4-1
expansion-rom-version:
bus-info: 0000:02:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes
```

## DMI Info

[DMI Info](dmi.html)

## VMs

n/a

## ZFS

[Playing with ZFS on SSDs](zfs.html)
