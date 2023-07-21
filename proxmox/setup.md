# Proxmox Set-up


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

```sh
apt install ifupdown2 ethtool silversearcher-ag emacs-nox htop lm-sensors \
  nvme-cli linux-cpupower cpufrequtils sysstat
```

### Set the CPU governor

```sh
cat << 'EOF' > /etc/default/cpufrequtils
GOVERNOR="powersave"
EOF
```

### Configure lm-sensors

```sh
sensors-detect
```

And finally:

```sh
watch -n 1 sensors
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

See [pcie-passthrough.md](pcie-passthrough.html).

## Add the server to Datacenter / Cluster

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

Requires:
```
apt install nvme-cli
```

```sh
{% include_relative systemps.sh %}
```

## Check for IO bottleneck:

Use [iostat](https://www.man7.org/linux/man-pages/man1/iostat.1.html):

```
root@fuji:~# iostat -mxy 10
Linux 5.15.83-1-pve (fuji) 	01/31/2023 	_x86_64_	(8 CPU)


avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           1.00    0.00    0.48    0.05    0.00   98.47

Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz     w/s     wMB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dMB/s   drqm/s  %drqm d_await dareq-sz     f/s f_await  aqu-sz  %util
dm-0             0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
dm-1             0.00      0.00     0.00   0.00    0.00     0.00   96.40      0.38     0.00   0.00    0.32     4.03    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.03   0.36
dm-10            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
dm-11            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
dm-12            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
dm-13            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
dm-14            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
dm-15            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
dm-16            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
dm-17            0.00      0.00     0.00   0.00    0.00     0.00   12.00      0.05     0.00   0.00    0.00     4.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.04
dm-18            0.00      0.00     0.00   0.00    0.00     0.00    0.20      0.00     0.00   0.00    0.00     4.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.08
dm-19            0.00      0.00     0.00   0.00    0.00     0.00    0.20      0.00     0.00   0.00    0.00     4.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.08
dm-2             0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
dm-3             0.00      0.00     0.00   0.00    0.00     0.00   15.30      0.06     0.00   0.00    0.05     4.03    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.44
dm-4             0.00      0.00     0.00   0.00    0.00     0.00   15.30      0.06     0.00   0.00    0.05     4.03    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.44
dm-6             0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
dm-7             0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
dm-8             0.00      0.00     0.00   0.00    0.00     0.00    2.90      0.01     0.00   0.00    0.28     4.14    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.28
dm-9             0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
nvme0n1          0.60      0.07     0.00   0.00    0.83   128.00   46.50      0.44    65.20  58.37    1.27     9.68    0.00      0.00     0.00   0.00    0.00     0.00    0.30    0.67    0.06   0.92
sda              0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
```
