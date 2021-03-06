# Networking in Proxmox

This should be completed before a server is added into a cluster.

# Reference

https://pve.proxmox.com/wiki/Network_Configuration

## Disable IPv6

Do NOT edit the /etc/sysctl.conf file.
Instead create /etc/sysctl.d/disable-ipv6.conf:

```
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
```

For a particular adapter enp0s3 add this in /etc/sysctl.conf:

```
net.ipv6.conf.enp0s3.disable_ipv6 = 1
```

## Make NIC VLAN-aware

In GUI: Server-name\Network\vmbr0, check VLAN aware

## NIC Aggregation

Add in the /etc/network/interfaces
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

Just edit /etc/network/interfaces:

```sh
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
        post-up /usr/sbin/dhclient vmbr1
#WAN

auto vmbr2
iface vmbr2 inet static
        address 192.168.20.1/24
        bridge-ports enp2s0f1
        bridge-stp off
        bridge-fd 0
#LAN
```

Then

```console
root@pve:/etc/network# ifdown vmbr1
root@pve:/etc/network# ifup vmbr1
```

## Use ethtool

Getting MAC address
```console
root@pmox2:~# ethtool -P eno1
Permanent address: 6c:2b:59:f8:0d:f6
root@pmox2:~# ethtool -P vmbr0
Permanent address: not set
```

Display the driver used:
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

