# EMEET SmartCam S800

I was seduced by the promise of "1/2" Large Sony Sensor".

* [specs](https://emeet.com/products/webcam-s800)
* [faq](https://emeet.com/pages/s800-faq)


Identify the device:
```
alex@duo > v4l2-ctl --list-devices
IPEVO Ziggi-HD Plus (usb-0000:00:14.0-10):
	/dev/video0
	/dev/video1
	/dev/media0

ILCE-7M4 (usb-0000:00:14.0-3):
	/dev/video2
	/dev/video3
	/dev/media1

EMEET SmartCam S800: EMEET Smar (usb-0000:00:14.0-5):
	/dev/video4
	/dev/video5
	/dev/media2
```

v4l device capabilities:
```
alex@duo > v4l2-ctl --all --device /dev/video4
Driver Info:
	Driver name      : uvcvideo
	Card type        : EMEET SmartCam S800: EMEET Smar
	Bus info         : usb-0000:00:14.0-5
	Driver version   : 6.8.12
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
	Model            : EMEET SmartCam S800: EMEET Smar
	Serial           : 454D4545542020204D3343393430091B0000001
	Bus info         : usb-0000:00:14.0-5
	Media version    : 6.8.12
	Hardware revision: 0x00000209 (521)
	Driver version   : 6.8.12
Interface Info:
	ID               : 0x03000002
	Type             : V4L Video
Entity Info:
	ID               : 0x00000001 (1)
	Name             : EMEET SmartCam S800: EMEET Smar
	Function         : V4L2 I/O
	Flags            : default
	Pad 0x01000007   : 0: Sink
	  Link 0x0200000d: from remote pad 0x100000a of entity 'Processing 2' (Video Pixel Formatter): Data, Enabled, Immutable
Priority: 2
Video input : 0 (Camera 1: ok)
Format Video Capture:
	Width/Height      : 3840/2160
	Pixel Format      : 'MJPG' (Motion-JPEG)
	Field             : None
	Bytes per Line    : 0
	Size Image        : 12441600
	Colorspace        : sRGB
	Transfer Function : Default (maps to sRGB)
	YCbCr/HSV Encoding: Default (maps to ITU-R 601)
	Quantization      : Default (maps to Full Range)
	Flags             :
Crop Capability Video Capture:
	Bounds      : Left 0, Top 0, Width 3840, Height 2160
	Default     : Left 0, Top 0, Width 3840, Height 2160
	Pixel Aspect: 1/1
Selection Video Capture: crop_default, Left 0, Top 0, Width 3840, Height 2160, Flags:
Selection Video Capture: crop_bounds, Left 0, Top 0, Width 3840, Height 2160, Flags:
Streaming Parameters Video Capture:
	Capabilities     : timeperframe
	Frames per second: 30.000 (30/1)
	Read buffers     : 0

User Controls

                     brightness 0x00980900 (int)    : min=0 max=255 step=1 default=128 value=128
                       contrast 0x00980901 (int)    : min=0 max=255 step=1 default=128 value=126
                     saturation 0x00980902 (int)    : min=0 max=255 step=1 default=128 value=128
                            hue 0x00980903 (int)    : min=0 max=255 step=1 default=128 value=128
        white_balance_automatic 0x0098090c (bool)   : default=1 value=1
           power_line_frequency 0x00980918 (menu)   : min=0 max=2 default=2 value=2 (60 Hz)
				0: Disabled
				1: 50 Hz
				2: 60 Hz
      white_balance_temperature 0x0098091a (int)    : min=2300 max=7500 step=1 default=6500 value=6500 flags=inactive
                      sharpness 0x0098091b (int)    : min=0 max=255 step=1 default=128 value=128

Camera Controls

                  auto_exposure 0x009a0901 (menu)   : min=0 max=3 default=0 value=0
				1: Manual Mode
				2: Shutter Priority Mode
         exposure_time_absolute 0x009a0902 (int)    : min=2 max=40000 step=1 default=312 value=312 flags=inactive
                 focus_absolute 0x009a090a (int)    : min=298 max=719 step=1 default=508 value=650 flags=inactive
     focus_automatic_continuous 0x009a090c (bool)   : default=1 value=1
                  zoom_absolute 0x009a090d (int)    : min=100 max=400 step=1 default=100 value=125

alex@duo > v4l2-ctl --all --device /dev/video5
Driver Info:
	Driver name      : uvcvideo
	Card type        : EMEET SmartCam S800: EMEET Smar
	Bus info         : usb-0000:00:14.0-5
	Driver version   : 6.8.12
	Capabilities     : 0x84a00001
		Video Capture
		Metadata Capture
		Streaming
		Extended Pix Format
		Device Capabilities
	Device Caps      : 0x04a00000
		Metadata Capture
		Streaming
		Extended Pix Format
Media Driver Info:
	Driver name      : uvcvideo
	Model            : EMEET SmartCam S800: EMEET Smar
	Serial           : 454D4545542020204D3343393430091B0000001
	Bus info         : usb-0000:00:14.0-5
	Media version    : 6.8.12
	Hardware revision: 0x00000209 (521)
	Driver version   : 6.8.12
Interface Info:
	ID               : 0x03000005
	Type             : V4L Video
Entity Info:
	ID               : 0x00000004 (4)
	Name             : EMEET SmartCam S800: EMEET Smar
	Function         : V4L2 I/O
Priority: 2
Format Metadata Capture:
	Sample Format   : 'UVCH' (UVC Payload Header Metadata)
	Buffer Size     : 10240
```

Supported video formats:
```
alex@duo > v4l2-ctl --list-formats-ext --device /dev/video4
ioctl: VIDIOC_ENUM_FMT
	Type: Video Capture

	[0]: 'MJPG' (Motion-JPEG, compressed)
		Size: Discrete 3840x2160
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
		Size: Discrete 2560x1440
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
		Size: Discrete 1920x1080
			Interval: Discrete 0.017s (60.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
		Size: Discrete 1280x960
			Interval: Discrete 0.017s (60.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
		Size: Discrete 1280x720
			Interval: Discrete 0.017s (60.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
		Size: Discrete 1024x576
			Interval: Discrete 0.017s (60.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
		Size: Discrete 640x480
			Interval: Discrete 0.017s (60.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
		Size: Discrete 640x360
			Interval: Discrete 0.017s (60.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
	[1]: 'YUYV' (YUYV 4:2:2)
		Size: Discrete 1920x1080
			Interval: Discrete 0.017s (60.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
		Size: Discrete 1280x960
			Interval: Discrete 0.017s (60.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
		Size: Discrete 1280x720
			Interval: Discrete 0.017s (60.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
		Size: Discrete 1024x576
			Interval: Discrete 0.017s (60.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
		Size: Discrete 640x480
			Interval: Discrete 0.017s (60.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
		Size: Discrete 640x360
			Interval: Discrete 0.017s (60.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
	[2]: 'H264' (H.264, compressed)
		Size: Discrete 3840x2160
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
		Size: Discrete 2560x1440
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
		Size: Discrete 1920x1080
			Interval: Discrete 0.017s (60.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
		Size: Discrete 1280x960
			Interval: Discrete 0.017s (60.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
		Size: Discrete 1280x720
			Interval: Discrete 0.017s (60.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
		Size: Discrete 1024x576
			Interval: Discrete 0.017s (60.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
		Size: Discrete 640x480
			Interval: Discrete 0.017s (60.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)
		Size: Discrete 640x360
			Interval: Discrete 0.017s (60.000 fps)
			Interval: Discrete 0.033s (30.000 fps)
			Interval: Discrete 0.042s (24.000 fps)

alex@duo > v4l2-ctl --list-formats-ext --device /dev/video5
ioctl: VIDIOC_ENUM_FMT
	Type: Video Capture
```
## Live View

Using H264 codec:
```sh
vlc --meta-title='Portrait Camera' \
    --meta-description='Portrait Camera Live Feed' \
    'v4l2:///dev/video4:width=1920:height=1080:fps=30:chroma=H264'
```

vlc --meta-title='Portrait Camera' \
    --meta-description='Portrait Camera Live Feed' \
    'v4l2:///dev/video4:width=3840:height=2160:fps=30:chroma=H264'
