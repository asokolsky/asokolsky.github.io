# Suprox all-in-one Home Server

A single-home-server solution.

Runs VMs:

* [pfSense router](/proxmox/guest-pfSense.html)
with an i350-T2 NIC passed through;
* [TrueNAS](/proxmox/guest-truenas.html) with
[an on-board SATA](/proxmox/pcie-passthrough-sata.html) passed-through.
May also have a second I210 NIC passed through.
* [Home Assistant on HAOS](/proxmox/guest-home-assistant.html).

Runs LXCs:

* [Unifi Controller](/proxmox/lxc-unifi.html)
* [octoprint](/proxmox/lxc-octoprint.html)
* dynamo
* mqtt
* vault

in docker containers:

* [portainer](/apps/docker/portainer.md);
* [mjpg-streamer](/proxmox/mjpg-streamer-docker.html) for use by octoprint.

## Hardware

To minimize the noise I use a 150W PicoPSU.

Item|Description
----|----------
CPU|Intel [i3-8100](https://ark.intel.com/content/www/us/en/ark/products/126688/intel-core-i3-8100-processor-6m-cache-3-60-ghz.html) 4C/4T 3.6 GHz LGA1151 65W BX80684I38100 Coffee Lake
Motherboard|Supermicro [X11SCL-IF](https://www.supermicro.com/en/products/motherboard/x11scl-if) miniITX LGA1151 C242
BMC|ASpeed AST 2500
BIOS|1.5 10/5/2020
BMC f/w|1.23.06
RAM|32GB (2x16GB) 288-Pin UDIMM ECC DDR4 2666 MT/s PC4-21300 - Micron [18ASF2G72AZ-2G6E1](https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/modules/unbuffered_dimm/ddr4/asf18c2gx72az.pdf?rev=afcfe5974940462e8667ea8eccc014fb)
SSD|500GB WD Blue SN550 NVMe SSD, Gen3x4 PCIe 8Gb/s, M.2 2280, 2,400 MB/s, WDS500G2B0C
NIC|2x Intel I210 on motherboard
NIC|Intel i350-T2
PSU|Mini Box PicoPSU-150-XT 12V DC-DC ATX
.|Mini Box 10A 120W 110-240V AC to 12V DC PicoPSU Compatible
Case|Supermicro SuperChassis [721TQ-350B2](https://www.supermicro.com/en/products/chassis/Compact%20Mini-Tower/721/SC721TQ-350B2)
Case fan|Noctua [NF-A12x25 LS-PWM](https://noctua.at/en/nf-a12x25-pwm), 4-Pin, 120mm
/dev/sda|SAMSUNG 870 QVO SATA3 SSD 4TB 2.5" MZ-77Q4T0B
/dev/sdb|SAMSUNG 870 QVO SATA3 SSD 4TB 2.5" MZ-77Q4T0B

* [DMI Info](dmi.html)
* [PCIe Devices](lspci.html)
* [IOMMU](iommu.html)

<p align="center" width="100%">
    <img width="66%" src="suprox-front.png">
    <img width="66%" src="suprox-back.png">
</p>

* [DMI Info](dmi.html)
* [IOMMU info](iommu.html)
* [Storage Devices](lsblk.html)
* [USB Devices](lsusb.html)

## OS - Proxmox

Virtualization server with VMs:

* pfSense
* NAS
* haos (home assistant)

and LXC containers:

* unicon
* octo
* dynamo
* mqtt
* vault

## Containers - Portainer

Besides, portainer, which runs as a container:

* mjpg-streamer

## VMs

### pfSense VM

```
root@suprox:/etc/pve/local/qemu-server# cat 100.conf
## pfSense VM
#
#http%3A//192.168.11.1
#
#Prometheus%3A http%3A//192.168.11.1%3A9100/metrics
agent: 1
balloon: 0
boot: order=scsi0;ide2
cores: 2
cpu: kvm64,flags=+pdpe1gb;+aes
hostpci0: 0000:01:00,pcie=1
ide2: none,media=cdrom
machine: q35
memory: 12300
name: pfSense
numa: 0
onboot: 1
ostype: other
scsi0: local-lvm:vm-100-disk-0,iothread=1,size=32G
scsihw: virtio-scsi-single
smbios1: uuid=a1ac928f-ec64-41ca-9f84-47f588b42b63
sockets: 1
startup: order=1
tablet: 0
vmgenid: 7ab697f0-2f53-42b9-81f7-a4ee25a106ff
```

### TrueNAS VM

```
root@suprox:/etc/pve/local/qemu-server# cat 101.conf
## TrueNAS VM
#
#http%3A//192.168.11.30/
agent: 1
balloon: 0
boot: order=scsi0;ide2;net0
cores: 2
cpu: host
hostpci0: 0000:00:17.0,rombar=0
ide2: none,media=cdrom
machine: q35
memory: 12000
name: nas
net0: virtio=0E:5D:7E:B7:19:4D,bridge=vmbr0,queues=8
numa: 0
onboot: 1
ostype: l26
scsi0: local-lvm:vm-101-disk-0,iothread=1,size=32G
scsihw: virtio-scsi-single
smbios1: uuid=aa5ee900-1955-43b1-87bf-865730f6d47c
sockets: 1
startup: order=10
tablet: 0
vmgenid: 64d3d2f8-2ce6-4f9c-8899-95145c5df810
```

### HAOS VM

```
root@suprox:/etc/pve/local/qemu-server# cat 106.conf
## Home Assistant OS VM
#
#http%3A//192.168.11.40%3A8123
agent: 1
bios: ovmf
boot: order=scsi0
cores: 2
efidisk0: local-lvm:vm-106-disk-0,efitype=4m,size=4M
localtime: 1
memory: 4096
meta: creation-qemu=7.0.0,ctime=1667527006
name: haos
net0: virtio=00:60:2F:F2:F7:29,bridge=vmbr0
onboot: 1
ostype: l26
scsi0: local-lvm:vm-106-disk-1,cache=writeback,discard=on,iothread=1,size=32G,ssd=1
scsihw: virtio-scsi-single
smbios1: uuid=0628e306-07b7-4e65-bb9d-7000f922c467
startup: order=500
tablet: 0
vmgenid: c7f96adb-c708-4810-ba6b-3e59214b03e1
```
