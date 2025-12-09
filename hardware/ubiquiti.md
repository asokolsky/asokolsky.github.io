# Ubiquiti Equipment

## EdgeRouter X

Proved to be useful:

* [EdgeRouter Hardware Offloading](https://help.ui.com/hc/en-us/articles/115006567467-EdgeRouter-Hardware-Offloading)
* [EdgeRouter UniFi Controller DHCP Options](https://help.ui.com/hc/en-us/articles/204960064-EdgeRouter-UniFi-Controller-DHCP-Options)
* [EdgeRouter - DHCP Server Using Dnsmasq](https://help.ui.com/hc/en-us/articles/115002673188)
* https://www.ui.com/download/?q=EDGEROUTER

Used web GUI to offload to hardware the following:

```
set system offload hwnat enable
set system offload ipsec enable
```

In order for DNS to resolve LAN computers registered via DHCP:

* enable DNS masquerading in DHCP server settings
* use localdomain for domain in DHCP and in System tab

There is NO integration with Ubiquiti UniFi Controller.

## UniFi

I run UniFi controller in an [LXC container](/proxmox/lxc-unifi.html).

Here are some throughput and latency figures I observed:

AP|Latency (ms)|Throughput
--|-------|----------
Wired|0|0
U7-Pro-US|0|0
UAP-AC-LITE|0|0

Measurement methodology:
* latency was measured using `ping`
* throughput measured using `iperf3`
