# pfSense VM in Proxmox

## Sources

[run pfsense in
proxmox](https://pfstore.com.au/blogs/guides/run-pfsense-in-proxmox)

## VM Setup

Defaults are safe.  Make it better:

* CPU - enable pdpe1gb, aes
* Hard Disk\IO Thread enabled
* CPU - 1 OK, for a 1Gbps need at least 2
* RAM - 1GB, NO balooning
* Network - either bridge or PCIe devise passed through.

Either way:
* Firewall - disabled
* Model - VirtIO (paravirtualized)
* Multiqueue - 8

Options: QEMU Guest Agent: Enabled

After VM created - add another NIC.

## Guest agent

[Install guest
agent](https://forum.netgate.com/topic/162083/pfsense-vm-on-proxmox-qemu-agent-installation).

* In shell:

```console
pkg install qemu-guest-agent
```

* In web gui:

* From System / PackageManager - install package "Shellcmd";
* From Services / Shellcmd - create an "earlyshellcmd"
`service qemu-guest-agent start`
* From System / Advanced / System Tunables - add tunable: `virtio_console_load`,
value: `YES`

* In shell `edit /etc/rc.conf.local`:
```console
qemu_guest_agent_enable="YES"
qemu_guest_agent_flags="-d -v -l /var/log/qemu-ga.log"
```
* In shell `reboot`

## pfSense Setup

### System/Advanced/Networking

Disable all the offloading

### Services/DHCP Server

Besides obvious...

LAN/Other Options

NTP Server 1: _pfSense IP_

Additional BOOTP/DHCP Options: Option 43, String, _value_,

where _value_ is
[calculated](https://tcpip.wtf/en/unifi-l3-adoption-with-dhcp-option-43-on-pfsense-mikrotik-and-others.htm)

### Services/DNS Resolver/General Settings

To ensure that UniFi controller DNS name is unifi, add host override:

* Host: unifi
* Domain: lan
* IP Address: 192.168.x.y
* Description UniFi Cotnroller
* Additional name for the host: unicon

## Proxmox with a single NIC running pfSense + USB Ethernet dongle

Throughput limited to 30 Mbps.
Therefore such config is not recommended.
Blame the FreeBSD USB driver?
Also the dongle (Realtec chipset) gets pretty hot.

## Proxmox with a single NIC running pfSense + switch with VLANs

Throughput proved to easily reach 900 Mbps.

Configure the following VLANs:

* 10 for WAN traffic;
* 20 for LAN traffic;

VLAN ID 1 is a reserved, not used by user apps.

1. Setup proxmox as usual, with bridge to be VLAN-aware.
Continue proxmox config and setup control web GUI on vmbr0.20.

2. Setup pfSense VM as usual, pass to it a single vmbr0.

3. Configure pfSense to use VLANs.
(re)Run setup to make pfSense VLAN-aware, so that:

```
 WAN (wan)       -> vtnet0.10  -> v4/DHCP4: <wan>
 LAN (lan)       -> vtnet0.20  -> v4: 192.168.245.1/24
```

4. Configure the switch, e.g. TL-SG108E, to use VLANs, such that:

* port 1 is used for WAN, VLAN 10;
* port 2 is used for router, VLANs 10, 20;
* other ports are used for LAN, VLAN 20.

802.1Q VLAN Configuration:

|VLAN ID|VLAN Name|Member Ports|Tagged Ports|Untagged Ports|
|-------|---------|------------|------------|--------------|
|1	    |Default  |1-8         |1-8         |n/a|
|10     |WAN      |1-2         |2           |1|
|20     |LAN      |2-8         |2           |3-8|

802.1Q VLAN PVID Setting:

|Port|PVID|
|----|----|
|1|10
|2|1
|3|20
|4|20
|5|20
|6|20
|7|20
|8|20

## unbound Instability

My install was affected by [unbound
instability](https://redmine.pfsense.org/issues/11316).
For now in `Services/DNS Resolver/General Settings` I UNchecked
`Register DHCP leases in the DNS Resolver`.
