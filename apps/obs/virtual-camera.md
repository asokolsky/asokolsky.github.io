# OBS Virtual Camera

From [Install Instructions](https://github.com/obsproject/obs-studio/wiki/install-instructions#prerequisites-for-all-versions):

For virtual camera support, you need the [v4l2loopback](https://github.com/v4l2loopback/v4l2loopback) kernel [module](/linux/kernel-modules.html) installed. Install it with:

```sh
sudo apt install v4l2loopback-dkms
```

OBS Studio will normally load the module while starting the virtual camera if the module was not already loaded. This requires a working `polkit` setup.

Alternatively, you can also load the module manually:
```sh
sudo modprobe v4l2loopback exclusive_caps=1 card_label='OBS Virtual Camera'
```

You can also use `modprobe.d` conf files to automate this.

Once you see `v4l2loopback` in this output:
```
alex@duo > lsmod|grep v4
v4l2loopback           49152  0
videobuf2_v4l2         36864  1 uvcvideo
videodev              352256  3 videobuf2_v4l2,v4l2loopback,uvcvideo
videobuf2_common       81920  4 videobuf2_vmalloc,videobuf2_v4l2,uvcvideo,videobuf2_memops
mc                     81920  5 videodev,snd_usb_audio,videobuf2_v4l2,uvcvideo,videobuf2_common
```
you can start OBS - you should see `Start Virtual Camera` Button on the right.

You can now see a new v4l device `/dev/video6`:

```sh
alex@duo > v4l2-ctl --list-devices
Dummy video device (0x0000) (platform:v4l2loopback-000):
	/dev/video6

IPEVO Ziggi-HD Plus (usb-0000:00:14.0-10):
	/dev/video4
	/dev/video5
	/dev/media2

ILCE-7M4 (usb-0000:00:14.0-3):
	/dev/video0
	/dev/video1
	/dev/media0

EMEET SmartCam S800: EMEET Smar (usb-0000:00:14.0-5):
	/dev/video2
	/dev/video3
	/dev/media1

alex@duo > v4l2-ctl --list-formats-ext --device /dev/video6
ioctl: VIDIOC_ENUM_FMT
	Type: Video Capture

	[0]: 'YUYV' (YUYV 4:2:2)
		Size: Discrete 1920x1080
			Interval: Discrete 0.033s (30.000 fps)
```

Test it:
```
vlc 'v4l2:///dev/video6:width=1920:height=1080:fps=30:chroma=YUYV'
```

https://github.com/CatxFish/obs-v4l2sink
