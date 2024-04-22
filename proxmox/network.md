# Networking in Proxmox

More info:

* NIC naming: [**1**](https://en.wikipedia.org/wiki/Consistent_Network_Device_Naming),
[**2**](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/ch-consistent_network_device_naming#sec-Naming_Schemes_Hierarchy)
* [PVE Net Config](https://pve.proxmox.com/wiki/Network_Configuration)
* [Installing RTL8125 driver](/hardware/network-r8125.html) - not worth it.

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

Here are [few examples](/linux/cli-ethtool.html) of
[ethtool](https://en.wikipedia.org/wiki/Ethtool) use.
