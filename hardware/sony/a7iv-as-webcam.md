# Sony α7IV, a.k.a. ILCE-7M4, as a webcam

See also [Troubleshoot USB Webcam in Linux](../usb-video.html).

## Identify the device

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

## Camera Capabilities
```
alex@duo > v4l2-ctl --all --device /dev/video2
Driver Info:
	Driver name      : uvcvideo
	Card type        : ILCE-7M4
	Bus info         : usb-0000:00:14.0-3
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
	Model            : ILCE-7M4
	Serial           : D06CE05D9BE5
	Bus info         : usb-0000:00:14.0-3
	Media version    : 6.8.12
	Hardware revision: 0x00000100 (256)
	Driver version   : 6.8.12
Interface Info:
	ID               : 0x03000002
	Type             : V4L Video
Entity Info:
	ID               : 0x00000001 (1)
	Name             : ILCE-7M4
	Function         : V4L2 I/O
	Flags            : default
	Pad 0x01000007   : 0: Sink
	  Link 0x0200000d: from remote pad 0x100000a of entity 'Processing 2' (Video Pixel Formatter): Data, Enabled, Immutable
Priority: 2
Video input : 0 (Camera 1: ok)
Format Video Capture:
	Width/Height      : 1920/1080
	Pixel Format      : 'NV12' (Y/UV 4:2:0)
	Field             : None
	Bytes per Line    : 1920
	Size Image        : 3110400
	Colorspace        : sRGB
	Transfer Function : Rec. 709
	YCbCr/HSV Encoding: Rec. 709
	Quantization      : Default (maps to Limited Range)
	Flags             :
Crop Capability Video Capture:
	Bounds      : Left 0, Top 0, Width 1920, Height 1080
	Default     : Left 0, Top 0, Width 1920, Height 1080
	Pixel Aspect: 1/1
Selection Video Capture: crop_default, Left 0, Top 0, Width 1920, Height 1080, Flags:
Selection Video Capture: crop_bounds, Left 0, Top 0, Width 1920, Height 1080, Flags:
Streaming Parameters Video Capture:
	Capabilities     : timeperframe
	Frames per second: 30.000 (30/1)
	Read buffers     : 0

User Controls

alex@duo > v4l2-ctl --all --device /dev/video3
Driver Info:
	Driver name      : uvcvideo
	Card type        : ILCE-7M4
	Bus info         : usb-0000:00:14.0-3
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
	Model            : ILCE-7M4
	Serial           : D06CE05D9BE5
	Bus info         : usb-0000:00:14.0-3
	Media version    : 6.8.12
	Hardware revision: 0x00000100 (256)
	Driver version   : 6.8.12
Interface Info:
	ID               : 0x03000005
	Type             : V4L Video
Entity Info:
	ID               : 0x00000004 (4)
	Name             : ILCE-7M4
	Function         : V4L2 I/O
Priority: 2
Format Metadata Capture:
	Sample Format   : 'UVCH' (UVC Payload Header Metadata)
	Buffer Size     : 10240
```

Identify the supported formats:
```
alex@duo > v4l2-ctl --list-formats-ext --device /dev/video2
ioctl: VIDIOC_ENUM_FMT
	Type: Video Capture

	[0]: 'NV12' (Y/UV 4:2:0)
		Size: Discrete 1920x1080
			Interval: Discrete 0.033s (30.000 fps)
	[1]: 'MJPG' (Motion-JPEG, compressed)
		Size: Discrete 1920x1080
			Interval: Discrete 0.033s (30.000 fps)

alex@duo > v4l2-ctl --list-formats-ext --device /dev/video3
ioctl: VIDIOC_ENUM_FMT
	Type: Video Capture
```

## Live View

Using NV12 (the most commonly used [8-bit 4:2:0 format](https://en.wikipedia.org/wiki/YCbCr#4:2:0)) codec ([recommended](https://learn.microsoft.com/en-us/windows/win32/medfound/recommended-8-bit-yuv-formats-for-video-rendering#nv12)):
```sh
vlc --meta-title='Portrait Camera' \
    --meta-description='Portrait Camera Live Feed' \
    'v4l2:///dev/video2:width=1920:height=1080:fps=30:chroma=NV12'
```

Using MJPG codec:
```sh
vlc --meta-title='Portrait Camera' \
    --meta-description='Portrait Camera Live Feed' \
    'v4l2:///dev/video2:width=1920:height=1080:fps=30:chroma=MJPG'
```
