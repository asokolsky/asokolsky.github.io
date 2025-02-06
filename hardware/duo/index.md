# duo

.. is now a core of the streaming setup.  Use d to be a
[backup nas](nas-backup.html).

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
GPU|NVIDIA GeForce GT 1030
SSD|500GB WD Blue SN550 NVMe M.2 2280, 3D NAND, Up to 2,400 MB/s - WDS500G2B0C
PSU|300W TFX12V PSU
Case|[IN-WIN CE685.FH300TB3 MicroATX case](https://www.newegg.com/p/N82E16811108109)
OS|Linux Mint

* [PCIe Devices](lspci.html)
* [DMI Info](dmi.html)
* [IOMMU](iommu.html)
* [USB Devices](lsusb.html)

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

## ZFS

[Playing with ZFS on SSDs](zfs.html)
