# Networking in Proxmox

More info:

* NIC naming: [**1**](https://en.wikipedia.org/wiki/Consistent_Network_Device_Naming),
[**2**](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/ch-consistent_network_device_naming#sec-Naming_Schemes_Hierarchy)
* [PVE Net Config](https://pve.proxmox.com/wiki/Network_Configuration)
* [Installing RTL8125 driver](../hardware/network-r8125.html) - not worth it.

Network config should be completed *before* a server is added into a cluster.

## Disable IPv6

Do NOT edit the `/etc/sysctl.conf` file.
Instead create `/etc/sysctl.d/disable-ipv6.conf`:

```
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
```

For a particular adapter enp0s3 add this in `/etc/sysctl.conf`:

```
net.ipv6.conf.enp0s3.disable_ipv6 = 1
```

## Make NIC VLAN-aware

In GUI: Server-name\Network\vmbr0, check VLAN aware

## NIC Aggregation

Add in the `/etc/network/interfaces`
([man page](https://manpages.ubuntu.com/manpages/jammy/man5/interfaces-bridge.5.html)):
```
iface bond0 inet manual
  bond-slaves eno1 eno1
  bond-miimon 100
  bond-mode 802.3ad
  bond-xmit-hash-policy layer2+3

auto vmbr0
iface vmbr0 inet static
  address 192.168.1.123/24
  gateway 192.168.1.1
  bridge-ports bond0
  bridge-stp off
  bridge-fd 0
  bridge-vlan-aware yes
  bridge-vids 2-4094
```

Follow up on this with the switch configuration.

## Making Bridge a DHCP Client

Edit `/etc/network/interfaces`:

```
auto lo
iface lo inet loopback

iface eno1 inet manual

iface enp2s0f0 inet manual

iface enp2s0f1 inet manual

auto vmbr0
iface vmbr0 inet static
        address 192.168.10.130/24
        gateway 192.168.10.1
        bridge-ports eno1
        bridge-stp off
        bridge-fd 0

auto vmbr1
iface vmbr1 inet dhcp
        bridge-ports enp2s0f0
        bridge-stp off
        bridge-fd 0

auto vmbr2
iface vmbr2 inet static
        address 192.168.20.1/24
        bridge-ports enp2s0f1
        bridge-stp off
        bridge-fd 0
```

Then:
```sh
ifreload -a
```

and do not forget to update `/etc/hosts`

## Use ethtool

Here are few examples of [ethtool](https://en.wikipedia.org/wiki/Ethtool) use.
[More examples](https://www.thegeekstuff.com/2010/10/ethtool-command/),
[man page](https://linux.die.net/man/8/ethtool)


### Display NIC settings

```console
root@pmox3:~# ethtool enp1s0
Settings for enp1s0:
        Supported ports: [ TP ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
                                2500baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
                                2500baseT/Full
        Advertised pause frame use: Symmetric Receive-only
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                             100baseT/Half 100baseT/Full
                                             1000baseT/Full
        Link partner advertised pause frame use: Symmetric
        Link partner advertised auto-negotiation: Yes
        Link partner advertised FEC modes: Not reported
        Speed: 1000Mb/s
        Duplex: Full
        Auto-negotiation: on
        Port: Twisted Pair
        PHYAD: 0
        Transceiver: internal
        MDI-X: Unknown
        Supports Wake-on: pumbg
        Wake-on: g
        Current message level: 0x00000033 (51)
                               drv probe ifdown ifup
        Link detected: yes
```

### Get MAC address
```console
root@pmox2:~# ethtool -P eno1
Permanent address: 6c:2b:59:f8:0d:f6
root@pmox2:~# ethtool -P vmbr0
Permanent address: not set
```

### Display the driver used

```console
root@pmox2:~# ethtool -i eno1
driver: e1000e
version: 5.15.39-1-pve
firmware-version: 0.5-4
expansion-rom-version:
bus-info: 0000:00:1f.6
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes
root@pmox2:~# ethtool -i vmbr0
driver: bridge
version: 2.3
firmware-version: N/A
expansion-rom-version:
bus-info: N/A
supports-statistics: no
supports-test: no
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: no
```

### Display NIC statistics

Use `ethtool -S enp1s0` or, better yet,  `watch -d "ethtool -S eno1"`.

```
root@pmox3:~# ethtool -S enp1s0
NIC statistics:
     tx_packets: 12
     rx_packets: 5625
     tx_errors: 0
     rx_errors: 0
     rx_missed: 0
     align_errors: 0
     tx_single_collisions: 0
     tx_multi_collisions: 0
     unicast: 0
     broadcast: 2206
     multicast: 3419
     tx_aborted: 0
     tx_underrun: 0
     tx_octets: 1694
     rx_octets: 1310239
     rx_multicast64: 0
     tx_unicast64: 1
     tx_broadcast64: 0
     tx_multicast64: 11
     tx_pause_on: 0
     tx_pause_off: 0
     tx_pause_all: 0
     tx_deferred: 0
     tx_late_collision: 0
     tx_all_collision: 0
     tx_aborted32: 0
     align_errors32: 0
     rx_frame_too_long: 0
     rx_runt: 0
     rx_pause_on: 0
     rx_pause_off: 0
     rx_pause_all: 0
     rx_unknown_opcode: 0
     rx_mac_error: 0
     tx_underrun32: 0
     rx_mac_missed: 0
     rx_tcam_dropped: 0
     tdu: 0
     rdu: 0
```

### NIC test

```
root@pmox3:~# ethtool -t enp1s0
Cannot test: Operation not supported
root@pmox3:~# ethtool -t eno1
The test result is PASS
The test extra info:
Register test  (offline)         0
Eeprom test    (offline)         0
Interrupt test (offline)         0
Loopback test  (offline)         0
Link test   (on/offline)         0
```
