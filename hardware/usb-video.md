# Troubleshoot USB Webcam in Linux

Sources:

* https://wiki.archlinux.org/title/Webcam_setup
* [assign-webcam-to-a-specific-dev-video](https://askubuntu.com/questions/715333/assign-webcam-to-a-specific-dev-video)

Relevant:

* [udevadm man page](https://www.man7.org/linux/man-pages/man8/udevadm.8.html)
* [writing_udev_rules](http://www.reactivated.net/writing_udev_rules.html)

Prerequisites:

```sh
apt-get install v4l-utils psmisc
```


## Verify USB Connectivity

```
root@duo:~# lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 004: ID 0471:0815 Philips (or NXP) eHome Infrared Receiver
Bus 001 Device 009: ID 1bcf:28c4 Sunplus Innovation Technology Inc. FHD Camera Microphone
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

This gives:

* bus: 001
* device: 009
* vendor: 1bcf
* product: 28c4

sudo echo "uvcvideo" | sudo tee /etc/modules-load.d/uvc.conf

## Verify the device

```
root@duo:~# udevadm info --attribute-walk /dev/bus/usb/001/009

Udevadm info starts with the device specified by the devpath and then
walks up the chain of parent devices. It prints for every device
found, all possible attributes in the udev rules key format.
A rule to match, can be composed by the attributes of the device
and the attributes from one single parent device.

  looking at device '/devices/pci0000:00/0000:00:14.0/usb1/1-1':
    KERNEL=="1-1"
    SUBSYSTEM=="usb"
    DRIVER=="usb"
    ATTR{authorized}=="1"
    ATTR{avoid_reset_quirk}=="0"
    ATTR{bConfigurationValue}=="1"
    ATTR{bDeviceClass}=="ef"
    ATTR{bDeviceProtocol}=="01"
    ATTR{bDeviceSubClass}=="02"
    ATTR{bMaxPacketSize0}=="64"
    ATTR{bMaxPower}=="500mA"
    ATTR{bNumConfigurations}=="1"
    ATTR{bNumInterfaces}==" 4"
    ATTR{bcdDevice}=="0530"
    ATTR{bmAttributes}=="80"
    ATTR{busnum}=="1"
    ATTR{configuration}==""
    ATTR{devnum}=="9"
    ATTR{devpath}=="1"
    ATTR{idProduct}=="28c4"
    ATTR{idVendor}=="1bcf"
    ATTR{ltm_capable}=="no"
    ATTR{manufacturer}=="SunplusIT Inc"
    ATTR{maxchild}=="0"
    ATTR{power/active_duration}=="63846332"
    ATTR{power/async}=="enabled"
    ATTR{power/autosuspend}=="2"
    ATTR{power/autosuspend_delay_ms}=="2000"
    ATTR{power/connected_duration}=="63846332"
    ATTR{power/control}=="auto"
    ATTR{power/level}=="auto"
    ATTR{power/persist}=="1"
    ATTR{power/runtime_active_kids}=="0"
    ATTR{power/runtime_active_time}=="63846053"
    ATTR{power/runtime_enabled}=="enabled"
    ATTR{power/runtime_status}=="active"
    ATTR{power/runtime_suspended_time}=="0"
    ATTR{power/runtime_usage}=="1"
    ATTR{product}=="FHD Camera Microphone"
    ATTR{quirks}=="0x0"
    ATTR{removable}=="removable"
    ATTR{rx_lanes}=="1"
    ATTR{serial}=="01.00.00"
    ATTR{speed}=="480"
    ATTR{tx_lanes}=="1"
    ATTR{urbnum}=="364"
    ATTR{version}==" 2.00"

  looking at parent device '/devices/pci0000:00/0000:00:14.0/usb1':
    KERNELS=="usb1"
    SUBSYSTEMS=="usb"
    DRIVERS=="usb"
    ATTRS{authorized}=="1"
    ATTRS{authorized_default}=="1"
    ATTRS{avoid_reset_quirk}=="0"
    ATTRS{bConfigurationValue}=="1"
    ATTRS{bDeviceClass}=="09"
    ATTRS{bDeviceProtocol}=="01"
    ATTRS{bDeviceSubClass}=="00"
    ATTRS{bMaxPacketSize0}=="64"
    ATTRS{bMaxPower}=="0mA"
    ATTRS{bNumConfigurations}=="1"
    ATTRS{bNumInterfaces}==" 1"
    ATTRS{bcdDevice}=="0515"
    ATTRS{bmAttributes}=="e0"
    ATTRS{busnum}=="1"
    ATTRS{configuration}==""
    ATTRS{devnum}=="1"
    ATTRS{devpath}=="0"
    ATTRS{idProduct}=="0002"
    ATTRS{idVendor}=="1d6b"
    ATTRS{interface_authorized_default}=="1"
    ATTRS{ltm_capable}=="no"
    ATTRS{manufacturer}=="Linux 5.15.83-1-pve xhci-hcd"
    ATTRS{maxchild}=="16"
    ATTRS{power/active_duration}=="68110804"
    ATTRS{power/async}=="enabled"
    ATTRS{power/autosuspend}=="0"
    ATTRS{power/autosuspend_delay_ms}=="0"
    ATTRS{power/connected_duration}=="68110804"
    ATTRS{power/control}=="auto"
    ATTRS{power/level}=="auto"
    ATTRS{power/runtime_active_kids}=="2"
    ATTRS{power/runtime_active_time}=="68110803"
    ATTRS{power/runtime_enabled}=="enabled"
    ATTRS{power/runtime_status}=="active"
    ATTRS{power/runtime_suspended_time}=="0"
    ATTRS{power/runtime_usage}=="0"
    ATTRS{power/wakeup}=="disabled"
    ATTRS{power/wakeup_abort_count}==""
    ATTRS{power/wakeup_active}==""
    ATTRS{power/wakeup_active_count}==""
    ATTRS{power/wakeup_count}==""
    ATTRS{power/wakeup_expire_count}==""
    ATTRS{power/wakeup_last_time_ms}==""
    ATTRS{power/wakeup_max_time_ms}==""
    ATTRS{power/wakeup_total_time_ms}==""
    ATTRS{product}=="xHCI Host Controller"
    ATTRS{quirks}=="0x0"
    ATTRS{removable}=="unknown"
    ATTRS{rx_lanes}=="1"
    ATTRS{serial}=="0000:00:14.0"
    ATTRS{speed}=="480"
    ATTRS{tx_lanes}=="1"
    ATTRS{urbnum}=="304"
    ATTRS{version}==" 2.00"

  looking at parent device '/devices/pci0000:00/0000:00:14.0':
    KERNELS=="0000:00:14.0"
    SUBSYSTEMS=="pci"
    DRIVERS=="xhci_hcd"
    ATTRS{ari_enabled}=="0"
    ATTRS{broken_parity_status}=="0"
    ATTRS{class}=="0x0c0330"
    ATTRS{consistent_dma_mask_bits}=="64"
    ATTRS{d3cold_allowed}=="1"
    ATTRS{dbc}=="disabled"
    ATTRS{device}=="0xa2af"
    ATTRS{dma_mask_bits}=="64"
    ATTRS{driver_override}=="(null)"
    ATTRS{enable}=="1"
    ATTRS{index}=="2"
    ATTRS{irq}=="132"
    ATTRS{label}=="Onboard - Other"
    ATTRS{local_cpulist}=="0-5"
    ATTRS{local_cpus}=="3f"
    ATTRS{msi_bus}=="1"
    ATTRS{msi_irqs/132}=="msi"
    ATTRS{numa_node}=="-1"
    ATTRS{power/async}=="enabled"
    ATTRS{power/control}=="on"
    ATTRS{power/runtime_active_kids}=="1"
    ATTRS{power/runtime_active_time}=="68111751"
    ATTRS{power/runtime_enabled}=="forbidden"
    ATTRS{power/runtime_status}=="active"
    ATTRS{power/runtime_suspended_time}=="0"
    ATTRS{power/runtime_usage}=="2"
    ATTRS{power/wakeup}=="enabled"
    ATTRS{power/wakeup_abort_count}=="0"
    ATTRS{power/wakeup_active}=="0"
    ATTRS{power/wakeup_active_count}=="0"
    ATTRS{power/wakeup_count}=="0"
    ATTRS{power/wakeup_expire_count}=="0"
    ATTRS{power/wakeup_last_time_ms}=="0"
    ATTRS{power/wakeup_max_time_ms}=="0"
    ATTRS{power/wakeup_total_time_ms}=="0"
    ATTRS{power_state}=="D0"
    ATTRS{revision}=="0x00"
    ATTRS{subsystem_device}=="0xa2af"
    ATTRS{subsystem_vendor}=="0x1849"
    ATTRS{vendor}=="0x8086"

  looking at parent device '/devices/pci0000:00':
    KERNELS=="pci0000:00"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{power/async}=="enabled"
    ATTRS{power/control}=="auto"
    ATTRS{power/runtime_active_kids}=="10"
    ATTRS{power/runtime_active_time}=="0"
    ATTRS{power/runtime_enabled}=="disabled"
    ATTRS{power/runtime_status}=="unsupported"
    ATTRS{power/runtime_suspended_time}=="0"
    ATTRS{power/runtime_usage}=="0"
    ATTRS{waiting_for_supplier}=="0"
```

## Verify v4l devices

```
alex@latitude7490:/etc/udev/rules.d/ > ls -la /dev/v4l/by-id/
total 0
drwxr-xr-x 2 root root 80 Jan 19 10:34 .
drwxr-xr-x 4 root root 80 Jan 19 10:34 ..
lrwxrwxrwx 1 root root 12 Jan 19 10:34 usb-CN0K0KM8LOG007BG018TA00_Integrated_Webcam_HD_200901010001-video-index0 -> ../../video2
lrwxrwxrwx 1 root root 12 Jan 19 10:34 usb-CN0K0KM8LOG007BG018TA00_Integrated_Webcam_HD_200901010001-video-index1 -> ../../video1
alex@latitude7490:/etc/udev/rules.d/ > ls -la /dev/v4l/by-path
total 0
drwxr-xr-x 2 root root 120 Jan 19 10:34 .
drwxr-xr-x 4 root root  80 Jan 19 10:34 ..
lrwxrwxrwx 1 root root  12 Jan 19 10:34 pci-0000:00:14.0-usb-0:5:1.0-video-index0 -> ../../video0
lrwxrwxrwx 1 root root  12 Jan 19 10:34 pci-0000:00:14.0-usb-0:5:1.0-video-index1 -> ../../video1
lrwxrwxrwx 1 root root  12 Jan 19 10:34 pci-0000:00:14.0-usb-0:5:1.2-video-index0 -> ../../video2
lrwxrwxrwx 1 root root  12 Jan 19 10:34 pci-0000:00:14.0-usb-0:5:1.2-video-index1 -> ../../video3
```

## List Native Video Formats

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

## List All Camera Capabilities
```
root@duo:~# v4l2-ctl --all
Driver Info:
	Driver name      : uvcvideo
	Card type        : FHD Camera Microphone: FHD Came
	Bus info         : usb-0000:00:14.0-11
	Driver version   : 5.15.83
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
	Model            : FHD Camera Microphone: FHD Came
	Serial           : 01.00.00
	Bus info         : usb-0000:00:14.0-11
	Media version    : 5.15.83
	Hardware revision: 0x00000530 (1328)
	Driver version   : 5.15.83
Interface Info:
	ID               : 0x03000002
	Type             : V4L Video
Entity Info:
	ID               : 0x00000001 (1)
	Name             : FHD Camera Microphone: FHD Came
	Function         : V4L2 I/O
	Flags         : default
	Pad 0x01000007   : 0: Sink
	  Link 0x02000013: from remote pad 0x100000a of entity 'Extension 4': Data, Enabled, Immutable
Priority: 2
Video input : 0 (Camera 1: ok)
Format Video Capture:
	Width/Height      : 800/600
	Pixel Format      : 'MJPG' (Motion-JPEG)
	Field             : None
	Bytes per Line    : 0
	Size Image        : 960000
	Colorspace        : sRGB
	Transfer Function : Rec. 709
	YCbCr/HSV Encoding: ITU-R 601
	Quantization      : Default (maps to Full Range)
	Flags             :
Crop Capability Video Capture:
	Bounds      : Left 0, Top 0, Width 800, Height 600
	Default     : Left 0, Top 0, Width 800, Height 600
	Pixel Aspect: 1/1
Selection Video Capture: crop_default, Left 0, Top 0, Width 800, Height 600, Flags:
Selection Video Capture: crop_bounds, Left 0, Top 0, Width 800, Height 600, Flags:
Streaming Parameters Video Capture:
	Capabilities     : timeperframe
	Frames per second: 30.000 (30/1)
	Read buffers     : 0
                     brightness 0x00980900 (int)    : min=-64 max=64 step=1 default=0 value=0
                       contrast 0x00980901 (int)    : min=0 max=95 step=1 default=1 value=1
                     saturation 0x00980902 (int)    : min=0 max=100 step=1 default=64 value=64
                            hue 0x00980903 (int)    : min=-2000 max=2000 step=1 default=0 value=0
 white_balance_temperature_auto 0x0098090c (bool)   : default=1 value=1
                          gamma 0x00980910 (int)    : min=100 max=300 step=1 default=100 value=100
           power_line_frequency 0x00980918 (menu)   : min=0 max=2 default=1 value=1
				0: Disabled
				1: 50 Hz
				2: 60 Hz
      white_balance_temperature 0x0098091a (int)    : min=2800 max=6500 step=1 default=4600 value=4600 flags=inactive
                      sharpness 0x0098091b (int)    : min=1 max=7 step=1 default=2 value=2
         backlight_compensation 0x0098091c (int)    : min=0 max=1 step=1 default=1 value=1
                  exposure_auto 0x009a0901 (menu)   : min=0 max=3 default=3 value=3
				1: Manual Mode
				3: Aperture Priority Mode
              exposure_absolute 0x009a0902 (int)    : min=3 max=2047 step=1 default=166 value=166 flags=inactive
                 focus_absolute 0x009a090a (int)    : min=0 max=1023 step=1 default=0 value=292 flags=inactive
                     focus_auto 0x009a090c (bool)   : default=0 value=1
```

## List All the Camera Controls

```
root@duo:~# v4l2-ctl -d /dev/video0 --list-ctrls
                     brightness 0x00980900 (int)    : min=-64 max=64 step=1 default=0 value=0
                       contrast 0x00980901 (int)    : min=0 max=95 step=1 default=1 value=1
                     saturation 0x00980902 (int)    : min=0 max=100 step=1 default=64 value=64
                            hue 0x00980903 (int)    : min=-2000 max=2000 step=1 default=0 value=0
 white_balance_temperature_auto 0x0098090c (bool)   : default=1 value=1
                          gamma 0x00980910 (int)    : min=100 max=300 step=1 default=100 value=100
           power_line_frequency 0x00980918 (menu)   : min=0 max=2 default=1 value=1
      white_balance_temperature 0x0098091a (int)    : min=2800 max=6500 step=1 default=4600 value=4600 flags=inactive
                      sharpness 0x0098091b (int)    : min=1 max=7 step=1 default=2 value=2
         backlight_compensation 0x0098091c (int)    : min=0 max=1 step=1 default=1 value=1
                  exposure_auto 0x009a0901 (menu)   : min=0 max=3 default=3 value=3
              exposure_absolute 0x009a0902 (int)    : min=3 max=2047 step=1 default=166 value=166 flags=inactive
                 focus_absolute 0x009a090a (int)    : min=0 max=1023 step=1 default=0 value=300 flags=inactive
                     focus_auto 0x009a090c (bool)   : default=0 value=1
```
## Adjust the Camera Controls

```
v4l2-ctl \
        --set-ctrl=power_line_frequency=2 \
        --set-ctrl=backlight_compensation=0 \
        --set-ctrl=exposure_auto=1 \
        --set-ctrl=exposure_absolute=166 \
        --set-ctrl=focus_auto=0 \
        --set-ctrl=white_balance_temperature_auto=0 \
        --set-ctrl=focus_absolute=300
```
