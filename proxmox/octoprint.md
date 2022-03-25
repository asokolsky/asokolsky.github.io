# OctoPrint in ProxMox VM

## Sources

[Setting-up OctoPrint](https://community.octoprint.org/t/setting-up-octoprint-on-a-raspberry-pi-running-raspbian-or-raspberry-pi-os/2337)

## VM

* cores: 2
* RAM: 1GB
* HDD: 32GB
* ISO: [debian-11.2.0-amd64-netinst](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.2.0-amd64-netinst.iso)

## Install OctoPrint

Add user/group pi

```sh
sudo usermod -a -G tty pi
sudo usermod -a -G dialout pi
```

Create python venv:

```sh
cd ~
sudo apt update
sudo apt upgrade
sudo apt install python3-pip python3-dev python3-setuptools python3-venv \
    git libyaml-dev build-essential
mkdir OctoPrint && cd OctoPrint
python3 -m venv venv
source venv/bin/activate
```

Within that venv:

```sh
pip install pip --upgrade
pip install octoprint
```

## Start-Up

You should then be able to start the OctoPrint server using the octoprint serve
command:

```sh
pi@raspberrypi:~ $ ~/OctoPrint/venv/bin/octoprint serve
```

## GUI

Should be available on `http://octoprint:5000`.
