# TrueNAS Scale Customization

I [run it](/proxmox/guest-truenas.html) in a VM.

* [TrueNAS Core](truenas-core.html)
* [TrueNAS Scale as a syslog collector](syslog-collector.html)
* [TrueCharts Catalog](true-charts.html)

Now version ElectricEel-24.10.2:
```
root@nass[~]# uname -a
Linux nass 6.6.44-production+truenas #1 SMP PREEMPT_DYNAMIC Tue Jan 28 03:14:06 UTC 2025 x86_64 GNU/Linux

root@nass[~]#  lsb_release -a
No LSB modules are available.
Distributor ID: Debian
Description:    Debian GNU/Linux 12 (bookworm)
Release:        12
Codename:       bookworm

root@nass[~]# cat /etc/version
24.10.2

root@nass[~]# cat /etc/debian_version
12.6
```

## Enable apt for package management

As of version 24 `/usr` is mounted ro.  To change that - [enable developer mode](https://www.truenas.com/docs/scale/scaletutorials/systemsettings/advanced/developermode/).

```sh
sudo chmod a+x /usr/bin/apt*
sudo chmod a+x /usr/bin/dpkg
```

Before you install new packages, do:

```sh
sudo apt update
```

Then install packages as usual:
```sh
sudo apt install emacs-nox usbutils
```

## Drive Spin Down

https://github.com/ngandrass/truenas-spindown-timer


## VM Setup

* [video](https://www.youtube.com/watch?v=R7BXEuKjJ0k)
* [post](https://forum.level1techs.com/t/truenas-scale-ultimate-home-setup-incl-tailscale/186444)

## Running Apps (k3s)

* Set up [TrueCharts app catalog](true-charts.html)
