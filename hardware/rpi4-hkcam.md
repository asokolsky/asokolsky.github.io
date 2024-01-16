# rpi4 use for hkcam

My use of rpi4 to run [hkcam](https://github.com/brutella/hkcam).
This project was retired a while ago.

## OS

Raspberry Pi OS (64-bit)

## Locale

Change locale to `en_US.UTF-8`


## Packages

```
sudo apt install git emacs-nox zsh fswebcam
```

## vcgencmd

https://www.raspberrypi.com/documentation/computers/os.html#vcgencmd

```
pi@hkcam:~ $ sudo vcgencmd commands
commands="commands,... vctest_get"
pi@hkcam:~ $ sudo vcgencmd measure_volts
volt=0.8750V
pi@hkcam:~ $ sudo vcgencmd measure_temp
temp=41.3'C
pi@hkcam:~ $ sudo vcgencmd get_camera
supported=0 detected=0, libcamera interfaces=0
pi@hkcam:~ $
```
## v4l2loopback

Install [v4l2loopback](https://github.com/umlaeute/v4l2loopback):

```
sudo apt install v4l2loopback-dkms
```

Enable v4l2loopback module at boot by creating
`/etc/modules-load.d/v4l2loopback.conf` with the content:
```
v4l2loopback
```

Specify which loopback file should be created by the module
(in our case /dev/video99) by creating `/etc/modprobe.d/v4l2loopback.conf`
with the content:
```
options v4l2loopback video_nr=99
```

Finally:
```
sudo update-initramfs -u
sudo reboot
```

## Camera Setup

After the camera is connected to USB:

```
pi@hkcam ~ % lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 004: ID 0c45:636b Microdia USB  Live camera
Bus 001 Device 003: ID 046d:c52b Logitech, Inc. Unifying Receiver
Bus 001 Device 002: ID 2109:3431 VIA Labs, Inc. Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

pi@hkcam ~ % v4l2-ctl --all
Driver Info:
	Driver name      : uvcvideo
	Card type        : USB  Live camera: USB  Live cam
	Bus info         : usb-0000:01:00.0-1.4
	Driver version   : 5.15.61
	Capabilities     : 0x84a00001
		Video Capture
		Metadata Capture
		Streaming
		Extended Pix Format
		Device Capabilities
	Device Caps      : 0x04200001
		Video Capture
		Streaming
		Extended Pix Format
Media Driver Info:
	Driver name      : uvcvideo
	Model            : USB  Live camera: USB  Live cam
	Serial           : SN0001
	Bus info         : usb-0000:01:00.0-1.4
	Media version    : 5.15.61
	Hardware revision: 0x00000100 (256)
	Driver version   : 5.15.61
Interface Info:
	ID               : 0x03000002
	Type             : V4L Video
Entity Info:
	ID               : 0x00000001 (1)
	Name             : USB  Live camera: USB  Live cam
	Function         : V4L2 I/O
	Flags         : default
	Pad 0x01000007   : 0: Sink
	  Link 0x02000010: from remote pad 0x100000a of entity 'Extension 3': Data, Enabled, Immutable
Priority: 2
Video input : 0 (Camera 1: ok)
Format Video Capture:
	Width/Height      : 640/480
	Pixel Format      : 'MJPG' (Motion-JPEG)
	Field             : None
	Bytes per Line    : 0
	Size Image        : 614989
	Colorspace        : Default
	Transfer Function : Default (maps to Rec. 709)
	YCbCr/HSV Encoding: Default (maps to ITU-R 601)
	Quantization      : Default (maps to Full Range)
	Flags             :
Crop Capability Video Capture:
	Bounds      : Left 0, Top 0, Width 640, Height 480
	Default     : Left 0, Top 0, Width 640, Height 480
	Pixel Aspect: 1/1
Selection Video Capture: crop_default, Left 0, Top 0, Width 640, Height 480, Flags:
Selection Video Capture: crop_bounds, Left 0, Top 0, Width 640, Height 480, Flags:
Streaming Parameters Video Capture:
	Capabilities     : timeperframe
	Frames per second: 25.000 (25/1)
	Read buffers     : 0
                     brightness 0x00980900 (int)    : min=-64 max=64 step=1 default=0 value=0
                       contrast 0x00980901 (int)    : min=0 max=64 step=1 default=32 value=32
                     saturation 0x00980902 (int)    : min=0 max=128 step=1 default=76 value=76
                            hue 0x00980903 (int)    : min=-40 max=40 step=1 default=0 value=0
 white_balance_temperature_auto 0x0098090c (bool)   : default=1 value=1
                          gamma 0x00980910 (int)    : min=72 max=500 step=1 default=100 value=100
                           gain 0x00980913 (int)    : min=0 max=100 step=1 default=0 value=0
           power_line_frequency 0x00980918 (menu)   : min=0 max=2 default=2 value=2
				0: Disabled
				1: 50 Hz
				2: 60 Hz
      white_balance_temperature 0x0098091a (int)    : min=2800 max=6500 step=1 default=4600 value=4600 flags=inactive
                      sharpness 0x0098091b (int)    : min=0 max=6 step=1 default=3 value=3
         backlight_compensation 0x0098091c (int)    : min=0 max=160 step=1 default=80 value=80
                  exposure_auto 0x009a0901 (menu)   : min=0 max=3 default=3 value=3
				1: Manual Mode
				3: Aperture Priority Mode
              exposure_absolute 0x009a0902 (int)    : min=1 max=5000 step=1 default=157 value=157 flags=inactive
         exposure_auto_priority 0x009a0903 (bool)   : default=0 value=1
                 focus_absolute 0x009a090a (int)    : min=1 max=1023 step=1 default=240 value=220 flags=inactive
                     focus_auto 0x009a090c (bool)   : default=1 value=1
                  zoom_absolute 0x009a090d (int)    : min=0 max=5 step=1 default=0 value=0
                  iris_absolute 0x009a0911 (int)    : min=0 max=0 step=0 default=0 value=0
```
