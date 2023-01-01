# OctoPrint in a ProxMox Container

## Sources

* [Setting-up OctoPrint](https://community.octoprint.org/t/setting-up-octoprint-on-a-raspberry-pi-running-raspbian-or-raspberry-pi-os/2337)

## Container

* Name: `octo`
* cores: 2
* RAM: 1GB
* HDD: 32GB
* Network: accept defaults, pick a fixed IP address
* Template: ubuntu 20.04

Pass through the USB ports for controller and webcam connection.

## Create User

Create user to run octoprint, say pi:

Add user/group pi
```sh
adduser pi
usermod -a -G adm,sudo,tty,dialout pi
```

## Install Dependencies

Update OS, install dependencies:
```sh
apt update
apt upgrade
apt install python3-pip python3-dev python3-setuptools python3-venv \
    git libyaml-dev build-essential
```
## Install OctoPrint

As user `pi`, create python venv:

```sh
mkdir ~/OctoPrint && cd ~/OctoPrint
python3 -m venv venv
source venv/bin/activate
```

Within that venv:

```sh
pip install pip --upgrade
pip install octoprint
```

For some plugins this is important:
```sh
pip install wheel setuptools
```
## Test Start

You should be able to start the OctoPrint server using:

```sh
pi@raspberrypi:~ $ ~/OctoPrint/venv/bin/octoprint serve
```

After you done with testing - shut it by Ctrl+C

## GUI

Should be available on `http://octo:5000`.

## Automatic Start-up

Setup the start-up script:
```sh
wget https://github.com/OctoPrint/OctoPrint/raw/master/scripts/octoprint.service && sudo mv octoprint.service /etc/systemd/system/octoprint.service
```

Add the script to autostart:
```
sudo systemctl enable octoprint.service
```

## Enable restart/shutdown via OctoPrint's system menu

In the UI, under Settings > Commands, configure the following commands:

* Restart OctoPrint: `sudo service octoprint restart`
* Restart system: `sudo shutdown -r now`
* Shutdown system: `sudo shutdown -h now`

## Passthrough USB port(s) and tty the to the OctoPrint Container



* [Passthrough USB port to an LXC Container](https://medium.com/@konpat/usb-passthrough-to-an-lxc-proxmox-15482674f11d)
* https://forum.proxmox.com/threads/usb-passthrough-to-a-container-lxc.101741/
* https://gist.github.com/crundberg/a77b22de856e92a7e14c81f40e7a74bd


Identify the USB port and tty to pass through:

```
root@suprox:~# lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 005: ID 2c99:0002 Prusa Original Prusa i3 MK3
Bus 001 Device 004: ID 0557:2419 ATEN International Co., Ltd
Bus 001 Device 003: ID 0557:7000 ATEN International Co., Ltd Hub
Bus 001 Device 002: ID 0764:0501 Cyber Power System, Inc. CP1500 AVR UPS
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

root@suprox:~# ls -la /dev/bus/usb/001/005
crw-rw-r-- 1 root root 189, 4 Dec 27 12:34 /dev/bus/usb/001/005

root@suprox:/var/log# ls -la /dev/ttyACM0
crw-rw---- 1 root dialout 166, 0 Dec 27 12:34 /dev/ttyACM0

```

Now we know that:

* we need to pass through `Bus 001 Device 005`
* the vendor is `2c99` and the product is `0002`
* note cgroup is `166`

My octoprint lxc ID is `103`, so I did:

```sh
mkdir -p /lxc/103/devices
cd /lxc/103/devices/
mknod -m 660 ttyACM0 c 166 0
chown 100000:100020 ttyACM0
```

Edit `/etc/pve/nodes/<host>/lxc/<id>.conf`, and add the following lines:

```
lxc.cgroup2.devices.allow: c 166:* rwm
lxc.mount.entry: /dev/bus/usb/001/005 dev/bus/usb/001/005 none bind,optional,create=file
lxc.mount.entry: /lxc/<id>/devices/ttyACM0 dev/ttyACM0 none bind,optional,create=file
```

Add `/etc/udev/rules.d/50-myusb.rules`:
```
SUBSYSTEM=="tty", ATTRS{idVendor}=="2c99", ATTRS{idProduct}=="0002", MODE="0666", SYMLINK+="prusa"
```

And then:
```
udevadm control --reload-rules && service udev restart && udevadm trigger
```

Restart the container.  Then in the container:

```
root@octo:~# lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 005: ID 2c99:0002 Prusa Research (prusa3d.com) Original Prusa i3 MK3
Bus 001 Device 004: ID 0557:2419 ATEN International Co., Ltd ABST600
Bus 001 Device 003: ID 0557:7000 ATEN International Co., Ltd Hub
Bus 001 Device 002: ID 0764:0501 Cyber Power System, Inc. CP1500 AVR UPS
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
root@octo:~# ls -la /dev/tty*
crw-rw-rw- 1 nobody nogroup   5, 0 Dec 27 22:50 /dev/tty
crw------- 1 root   tty     136, 1 Dec 27 22:52 /dev/tty1
crw--w---- 1 root   tty     136, 2 Dec 27 22:51 /dev/tty2
crw-rw---- 1 root   dialout 166, 0 Dec 27 22:41 /dev/ttyACM0
```
