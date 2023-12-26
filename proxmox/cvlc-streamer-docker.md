# cvlc-streamer in a docker container

[mjpg-streamer](mjpg-streamer-docker.md) is great!  Except:

* mjpg is not good enough
* and mjpg-streamer does not do transcoding to H264/H265

VLC:

* [vlc cli](https://wiki.videolan.org/VLC_command-line_help/)
* [v4l2 module cli](https://wiki.videolan.org/Documentation:Modules/v4l2/)
* [streaming howto](https://wiki.videolan.org/Documentation:Streaming_HowTo/)

https://hub.docker.com/r/gersilex/cvlc

https://en.wikipedia.org/wiki/ONVIF

## Identify capture formats supported

Identify the resolution and formats supported by the webcam:
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
Based on the above, one arrives at MJPG, 1280x720.

## Opening a video capture device

To display webcam in default format:
```
cvlc v4l2:///dev/video0
```
You can be more specific:
```
vlc 'v4l2:///dev/video4:width=1920:height=1080:fps=30:chroma=MJPG'
```
and even specify metadata:
'''
vlc --meta-title='Live Feed' \
    --meta-description='Straight from my desk' \
    'v4l2:///dev/video4:width=1920:height=1080:fps=15:chroma=H264:stereo=disabled:samplerate:44100'
'''

## Transcoding

In VLC select start streaming:

* Open Media\Capture device:

MRL: v4l2:///dev/video0
Options: :v4l2-standard=ALL :input-slave=alsa://hw:0,0 :live-caching=300


:sout=#transcode{vcodec=h264,acodec=mpga,ab=128,channels=2,samplerate=44100,scodec=none}:display :no-sout-all :sout-keep