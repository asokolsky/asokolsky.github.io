# OctoPrint in a ProxMox Container

## Sources

* [Setting-up OctoPrint](https://community.octoprint.org/t/setting-up-octoprint-on-a-raspberry-pi-running-raspbian-or-raspberry-pi-os/2337)
* [Passthrough USB port to an LXC Container](https://medium.com/@konpat/usb-passthrough-to-an-lxc-proxmox-15482674f11d)

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

## Passthrough USB ports to the OctoPrint Container

[Passthrough USB ports to LXC Container](https://medium.com/@konpat/usb-passthrough-to-an-lxc-proxmox-15482674f11d)


Edit `/etc/pve/nodes/pve/lxc/<id>.conf`, edit the following lines:

```
lxc.cgroup.devices.allow: c 189:* rwm
lxc.mount.entry: /dev/bus/usb/001/016 dev/bus/usb/001/016 none bind,optional,create=file
```
