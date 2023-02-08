# mjpg-streamer in a docker container on Portainer

Streaming video from a USB webcam connected to a Proxmox node via
[mjpg-streamer](https://github.com/jacksonliam/mjpg-streamer) in a
[portainer](docker-portainer.html).

## Verify Camera Functionality

Install optional prerequisites:

```sh
apt-get install v4l-utils psmisc
```

Connect the USB webcam, verify it is detected:
```
root@duo:~# lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 003: ID 0471:0815 Philips (or NXP) eHome Infrared Receiver
Bus 001 Device 004: ID 046d:c52b Logitech, Inc. Unifying Receiver
Bus 001 Device 008: ID 1bcf:28c4 Sunplus Innovation Technology Inc. FHD Camera Microphone
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

```
root@duo:~# v4l2-ctl --list-formats-ext
ioctl: VIDIOC_ENUM_FMT
        Type: Video Capture

        [0]: 'MJPG' (Motion-JPEG, compressed)
                Size: Discrete 640x480
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 1600x896
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 1280x720
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 1024x576
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 800x600
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 800x480
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 640x360
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 424x240
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 352x288
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 1920x1080
                        Interval: Discrete 0.033s (30.000 fps)
        [1]: 'YUYV' (YUYV 4:2:2)
                Size: Discrete 640x480
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 1600x896
                        Interval: Discrete 0.133s (7.500 fps)
                Size: Discrete 1280x720
                        Interval: Discrete 0.100s (10.000 fps)
                Size: Discrete 1024x576
                        Interval: Discrete 0.100s (10.000 fps)
                Size: Discrete 800x600
                        Interval: Discrete 0.067s (15.000 fps)
                Size: Discrete 800x480
                        Interval: Discrete 0.040s (25.000 fps)
                Size: Discrete 640x360
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 424x240
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 352x288
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 1920x1080
                        Interval: Discrete 0.200s (5.000 fps)
```

## Pull `mjpg-streamer` docker image

In portainer pulled `badsmoke/mjpg-streamer`

## Running `mjpg-streamer` docker image

Using info from https://hub.docker.com/r/badsmoke/mjpg-streamer:

```sh
docker run --device /dev/video0 \
        -e "ENV_FPS=30" -e "ENV_RESOLUTION=1920x1080" -e "ENV_LOCATION=./www"
        -p 8080:8080 \
        badsmoke/mjpg-streamer
```

## Using it

For static site - point you browser to http://duo:8080/.

To get a snapshot: http://duo:8080/?action=snapshot

To view live feed: http://duo:8080/?action=streaming

The latter is properly displayed in both Firefox and player like `vlc`.
