# OctoPrint in ProxMox VM

## Sources

[Setting-up OctoPrint](https://community.octoprint.org/t/setting-up-octoprint-on-a-raspberry-pi-running-raspbian-or-raspberry-pi-os/2337)

## VM

* cores: 2
* RAM: 1GB
* HDD: 32GB
* Network: accept defaults, pick a fixed IP address, set DNS name `octoprint`
* ISO: [debian-11.2.0-amd64-netinst](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.2.0-amd64-netinst.iso)

Pass through the USB ports for controller and webcam connection.

## Install OctoPrint

Update OS and install dependencies:
```sh
apt update
apt upgrade
apt install python3-pip python3-dev python3-setuptools python3-venv \
    git libyaml-dev build-essential
```

Add user/group pi
```sh
adduser -G adm,sudo,tty,dialout pi
```

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

## Start-Up

You should be able to start the OctoPrint server using:

```sh
pi@raspberrypi:~ $ ~/OctoPrint/venv/bin/octoprint serve
```

## GUI

Should be available on `http://octoprint:5000`.
