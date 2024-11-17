# PrusaLink in an LXC Container on Proxmox

[Prusalink](https://help.prusa3d.com/article/prusa-connect-and-prusalink-explained_302608#what-is-prusalink)
"is the client-side running locally on your printer, accessible from local
network."  Except I am installing it in an LXC container on a ProxMox host,
which is connected to the printer via a USB cable.

Sources:

* [prusa-link-docker](https://github.com/donslice/prusa-link-docker)
* [Prusa-Link repo](https://github.com/prusa3d/Prusa-Link)

This is very similar to the way [I run octoprint](octoprint.html).

## Create an LXC Container

* host: prusalink
* template: Debian 12 standard 12.7-1
* disk: 16GB
* CPU cores: 2
* Memory: 1GB
* Network: DHCP, DHCP configured for static lease
* Firewall: off

Start the LXC.  At this point I usually:

* configure the static DHCP lease on my DHCP server for this LXC if the LXC
will expose a web service, the way prusalink will.
* disable ipv6 by adding `net.ipv6.conf.all.disable_ipv6=1` to
`/etc/sysctl.conf`

Restart the LXC and confirm (using `ip a`) the LXC is assigned the IP address
you expected.

## Upgrade OS

In the lxc console:
```sh
apt update
apt upgrade
```
## Install the Prerequisites

```sh
apt install -y git libcap-dev libturbojpeg0 libatlas-base-dev \
    libffi-dev gcc sudo
```
Install python prerequisites - not sure all thee are needed though:
```sh
apt install -y python3-dev python3-full python3-pip python3-numpy
```

## Create User pi
```sh
adduser pi
usermod -a -G adm,sudo,tty,dialout,video pi
```

The rest of the steps are executed in the context of user `pi`.

## Install PrusaLink Software

Login as user `pi`.  Create a dedicated virtual environment:
```sh
python3 -m venv venv-prusalink
```
and activate it:
```sh
source venv-prusalink/bin/activate
```
Install Prusa-Link software:
```sh
pip install --no-cache-dir \
    git+https://github.com/prusa3d/gcode-metadata.git \
    git+https://github.com/prusa3d/Prusa-Connect-SDK-Printer.git \
    git+https://github.com/prusa3d/Prusa-Link.git
```

Use `pip freeze` to list all the venv packages installed and their versions.

Prepare the PrusaLink directories:
```sh
sudo mkdir /etc/prusalink /usr/src/app
sudo chown -R pi:pi /etc/prusalink /usr/src/app
```
Create the default PrusaLink configuration file:
```sh
wget https://raw.githubusercontent.com/prusa3d/Prusa-Link/refs/heads/master/prusa/link/data/prusalink.ini
mv prusalink.ini /etc/prusalink/
```

## Passthrough USB port(s) and tty to the LXC

Identify the USB port and tty to pass through:
```
root@suprox:~# lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 003: ID 0c45:636b Microdia USB  Live camera
Bus 001 Device 008: ID 2c99:0002 Prusa Original Prusa i3 MK3
Bus 001 Device 005: ID 0557:2419 ATEN International Co., Ltd Virtual mouse/keyboard device
Bus 001 Device 004: ID 0557:7000 ATEN International Co., Ltd Hub
Bus 001 Device 006: ID 0764:0501 Cyber Power System, Inc. CP1500 AVR UPS
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

root@suprox:~# ls -la /dev/bus/usb/001/008
crw-rw-r-- 1 root root 189, 7 Nov 10 18:05 /dev/bus/usb/001/008

root@suprox:~# ls -la /dev/ttyACM0
crw-rw-rw- 1 root dialout 166, 0 Nov 10 18:05 /dev/ttyACM0
```

Now we know that:

* we need to pass through `Bus 001 Device 008`
* the vendor is `2c99` and the product is `0002`
* note cgroup is `189`

My `prusalink` lxc ID is `109`, so I did this on the proxmox:

```sh
mkdir -p /lxc/109/devices
cd /lxc/109/devices/
mknod -m 660 ttyACM0 c 189 0
chown 100000:100020 ttyACM0
```

Edit `/etc/pve/nodes/<host>/lxc/<id>.conf`, and add the following lines:
```
lxc.cgroup2.devices.allow: c 189:* rwm
lxc.mount.entry: /dev/bus/usb/001/008 dev/bus/usb/001/008 none bind,optional,create=file
lxc.mount.entry: /lxc/<id>/devices/ttyACM0 dev/ttyACM0 none bind,optional,create=file
```

Edit `/etc/udev/rules.d/50-usb.rules`:
```
SUBSYSTEM=="tty", ATTRS{idVendor}=="2c99", ATTRS{idProduct}=="0002", MODE="0666", SYMLINK+="prusa"
```
And then:
```
udevadm control --reload-rules && service udev restart && udevadm trigger
```

Reboot the LXC then login as `pi` and verify the port is indeed passed through:
```
pi@prusalink:~$ ls -la /dev/tty*
crw-rw-rw- 1 nobody nogroup   5, 0 Nov 17 00:17 /dev/tty
crw------- 1 pi     tty     136, 1 Nov 17 00:17 /dev/tty1
crw--w---- 1 root   tty     136, 2 Nov 17 00:17 /dev/tty2
crw-rw---- 1 root   dialout 166, 0 Nov 17 00:12 /dev/ttyACM0
```

## Configure PrusaLink

As user `pi`: `nano /etc/prusalink/prusalink.ini` to update the port configured
in the previous section:
```
[printer]
port = /dev/ttyACM0
```

## Start PrusaLink

First, let's start PrusaLink manually.  As user `pi` activate virtual
environment:
```sh
source venv-prusalink/bin/activate
```

Update the `/etc/prusalink/prusalink.ini` with the port configured in the
previous section:
```
[printer]
port = /dev/ttyACM0
```

By now you have everything to start prusalink:
```
(venv-prusalink) pi@prusalink:~$ which prusalink
/home/pi/venv-prusalink/bin/prusalink

(venv-prusalink) pi@prusalink:~$ prusalink -h
usage: prusalink [-h] [-f] [-c <file>] [-p <FILE>] [-a <ADDRESS>] [-t <PORT>] [-I] [-s <PORT>] [-n PRINTER_NUMBER] [-i] [-d] [-l MODULE_LOG_LEVEL] [--profile]
                 [--version]
                 [command]

PrusaLink daemon.

positional arguments:
  command               daemon action (start|stop|restart|status) (default: start)

options:
  -h, --help            show this help message and exit
  -f, --foreground      run as script on foreground
  -c <file>, --config <file>
                        path to config file (default: /etc/prusalink/prusalink.ini)
  -p <FILE>, --pidfile <FILE>
                        path to pid file
  -a <ADDRESS>, --address <ADDRESS>
                        IP listening address (host or IP)
  -t <PORT>, --tcp-port <PORT>
                        TCP/IP listening port
  -I, --link-info       /link-info debug page
  -s <PORT>, --serial-port <PORT>
                        Serial (printer's) port or 'auto'
  -n PRINTER_NUMBER, --printer-number PRINTER_NUMBER
                        Multi-instance printer number to show in wizard
  -i, --info            more verbose logging level INFO is set
  -d, --debug           DEBUG logging level is set
  -l MODULE_LOG_LEVEL, --module-log-level MODULE_LOG_LEVEL
                        sets the log level of any submodule(s). use <module_path>=<log_level>
  --profile             Use cProfile for profiling application.
  --version             Print out version info and exit

(venv-prusalink) pi@prusalink:~$ prusalink --version
PrusaLink version: 0.8.1
PrusaConnect-SDK version: 0.8.1
```

Start it in the foreground to do debugging
```sh
prusalink -f
```

Point your browser to `http://<ip>:8080` to complete configuration.

## Automatic Start-up

Create unit file `/etc/systemd/system/prusalink.service`,
[reference](https://www.freedesktop.org/software/systemd/man/latest/systemd.service.html#Options):

```
[Unit]
Description=PrusaLink Service
After=network.target
Wants=network-online.target

[Service]
Type=simple
User=pi
Group=pi
WorkingDirectory=/home/pi
Environment="LC_ALL=C.UTF-8"
Environment="LANG=C.UTF-8"
Environment="PATH=/home/pi/venv/bin:{{ ansible_env.PATH }}"
ExecStart=/home/pi/venv-prusalink/bin/python /home/pi/venv-prusalink/bin/prusalink start
ExecStop=/home/pi/venv-prusalink/bin/prusalink stop
Restart=on-abort

[Install]
WantedBy=multi-user.target
```

Enable the prusalink service:
```sh
sudo systemctl enable prusalink.service
```

## Webcam Config

TODO
