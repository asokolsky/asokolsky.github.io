# PrusaLink in an LXC Container on Proxmox

[Prusalink](https://help.prusa3d.com/article/prusa-connect-and-prusalink-explained_302608#what-is-prusalink)
"is the client-side running locally on your printer, accessible from local
network."  Except I am installing it in an LXC container on a ProxMox host,
which is connected to the printer via a USB cable.

Sources:

* [prusa-link-docker](https://github.com/donslice/prusa-link-docker)
* [Prusa-Link repo](https://github.com/prusa3d/Prusa-Link)

This is similar to the way I used to [run octoprint](lxc-octoprint.html).

## Create an LXC Container

* host: prusalink (pick your own name as desired)
* template: Debian 12 standard 12.7-1
* disk: 8GB
* CPU cores: 2
* Memory: 512MB
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

In the lxc console, after logging in as a root:
```sh
apt update
apt upgrade
```
## Install the Prerequisites

```sh
apt install -y git libcap-dev libturbojpeg0 libatlas-base-dev \
    libffi-dev gcc sudo ffmpeg curl
```
Note: `ffmpeg` is for webcam - skip it if you do not use one.

Install python prerequisites - not sure all these are needed though:
```sh
apt install -y python3-dev python3-full python3-pip python3-numpy
```

## Create User pi
Still in the console as root:
```sh
adduser pi
usermod -a -G adm,sudo,tty,dialout,video pi
```
Group `dialout` membership is required in order to talk to the printer via USB
port. Group `video` membership is required in order to get images from the
webcam.

The next steps are executed in the context of user `pi`.

## Install PrusaLink Software

Login as user `pi`.  Create a dedicated virtual environment:
```sh
python3 -m venv venv-prusalink
```
and activate it:
```sh
source venv-prusalink/bin/activate
```
Install Prusa-Link software into the virtual environment:
```sh
pip install --no-cache-dir \
    git+https://github.com/prusa3d/gcode-metadata.git \
    git+https://github.com/prusa3d/Prusa-Connect-SDK-Printer.git \
    git+https://github.com/prusa3d/Prusa-Link.git
```

Use `pip freeze` to list all the venv packages installed and their versions.

## Create PrusaLink Directories

Prepare the PrusaLink directories:
```sh
sudo mkdir /etc/prusalink
sudo chown -R pi:pi /etc/prusalink
```
Create the default PrusaLink configuration file:
```sh
wget https://raw.githubusercontent.com/prusa3d/Prusa-Link/refs/heads/master/prusa/link/data/prusalink.ini
mv prusalink.ini /etc/prusalink/
```

## Pass Through Printer's USB port and tty to the LXC

Identify the printer's USB port and tty to pass through:
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

As user `pi`: edit `/etc/prusalink/prusalink.ini` to update the port configured
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

Start prusalink in the foreground to do debugging:
```sh
prusalink -f
```

Point your browser to `http://<ip>:8080` to complete configuration.

## Automatic Start-up

To make sure prusalink auto-starts, let's create a
[systemd service](https://en.wikipedia.org/wiki/Systemd).

Create
[unit file](https://www.freedesktop.org/software/systemd/man/latest/systemd.unit.html)
`/etc/systemd/system/prusalink.service`,
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
ExecStart=/home/pi/venv-prusalink/bin/prusalink start
ExecStop=/home/pi/venv-prusalink/bin/prusalink stop
Restart=on-abort

[Install]
WantedBy=multi-user.target
```

Enable the prusalink service:
```sh
sudo systemctl enable prusalink.service
```
[More on systemctl](/linux/cli-systemctl.html) and
[systemctl services](/linux/cli-systemctl-services.html).


To (re)start the service:
```sh
sudo systemctl restart prusalink.service
```
To check the service status:
```sh
systemctl status prusalink.service --no-pager
```

To check the prusalink service logs:
```sh
journalctl --no-pager --unit=prusalink
```
[More on journalctl](/linux/cli-journalctl.html)

## Passthrough USB Webcam Device(s) to the LXC Container

### Prepare the Proxmox Node Device(s)

Identify the USB device associated with the webcam on the proxmox host:
```
root@suprox:~# lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 003: ID 0c45:636b Microdia USB  Live camera
Bus 001 Device 008: ID 2c99:0002 Prusa Original Prusa i3 MK3
Bus 001 Device 005: ID 0557:2419 ATEN International Co., Ltd Virtual mouse/keyboard device
Bus 001 Device 004: ID 0557:7000 ATEN International Co., Ltd Hub
Bus 001 Device 006: ID 0764:0501 Cyber Power System, Inc. CP1500 AVR UPS
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```
Looks like the webcam is device `003` on the bus `001`:
```
root@suprox:~# ls -la /dev/bus/usb/001/003
crw-rw-r-- 1 root root 189, 2 Nov 16 17:10 /dev/bus/usb/001/003
```
Note cgroup is `189`, we will need this information later.

Set the owner of the webcam device on the pve node to the unprivileged uid of
your container (100000 by default):
```sh
chown 100000:100000 /dev/bus/usb/001/003
```

Check the [V4L](https://en.wikipedia.org/wiki/Video4Linux) devices:
```
root@suprox:~#  ls -la /dev/video*
crw-rw---- 1 root video 81, 0 Nov 16 17:10 /dev/video0
crw-rw---- 1 root video 81, 1 Nov 16 17:10 /dev/video1
```

Set the owner of V4L devices on the pve node to the unprivileged uid of
your container (100000 by default) and group video:
```
root@suprox:~# grep video /etc/group
video:x:44:
root@suprox:~# chown 100000:100044 /dev/video0
root@suprox:~# chown 100000:100044 /dev/video1
root@suprox:~# ls -la /dev/video*
crw-rw---- 1 100000 100044 81, 0 Nov 16 17:10 /dev/video0
crw-rw---- 1 100000 100044 81, 1 Nov 16 17:10 /dev/video1
```

To summarize:

* we need to pass through `Bus 001 Device 003`;
* the vendor is `0c45` and the product is `636b`;
* the cgroup is `189`;
* prusalink container ID is `109`.

Edit `/etc/pve/lxc/109.conf`, and add the following lines:
```
lxc.cgroup2.devices.allow: c 189:* rwm
lxc.mount.entry: /dev/bus/usb/001/003 dev/bus/usb/001/003 none bind,optional,create=file
lxc.mount.entry: /dev/video0 dev/video0 none bind,optional,create=file
lxc.mount.entry: /dev/video1 dev/video1 none bind,optional,create=file
```

### Check the webcam devices in the PrusaLink LXC Container

Restart yur LXC prusalink container in order for the changes made in the
previous section to take the effect.

Verify that the webcam devices are now exposed in the container.  In the LXC
console as a root:

```
root@prusalink:~# ls -la /dev/bus/usb/001/003
crw-rw-r-- 1 root root 189, 2 Nov 17 01:10 /dev/bus/usb/001/003
root@prusalink:~# ls -la /dev/video*
crw-rw---- 1 root video 81, 0 Nov 17 01:10 /dev/video0
crw-rw---- 1 root video 81, 1 Nov 17 01:10 /dev/video1
```

To identify the V4L device to use I installed into the container
[ffmpeg](/apps/ffmpeg.html) with
`apt install ffmpeg` and then identified the formats supported by the webcam:

```
root@prusalink:~# ffmpeg -f v4l2 -list_formats all -i /dev/video0
...
[video4linux2,v4l2 @ 0x63f41de2fe00] Compressed:       mjpeg :          Motion-JPEG : 640x480 1600x896 1280x720 1024x768 1024x576 960x544 864x480 848x480 800x448 640x360 352x288 320x240 1920x1080
[video4linux2,v4l2 @ 0x63f41de2fe00] Raw       :     yuyv422 :           YUYV 4:2:2 : 640x480 1600x896 1280x720 1024x768 1024x576 960x544 864x480 848x480 800x448 640x360 352x288 320x240 1920x1080
```

For `/dev/video1` this command fails:
```
root@prusalink:~# ffmpeg -f v4l2 -list_formats all -i /dev/video1
...
[video4linux2,v4l2 @ 0x5892f8f6ce00] ioctl(VIDIOC_G_INPUT): Inappropriate ioctl for device
```

### Connect LXC Container webcam to PrusaConnect

This broadly follows
[Use Raspberry Pi and Pi Cam for Prusa Connect](https://gist.github.com/p123ad/5b1482200715d834e9db736fa9e187d0).

Get the token:

* Go to the Cameras section at https://connect.prusa3d.com
* Add a new camera "Add new other camera".
* Copy the generated Token

Create `~pi/prusaconnect_upload_cam.sh`
```
#!/bin/bash
#
# Script is from
# https://gist.github.com/moritzmhmk/48e5ed9c4baa5557422f16983900ca95
# https://gist.github.com/nunofgs/84861ee453254823be6b069ebbce9ad2

# Set default values for environment variables
: "${HTTP_URL:=https://connect.prusa3d.com/c/snapshot}"
: "${DELAY_SECONDS:=10}"
: "${LONG_DELAY_SECONDS:=60}"
# FINGERPRINT is a random string with at least 16 characters
: "${FINGERPRINT:=123456789012345678}"
# CAMERA_TOKEN generated by the Connect server
: "${CAMERA_TOKEN:=put the token here}"
# V4L device to use
: "${V4L_DEVICE:=/dev/video0}"


while true; do
  # Grab a frame from the webcam using FFmpeg, -video_size 1280x720
  ffmpeg -loglevel warning -y -f video4linux2 -input_format mjpeg \
    -i "$V4L_DEVICE" -video_size 1280x720 -vframes 1 -f mjpeg /tmp/output.jpg

  # If no error, upload it.
  if [ $? -eq 0 ]; then
    # POST the image to the HTTP URL using curl
    curl -X PUT "$HTTP_URL" \
      -H "accept: */*" \
      -H "content-type: image/jpg" \
      -H "fingerprint: $FINGERPRINT" \
      -H "token: $CAMERA_TOKEN" \
      --data-binary "@/tmp/output.jpg" \
      --no-progress-meter \
      --compressed

    # Reset delay to the normal value
    DELAY=$DELAY_SECONDS
  else
    echo "FFmpeg returned an error. Retrying after ${LONG_DELAY_SECONDS}s..."
    # Set delay to the longer value
    DELAY=$LONG_DELAY_SECONDS
  fi
  sleep "$DELAY"
done
```
Then `chmod +x prusaconnect_upload_cam.sh`.

Start the script with `./prusaconnect_upload_cam.sh`

If it works you should see the images appearing in Prusa Connect every 10
seconds.

Create unit file
`/etc/systemd/system/prusaconnect_upload_cam.service`:
```
[Unit]
Description=WebCam to Prusa Connect
After=network.target
Wants=network-online.target

[Service]
User=pi
Group=pi
WorkingDirectory=/home/pi
ExecStart=/home/pi/prusaconnect_upload_cam.sh

[Install]
WantedBy=multi-user.target
```
Then:
```sh
sudo systemctl enable prusaconnect_upload_cam.service
```
Start it:
```sh
sudo systemctl start prusaconnect_upload_cam.service
```

By now, every time your LXC starts:

* prusalink.service is launched and connects your printer to prusaconnect.
* prusaconnect_upload_cam.service starts uploading webcam images every 10
seconds

## Adding a Second Webcam

After plugging the webcam into the server, and in the host shell as a root...

### Host USB Devices

Identify the USB device:
```
root@suprox:~# lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 003: ID 0c45:636b Microdia USB  Live camera
Bus 001 Device 008: ID 2c99:0002 Prusa Original Prusa i3 MK3
Bus 001 Device 010: ID 1bcf:28c4 Sunplus Innovation Technology Inc. FHD Camera Microphone
Bus 001 Device 005: ID 0557:2419 ATEN International Co., Ltd Virtual mouse/keyboard device
Bus 001 Device 004: ID 0557:7000 ATEN International Co., Ltd Hub
Bus 001 Device 006: ID 0764:0501 Cyber Power System, Inc. CP1500 AVR UPS
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```
I see a new FHD Camera Microphone... but not the camera?  Check the USB device:

```
root@suprox:~# ls -la /dev/bus/usb/001/010
crw-rw-r-- 1 root root 189, 9 Nov 23 10:37 /dev/bus/usb/001/010
```
Change the device ownership:
```sh
chown 100000:100000 /dev/bus/usb/001/010
```

### Host V4L Devices

Check the V4L devices:
```
root@suprox:~# ls -la /dev/video*
crw-rw---- 1 100000 100044 81, 0 Nov 16 17:10 /dev/video0
crw-rw---- 1 100000 100044 81, 1 Nov 16 17:10 /dev/video1
crw-rw---- 1 root   video  81, 2 Nov 23 10:37 /dev/video2
crw-rw---- 1 root   video  81, 3 Nov 23 10:37 /dev/video3
```
I see two new devices: video2 and video3, change their ownership and
permissions:
```sh
chown 100000:100044 /dev/video2
chown 100000:100044 /dev/video3
```

### Passing the Host Devices through to the LXC Container

To summarize:

* we need to pass through `Bus 001 Device 010`
* the vendor is `1bcf` and the product is `28c4`
* the cgroup is `189`
* prusalink container ID is 109

Edit `/etc/pve/lxc/109.conf`:
```
root@suprox:~# cat /etc/pve/lxc/109.conf
## PrusaLink LXC
#
#http%3A//192.168.11.78%3A8080
arch: amd64
cores: 2
features: nesting=1
hostname: prusalink
memory: 512
net0: name=eth0,bridge=vmbr0,hwaddr=BC:24:11:4E:61:25,ip=dhcp,ip6=auto,type=veth
onboot: 1
ostype: debian
rootfs: local-lvm:vm-109-disk-0,size=16G
startup: order=200
swap: 100
unprivileged: 1
lxc.cgroup2.devices.allow: c 189:* rwm
lxc.mount.entry: /dev/bus/usb/001/003 dev/bus/usb/001/003 none bind,optional,create=file
lxc.mount.entry: /dev/bus/usb/001/008 dev/bus/usb/001/008 none bind,optional,create=file
lxc.mount.entry: /dev/bus/usb/001/010 dev/bus/usb/001/010 none bind,optional,create=file
lxc.mount.entry: /lxc/109/devices/ttyACM0 dev/ttyACM0 none bind,optional,create=file
lxc.mount.entry: /dev/video0 dev/video0 none bind,optional,create=file
lxc.mount.entry: /dev/video1 dev/video1 none bind,optional,create=file
lxc.mount.entry: /dev/video2 dev/video2 none bind,optional,create=file
lxc.mount.entry: /dev/video3 dev/video3 none bind,optional,create=file
```

### LXC Container - Devices Verification

After the LXC container restart, in the container console:
```
pi@prusalink:~$ ls -la /dev/bus/usb/001/003
crw-rw-r-- 1 root root 189, 2 Nov 17 01:10 /dev/bus/usb/001/003

pi@prusalink:~$ ls -la /dev/bus/usb/001/010
crw-rw-r-- 1 root root 189, 9 Nov 23 18:37 /dev/bus/usb/001/010

pi@prusalink:~$ ls -la /dev/video*
crw-rw---- 1 root video 81, 0 Nov 17 01:10 /dev/video0
crw-rw---- 1 root video 81, 1 Nov 17 01:10 /dev/video1
crw-rw---- 1 root video 81, 2 Nov 23 18:37 /dev/video2
crw-rw---- 1 root video 81, 3 Nov 23 18:37 /dev/video3
```
Looks like the new USB and V4L devices ARE available to LXC.

Verify the new V4L device capabilities:
```
pi@prusalink:~$ ffmpeg -f v4l2 -list_formats all -i /dev/video2
...
[video4linux2,v4l2 @ 0x56871cf0fe00] Compressed:       mjpeg :          Motion-JPEG : 640x480 1600x896 1280x720 1024x576 800x600 800x480 640x360 424x240 352x288 1920x1080
[video4linux2,v4l2 @ 0x56871cf0fe00] Raw       :     yuyv422 :           YUYV 4:2:2 : 640x480 1600x896 1280x720 1024x576 800x600 800x480 640x360 424x240 352x288 1920x1080
```

### LXC Container - Update the Upload Script to work with the second camera

Create `~pi/prusaconnect_upload_cams.sh`

```
{% prusaconnect_upload_cams.sh %}
```
update the service file and restart it!

It works!

## Known Problems

* Framerate of 0.1 fps is...low.  Seems to be a PrusaConnect limitation.
* Constant (every 10secs) writing of the video frame to the disk is wearing SSD
down.  If only I had a writable `tmpfs` file system inside the container...
