# kubuntu 22.04 in proxmox

## Hardware

Create VM

foo|bar
---|---
RAM|2GB, baloon=0
CPU|kvm64, 2c2t
BIOS|Default
Display|Spice 128MB
Machine|Default (i440fx), better q35
SCSI|VirtIO, single
HD|64GB, iothread=1
Net|bridge, disable firewall

Then add audio device with SPICE backend.


## Install Missing Packages

```sh
sudo apt install htop qemu-guest-agent emacs zsh
```

Then

```sh
sudo systemctl enable qemu-guest-agent
sudo systemctl start qemu-guest-agent
```

## Benchmark

http://speed-battle.com/speedtest_e.php


Platform|Calculate|Store|Render|OVERALL SCORE
--------|---------|-----|------|--
Bare Latitude + FireFox mint-001 - 1.0|186.18|132.13|143.72|462.03
VM i440fx + FireFox canonical-002 - 1.0|134.3|256|182.04|572.34
VM q35 + FireFox canonical-002 - 1.0|212.78|252.06|180.04|644.88

## Using Spice Client

Proxmox HTML GUI has a Javascript SPICE client built-in.

Native code SPICE client can be installed with
```sh
sudo apt install qemu-kvm virt-viewer
```
[virt-viewer man page](https://man.archlinux.org/man/virt-viewer.1.en)

Then:

* in Proxmox GUI select your VM
* in the toolbar on the right select Console\Spice

A native code client `remote-viewer` is launched with a temp file as an
argument:

```
[virt-viewer]
host=pvespiceproxy:64b1e41a:101:duo::a...73a
type=spice
title=VM 101 - kdesktop
password=72....9b
host-subject=OU=PVE Cluster Node,O=Proxmox Virtual Environment,CN=duo.localdomain
toggle-fullscreen=Shift+F11
secure-attention=Ctrl+Alt+Ins
tls-port=61000
ca=-----BEGIN CERTIFICATE-----\n...==\n-----END CERTIFICATE-----\n
release-cursor=Ctrl+Alt+R
delete-this-file=1
proxy=http://192.168.10.40:3128
```
