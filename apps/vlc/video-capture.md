# Video Capture in VLC


[v4l2 module cli](https://wiki.videolan.org/Documentation:Modules/v4l2/).

## Webcam Settings

[Identify the resolution and formats](hardware/usb-video.html) supported by the webcam:
```
> v4l2-ctl --list-formats-ext
ioctl: VIDIOC_ENUM_FMT
        Type: Video Capture

        [0]: 'MJPG' (Motion-JPEG, compressed)
                Size: Discrete 640x480
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 848x480
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 960x540
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 1280x720
                        Interval: Discrete 0.033s (30.000 fps)
        [1]: 'YUYV' (YUYV 4:2:2)
                Size: Discrete 640x480
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 640x360
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 424x240
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 320x240
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 320x180
                        Interval: Discrete 0.033s (30.000 fps)
                Size: Discrete 160x120
                        Interval: Discrete 0.033s (30.000 fps)
```
Based on the above, one arrives at MJPG, 1280x720, as the best format for video capture.


## Display Webcam

To display webcam in the default format:
```sh
vlc v4l2:///dev/video0
```

To specify the video capture [format](https://wiki.videolan.org/Documentation:Modules/v4l2/) and metadata on the command line:
```sh
vlc --meta-title='Live Feed' \
    --meta-description='Straight from my desk' \
    'v4l2:///dev/video4:width=1920:height=1080:fps=15:chroma=H264:stereo=disabled:samplerate:44100'
```
