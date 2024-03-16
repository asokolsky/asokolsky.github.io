# fuji

Fujitsu PRIMERGY TX1320 M3 used as a virtualization server.

[Passing SATA controller to VM](/proxmox/pcie-passthrough-sata.html).

Runs VMs:

* [pfSense router](/proxmox/guest-pfSense.html)
with a i350-T2 NIC passed through;
* [XigmaNAS](/proxmox/guest-xigmanas.html) with
[an on-board SATA passed-through](/proxmox/pcie-passthrough-sata.html);
* [Home Assistant on HAOS](/proxmox/guest-home-assistant.html).

Runs LXCs:

* [vault](/proxmox/lxc-vault.html)
* [mqtt](/proxmox/lxc-mqtt.html)
* [Unifi Controller](/proxmox/lxc-unifi.html)

Runs in docker containers:

* [portainer](/apps/docker/portainer.md).

## Hardware

Item|Description
----|----------
CPU|Xeon E3-1230v6 3.5Ghz 4C/8T 8MB 72W
Motherboard|D3373-B1x, Intel C236 chipset, 2x PCIx3 8-lane x2, 1x PCIx3 1-lane, 1 PCIx3 4-lane
RAM|UDIMM PC4-19200 unbuffered ECC DDR4-2400MHz, 4 slots, Max 64GB
.|4x DDR4 ECC UDIMM 16GB 2Rx8 2666 CL19 MTA18ASF2G72AZ-2G6E2
M2 Adapter|PCIE Adapter for SATA or PCIE NVMe SSD
.|M.2 2280 Nvme PCIe SSD Sabrent 256GB Rocket SB-ROCKET-256
.|M.2 2280 SATA SSD Samsung 860 EVO 500GB MZ-N6E500BW
Storage Controller|onboard 4ports SATA 6G
NIC|2x Intel I210 on motherboard
NIC|Dell Intel I350-T2, XP0NY
PSU|250W
UPS|APC RS1000G
OS|ProxMox VE

* [DMI Info](dmi.html)
* [PCIe Devices](lspci.html)
* [IOMMU](iommu.html)

<p align="center" width="100%">
    <img width="45%" src="front-cover.jpg">
    <img width="45%" src="front.jpg">
    <img width="100%" src="internals-top.png">
    <img width="100%" src="internals.jpg">
    <img width="100%" src="overview.jpg">
</p>

## USB

```
root@fuji:~# lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 002: ID 051d:0002 American Power Conversion Uninterruptible Power Supply
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

## VMs

* pfSense
* hass

```
root@fuji:~# cat /etc/pve/.vmlist|jq --sort-keys
{
  "ids": {
    "100": {
      "node": "fuji",
      "type": "lxc",
      "version": 9
    },
    "1000": {
      "node": "fuji",
      "type": "lxc",
      "version": 6
    },
    "1001": {
      "node": "fuji",
      "type": "lxc",
      "version": 10
    },
    "1003": {
      "node": "fuji",
      "type": "lxc",
      "version": 5
    },
    "1004": {
      "node": "fuji",
      "type": "lxc",
      "version": 3
    },
    "1005": {
      "node": "fuji",
      "type": "lxc",
      "version": 24
    },
    "101": {
      "node": "fuji",
      "type": "qemu",
      "version": 30
    },
    "102": {
      "node": "fuji",
      "type": "lxc",
      "version": 7
    },
    "103": {
      "node": "fuji",
      "type": "lxc",
      "version": 8
    },
    "104": {
      "node": "fuji",
      "type": "qemu",
      "version": 29
    },
    "105": {
      "node": "fuji",
      "type": "qemu",
      "version": 41
    }
  },
  "version": 32
}
```

```
root@fuji:~# ls -la /etc/pve/nodes/fuji/qemu-server/
total 2
drwxr-xr-x 2 root www-data   0 Feb  9  2020 .
drwxr-xr-x 2 root www-data   0 Feb  9  2020 ..
-rw-r----- 1 root www-data 549 Mar  4 10:58 101.conf
-rw-r----- 1 root www-data 497 Mar  5 12:17 104.conf
-rw-r----- 1 root www-data 505 Oct 18  2020 200.conf
-rw-r----- 1 root www-data 518 Nov 12  2020 300.conf
```
