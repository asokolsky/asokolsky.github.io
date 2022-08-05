# Optimizing Guest Performance

## Options Section

Uncheck the 'use tablet for pointer' checkbox.

## Hard Disk Performance

### SCSI Controller

From
[this](https://forum.proxmox.com/threads/virtio-scsi-vs-virtio-scsi-single.28426/)
it looks like VIRTIO SCSI, NOT single, `iotread=1` is the best.

### Hard Disk


Cache: `Write back` for best performance. `No cache` default is safer, but slower.

Discard: Check, to optimally use disk space (TRIM).

IO Thread: Check


## Network Performance


### Network Device

Model: `VirtIO (paravirtualized)`

### Use ethtool for troubleshooting

[Source](https://x8t4.com/how-to-use-the-ethtool-command-with-examples/).

```sh
alex@kdesktop:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp6s18: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 4e:7c:94:c8:6f:2e brd ff:ff:ff:ff:ff:ff
    inet 192.168.10.181/24 brd 192.168.10.255 scope global dynamic noprefixroute enp6s18
       valid_lft 4833sec preferred_lft 4833sec
    inet6 fe80::dbfe:6f6d:11d5:1743/64 scope link noprefixroute
       valid_lft forever preferred_lft forever

alex@kdesktop:~$ ethtool enp6s18
Settings for enp6s18:
	Supported ports: [  ]
	Supported link modes:   Not reported
	Supported pause frame use: No
	Supports auto-negotiation: No
	Supported FEC modes: Not reported
	Advertised link modes:  Not reported
	Advertised pause frame use: No
	Advertised auto-negotiation: No
	Advertised FEC modes: Not reported
	Speed: Unknown!
	Duplex: Unknown! (255)
	Auto-negotiation: off
	Port: Other
	PHYAD: 0
	Transceiver: internal
netlink error: Operation not permitted
	Link detected: yes

alex@kdesktop:~$ ethtool -i enp6s18
driver: virtio_net
version: 1.0.0
firmware-version:
expansion-rom-version:
bus-info: 0000:06:12.0
supports-statistics: yes
supports-test: no
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: no
```

## Benchmarks


### Browser

http://speed-battle.com/speedtest_e.php

Platform|Calculate|Store|Render|OVERALL SCORE
--------|---------|-----|------|--
Bare Latitude + FireFox mint-001 - 1.0|186.18|132.13|143.72|462.03
VM i440fx + FireFox canonical-002 - 1.0|134.3|256|182.04|572.34
VM q35 + FireFox canonical-002 - 1.0|212.78|252.06|180.04|644.88
