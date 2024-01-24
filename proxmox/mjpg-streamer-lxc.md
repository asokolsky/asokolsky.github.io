# mjpg-streamer in an LXC Container on Proxmox

Streaming video from a USB webcam connected to a Proxmox node via
[mjpg-streamer](https://github.com/jacksonliam/mjpg-streamer) deployed in an
LXC container.

## Create an LXC

I created a debian-based LSC.  Because there is a need to compile sources,
I allocated 2 cores and 2GB of RAM.

## Build mjpg-streamer

```sh
apt-get update
apt-get install git cmake gcc g++
```

Package `libjpeg8-dev` was not found.  Instead I did:

`apt-get install libjpeg-dev`

will also need:

```sh
apt-get install ffmpeg v4l-utils psmisc
```

Then:
```sh
git clone https://github.com/jacksonliam/mjpg-streamer.git
```

```
root@mjpg-streamer:~/mjpg-streamer/mjpg-streamer-experimental# make
root@mjpg-streamer:~/mjpg-streamer/mjpg-streamer-experimental# make install
```

### mjpg-streamer service installation

as root:

```
git clone https://github.com/john-clark/mjpg-streamer-setup.git
cd mjpg-streamer-setup
./installWebcams instal
```

## Passthrough USB webcam port(s) to the LXC Container

```
root@suprox:~# lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 011: ID 0c45:636b Microdia USB  Live camera
Bus 001 Device 010: ID 2c99:0002 Prusa Original Prusa i3 MK3
Bus 001 Device 004: ID 0557:2419 ATEN International Co., Ltd
Bus 001 Device 003: ID 0557:7000 ATEN International Co., Ltd Hub
Bus 001 Device 002: ID 0764:0501 Cyber Power System, Inc. CP1500 AVR UPS
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

root@suprox:~# ls -la /dev/bus/usb/001/011
crw-rw-r-- 1 root root 189, 10 Feb  4 16:16 /dev/bus/usb/001/011
```

Set the owner of `/dev/bus/usb/001/011` on pve node to the unprivileged uid of
your container (100000 by default):
```
chown 100000:100000 /dev/bus/usb/001/011
```

Set the owner of `/dev/video0` on pve node to the unprivileged uid of
your container (100000 by default) and group video:

```
root@suprox:~# ls -la /dev/video0
crw-rw---- 1 root video 81, 0 Feb  4 16:16 /dev/video0
root@suprox:~# grep video /etc/group
video:x:44:
root@suprox:~# chown 100000:100044 /dev/video0
```

Now we know that:

* we need to pass through `Bus 001 Device 011`
* the vendor is `0c45` and the product is `636b`
* note cgroup is `189`

My `mjpg-streamer` lxc ID is `108`.
Edit `/etc/pve/lxc/108.conf`, and add the following lines:

```
lxc.cgroup2.devices.allow: c 189:* rwm
lxc.mount.entry: /dev/bus/usb/001/011 dev/bus/usb/001/011 none bind,optional,create=file
lxc.mount.entry: /dev/video0 dev/video0 none bind,optional,create=file
```

Now in the container:

```
root@mjpg-streamer:~# ls -la /dev/bus/usb/001/011
crw-rw-r-- 1 root root 189, 10 Feb  5 00:16 /dev/bus/usb/001/011
root@mjpg-streamer:~# ls -la /dev/video0
crw-rw---- 1 root video 81, 0 Feb  5 00:16 /dev/video0
```

Show formats supported by the webcam:

```
# ffmpeg -f v4l2 -list_formats all -i /dev/video0
...
[video4linux2,v4l2 @ 0x561a198da280] Compressed:       mjpeg :          Motion-JPEG : 640x480 1600x896 1280x720 1024x768 1024x576 960x544 864x480 848x480 800x448 640x360 352x288 320x240 1920x1080
[video4linux2,v4l2 @ 0x561a198da280] Raw       :     yuyv422 :           YUYV 4:2:2 : 640x480 1600x896 1280x720 1024x768 1024x576 960x544 864x480 848x480 800x448 640x360 352x288 320x240 1920x1080
/dev/video0: Immediate exit requested
```

Alternatively:

```
# v4l2-ctl --list-formats
ioctl: VIDIOC_ENUM_FMT
        Type: Video Capture

        [0]: 'MJPG' (Motion-JPEG, compressed)
        [1]: 'YUYV' (YUYV 4:2:2)
```
or even
```
# v4l2-ctl --list-formats-ext
ioctl: VIDIOC_ENUM_FMT
        Type: Video Capture

        [0]: 'MJPG' (Motion-JPEG, compressed)
                Size: Discrete 640x480
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 1600x896
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 1280x720
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 1024x768
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 1024x576
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 960x544
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 864x480
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 848x480
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 800x448
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 640x360
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 352x288
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 320x240
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 1920x1080
                        Interval: Discrete 0.033s (30.000 fps)
        [1]: 'YUYV' (YUYV 4:2:2)
                Size: Discrete 640x480
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 1600x896
                        Interval: Discrete 0.200s (5.000 fps)
                Size: Discrete 1280x720
                        Interval: Discrete 0.100s (10.000 fps)
                Size: Discrete 1024x768
                        Interval: Discrete 0.100s (10.000 fps)
                Size: Discrete 1024x576
                        Interval: Discrete 0.100s (10.000 fps)
                Size: Discrete 960x544
                        Interval: Discrete 0.100s (10.000 fps)
                Size: Discrete 864x480
                        Interval: Discrete 0.100s (10.000 fps)
                Size: Discrete 848x480
                        Interval: Discrete 0.100s (10.000 fps)
                Size: Discrete 800x448
                        Interval: Discrete 0.100s (10.000 fps)
                Size: Discrete 640x360
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 352x288
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 320x240
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 1920x1080
                        Interval: Discrete 0.200s (5.000 fps)
```


## Service Configuration

Created from template in `/root/mjpg-streamer-setup/templates`:

```
root@mjpg-streamer:~# cat /etc/systemd/system/mjpg-streamer.service
[Unit]
Description=mjpg_streamer for picam
After=network.target

[Service]
Type=simple
User=root
RemainAfterExit=yes
ExecStart=/root/mjpg-streamer-setup/bin/startAllCams

[Install]
WantedBy=multi-user.target
root@mjpg-streamer:~#
```

```
root@mjpg-streamer:~# systemctl enable mjpg-streamer
Created symlink /etc/systemd/system/multi-user.target.wants/mjpg-streamer.service -> /etc/systemd/system/mjpg-streamer.service.
root@mjpg-streamer:~# systemctl status mjpg-streamer
* mjpg-streamer.service - mjpg_streamer for picam
     Loaded: loaded (/etc/systemd/system/mjpg-streamer.service; enabled; vendor preset: enabled)
     Active: inactive (dead)

root@mjpg-streamer:~# systemctl start mjpg-streamer

root@mjpg-streamer:~# systemctl status mjpg-streamer
* mjpg-streamer.service - mjpg_streamer for picam
     Loaded: loaded (/etc/systemd/system/mjpg-streamer.service; enabled; vendor preset: enabled)
     Active: active (exited) since Sun 2023-02-05 23:17:03 UTC; 6s ago
    Process: 1150 ExecStart=/root/mjpg-streamer-setup/bin/startAllCams (code=exited, status=0/SUCCESS)
   Main PID: 1150 (code=exited, status=0/SUCCESS)
      Tasks: 0 (limit: 38329)
     Memory: 12.0K
        CPU: 13ms
     CGroup: /system.slice/mjpg-streamer.service

Feb 05 23:17:03 mjpg-streamer startAllCams[1154]: /root/mjpg-streamer-setup/bin/startAllCams: line 8: vcgencmd: command not found
Feb 05 23:17:04 mjpg-streamer startAllCams[1156]: Webcam does not support MJPG - using slower YUYV instead!
Feb 05 23:17:04 mjpg-streamer startAllCams[1156]: Best resolution: 0 x 0 at 0
Feb 05 23:17:04 mjpg-streamer startAllCams[1156]: /usr/local/bin/mjpg_streamer -i "/usr/local/lib/mjpg-streamer/input_uvc.so -d /dev/video0 --fps 0 -r 0x0 -y " ->
Feb 05 23:17:04 mjpg-streamer mjpg_streamer[1163]: MJPG-streamer [1163]: starting application
Feb 05 23:17:04 mjpg-streamer mjpg_streamer[1163]: MJPG-streamer [1163]: enabling daemon mode
Feb 05 23:17:04 mjpg-streamer startAllCams[1163]: enabling daemon mode
Feb 05 23:17:04 mjpg-streamer startAllCams[1164]: forked to background (1165)
Feb 05 23:17:04 mjpg-streamer mjpg_streamer[1165]: MJPG-streamer [1165]: MJPG Streamer Version: git rev: 310b29f4a94c46652b20c4b7b6e5cf24e532af39
Feb 05 23:17:04 mjpg-streamer mjpg_streamer[1165]: MJPG-streamer [1165]: input_init() return value signals to exit
```

## Fixing mjpg-streamer

### Fix `startAllCams`

Remove reference to `vcgencmd`

### Fix `mjpgStart`

Test for MJPG support is broken:
```
MJPG_TEST=$(echo "$VIDEO_TEST" | /bin/grep "'MJPG'")
```

Calculation for best resolution and framerate is broken:
```
BEST_WIDTH=$WEBCAM_WIDTH
BEST_HEIGHT=$WEBCAM_HEIGHT
BEST_FRAMERATE=$WEBCAM_FRAMERATE
```

### Final test:

```
root@mjpg-streamer:~/mjpg-streamer-setup/bin# ./startAllCams
Best resolution: 640 x 480 at 30
/usr/local/bin/mjpg_streamer -i "/usr/local/lib/mjpg-streamer/input_uvc.so -d /dev/video0 --fps 30 -r 640x480 " -o "/usr/local/lib/mjpg-streamer/output_http.so -p 5050 -w /usr/local/share/mjpg-streamer/www" -b
enabling daemon modeforked to background (1329)
```
