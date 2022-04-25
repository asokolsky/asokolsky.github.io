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
