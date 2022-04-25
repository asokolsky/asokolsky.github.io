# ProxMox HOWTO

## Sources

* my experience
* https://www.youtube.com/watch?v=GoZaMgEgrHw

## Update repositories

You will get an error during the update:
```
Err:4 https://enterprise.proxmox.com/debian/pve buster InRelease
  401  Unauthorized [IP: 144.217.225.162 443]
```

It comes from /etc/apt/sources.list.d/pve-enterprise.list:
```
root@pve02:/etc/apt/sources.list.d# cat pve-enterprise.list
deb https://enterprise.proxmox.com/debian/pve buster pve-enterprise
```

You can disable it in the GUI and add there 'No Subscription' option.
Alternatively, change it to (mind version specific buser below):

```
root@pve02:/etc/apt/sources.list.d# cat pve-enterprise.list
# deb https://enterprise.proxmox.com/debian/pve buster pve-enterprise
```
And then:
```
root@pve02:/etc/apt# cat sources.list
deb http://ftp.us.debian.org/debian buster main contrib

deb http://ftp.us.debian.org/debian buster-updates main contrib

# security updates
deb http://security.debian.org buster/updates main contrib

# PVE pve-no-subscription repository provided by proxmox.com,
# NOT recommended for production use
deb http://download.proxmox.com/debian/pve buster pve-no-subscription
```

## Install useful tools

```console
# apt install ifupdown2 silversearcher-ag emacs-nox htop lm-sensors hddtemp nvme-cli
```

### Configure lm-sensors

```console
# sensors-detect
```

And finally:

```console
# watch -n 1 sensors
```
or just
```console
root@pve02:/etc/apt/sources.list.d# sensors
coretemp-isa-0000
Adapter: ISA adapter
Package id 0:  +36.0°C  (high = +94.0°C, crit = +100.0°C)
Core 0:        +35.0°C  (high = +94.0°C, crit = +100.0°C)
Core 1:        +35.0°C  (high = +94.0°C, crit = +100.0°C)
Core 2:        +36.0°C  (high = +94.0°C, crit = +100.0°C)
Core 3:        +34.0°C  (high = +94.0°C, crit = +100.0°C)
Core 4:        +32.0°C  (high = +94.0°C, crit = +100.0°C)
Core 5:        +32.0°C  (high = +94.0°C, crit = +100.0°C)

acpitz-acpi-0
Adapter: ACPI interface
temp1:        +27.8°C  (crit = +119.0°C)

pch_cannonlake-virtual-0
Adapter: Virtual device
temp1:        +44.0°C
```

## PCI Pass Through Config

Involves:

* changing boot command line
* adding kernel modules to load and, possibly, blacklist

See [gpu-passthrough.md](gpu-passthrough.md).

### Grub

in /etc/default/grub:
```sh
GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on iommu=pt intel_pstate=disable"
```

where `intel_pstate=disable` needed to [manage power](power.md).

Then:

```console
# update-grub
```

### VFIO Modules

Edit /etc/modules:
```
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
```

## Add the server to Datacenter/Cluster

Make sure the host has:

* unique host name
* networking is defined - can't change after
* no VMs

## Data Center Storage

Add connection to the NFS server:  Datacenter\Storage Add NFS

## Schedule Backups

Datacenter\Backup, Add

## Cron

### /etc/cron.daily

smart

```sh
{% include_relative cron.daily %}
```

### /etc/cron.weekly

fstrim

```sh
{% include_relative cron.weekly %}
```

## systemps script

```sh
{% include_relative systemps.sh %}
```

## Proxmox Tasks

* cli: [vm, container, template manipulation](cli.html),
[systemps.sh](systemps.sh)
* [GPU passthrough](gpu-passthrough.html)
* [Kernels cleanup](kernels.html)
* [network](network.html)
* [nut](nut.html)
* ProxMox as [file server](file-server.html) and [nas](nas.html)
* [Postfix as forwarder](postfix.html)
* [Power Saving](power.html)
* [Rapid VM Deployment with Cloud Init and Terraform](cloud-init.html)

## Guest Tasks

* [disk resize](guest-disk-resize.html)
* [performance optimization](guest-performance.html)

## By Guest Type

* [centos7](centos7.html)
* [octoprint](octoprint.html)
* [pfSense in a VM](pfSense.html)
* [TrueNAS Core in a VM](truenas.html)
* [Unifi Controller in a Container](unifi.html)
