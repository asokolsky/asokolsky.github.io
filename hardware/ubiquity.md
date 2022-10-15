# Ubiquity Equipment

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

There is NO integration with Ubiquity UniFi Controller.
For the latter see [proxmox/unifi](proxmox/unifi.html)
