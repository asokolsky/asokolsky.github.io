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

This proved to be a dead-end, decided to go with
[ffmpeg+mediamtx](../apps/webcam2rtsp.md) solution.

## Identify capture formats supported

Identify the resolution and formats supported by the webcam:
```sh
v4l2-ctl -d /dev/video4 --list-formats-ext
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

```
vlc --meta-title='Live Feed' \
    --meta-description='Straight from my desk' \
    'v4l2:///dev/video4:width=1920:height=1080:fps=15:chroma=H264:stereo=disabled:samplerate:44100'
```
