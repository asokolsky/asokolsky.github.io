# Thunderbolt Support in my Hardware

## Dell Latitude 7490

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
02:00.0 Network controller: Intel Corporation Device 2725 (rev 1a)
03:00.0 Non-Volatile memory controller: Sandisk Corp Device 5009 (rev 01)
```

No changes when dock is plugged in.

## Linux Management Software

Installed the
[boltctl](https://manpages.ubuntu.com/manpages/jammy/man1/boltctl.1.html)
using `sudo apt install bolt`.  Yet

```
> boltctl list
>
```

## Amazon Basics Thunderbolt Hub

I use [Amazon Basics
hub](https://www.amazon.com/gp/product/B086H3FMPZ/ref=ppx_yo_dt_b_search_asin_title).
It does the job.  Realtek 8153 USB-to-Ethernet chip stopped working though.
I wish it were 2.5 Gbps Ethernet but it is not.  I use the hub with Macbook Pro.

## Dell Thunderbolt Hub

I end up using [Dell WD19TB Thunderbolt
Dock](https://www.dell.com/en-us/work/shop/dell-thunderbolt-dock-wd19tbs/apd/210-azbi/pc-accessories)
as a USB3 hub.  It does power the laptop though.

### USB

Nothing but laptop

```
> lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 003: ID 8087:0032 Intel Corp.
Bus 001 Device 002: ID 0bda:58ca Realtek Semiconductor Corp. Integrated_Webcam_HD
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

After the dock (with nothing plugged in) is plugged into tb port:

```
> lsusb
Bus 002 Device 007: ID 0bda:8153 Realtek Semiconductor Corp. RTL8153 Gigabit Ethernet Adapter
Bus 002 Device 006: ID 0bda:0413 Realtek Semiconductor Corp.
Bus 002 Device 005: ID 0bda:0487 Realtek Semiconductor Corp. Dell dock
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 003: ID 8087:0032 Intel Corp.
Bus 001 Device 002: ID 0bda:58ca Realtek Semiconductor Corp. Integrated_Webcam_HD
Bus 001 Device 012: ID 413c:b06e Dell Computer Corp. Integrated_Webcam_HD
Bus 001 Device 014: ID 413c:b06f Dell Computer Corp. Integrated_Webcam_HD
Bus 001 Device 013: ID 0bda:402e Realtek Semiconductor Corp.
Bus 001 Device 011: ID 0bda:5413 Realtek Semiconductor Corp.
Bus 001 Device 010: ID 0bda:5487 Realtek Semiconductor Corp. Dell dock
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

### RTL8153 Gigabit Ethernet Adapter

Driver

```
> sudo ethtool enxa44cc899803f
[sudo] password for alex:
Settings for enxa44cc899803f:
	Supported ports: [ TP MII ]
	Supported link modes:   10baseT/Half 10baseT/Full
	                        100baseT/Half 100baseT/Full
	                        1000baseT/Half 1000baseT/Full
	Supported pause frame use: No
	Supports auto-negotiation: Yes
	Supported FEC modes: Not reported
	Advertised link modes:  10baseT/Half 10baseT/Full
	                        100baseT/Half 100baseT/Full
	                        1000baseT/Full
	Advertised pause frame use: Symmetric Receive-only
	Advertised auto-negotiation: Yes
	Advertised FEC modes: Not reported
	Link partner advertised link modes:  10baseT/Half 10baseT/Full
	                                     100baseT/Half 100baseT/Full
	                                     1000baseT/Full
	Link partner advertised pause frame use: No
	Link partner advertised auto-negotiation: Yes
	Link partner advertised FEC modes: Not reported
	Speed: 1000Mb/s
	Duplex: Full
	Port: MII
	PHYAD: 32
	Transceiver: internal
	Auto-negotiation: on
	Supports Wake-on: pumbg
	Wake-on: g
	Current message level: 0x00007fff (32767)
			       drv probe link timer ifdown ifup rx_err tx_err tx_queued intr tx_done rx_status pktdata hw wol
	Link detected: yes
```

IP settings (mac addresses replaced with xx):

```
> ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: enp0s31f6: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN group default qlen 1000
    link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff
3: wlp2s0: <BROADCAST,MULTICAST> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff
4: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default
    link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
6: enxa44cc899803f: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff
    inet 192.168.10.191/24 brd 192.168.10.255 scope global dynamic noprefixroute enxa44cc899803f
       valid_lft 7069sec preferred_lft 7069sec
    inet6 xxxx::xxxx:xxxx:xxxx:xxxx/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
```

Performance:

```
> iperf3 -c 192.168.10.1
Connecting to host 192.168.10.1, port 5201
[  5] local 192.168.10.191 port 57842 connected to 192.168.10.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   113 MBytes   950 Mbits/sec    0    280 KBytes
[  5]   1.00-2.00   sec   112 MBytes   944 Mbits/sec    0    280 KBytes
[  5]   2.00-3.00   sec   112 MBytes   939 Mbits/sec    0    280 KBytes
[  5]   3.00-4.00   sec   112 MBytes   943 Mbits/sec    0    280 KBytes
[  5]   4.00-5.00   sec   112 MBytes   941 Mbits/sec    0    296 KBytes
[  5]   5.00-6.00   sec   112 MBytes   942 Mbits/sec    0    328 KBytes
[  5]   6.00-7.00   sec   112 MBytes   943 Mbits/sec    0    328 KBytes
[  5]   7.00-8.00   sec   112 MBytes   940 Mbits/sec    0    328 KBytes
[  5]   8.00-9.00   sec   112 MBytes   943 Mbits/sec    0    328 KBytes
[  5]   9.00-10.00  sec   112 MBytes   942 Mbits/sec    0    328 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  1.10 GBytes   943 Mbits/sec    0             sender
[  5]   0.00-10.00  sec  1.10 GBytes   941 Mbits/sec                  receiver

iperf Done.
```
