# VLC Settings

[vlc cli](https://wiki.videolan.org/VLC_command-line_help/)

## HDR Too Dark

The default tone mapping for HDR "Hable" is too dark, tried "Reinhard":

Preferences -> All -> Video -> Output modules -> OpenGL ->
Tone mapping -> Tone-mapping algorithm = Reinhard (simple non-linear)

Did not really work for me.

## Multi Channel Audio Output

Preferences -> Audio

All effects are off.

### In Windows

Setting|Value
-------|-----
Output module|Windows Multimedia Device output
HDMI/SPDIF audio passthrough|Enabled
Device|Receiver

### In Linux

Setting|Value
-------|-----
Output module|Alsa
Device|Pick the one that works.


### In MacOS

Does not seem to be supported?

## Video Capture

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

To display webcam in the default format:
```sh
vlc v4l2:///dev/video0
```
You can be more specific (see
[v4l2 module cli](https://wiki.videolan.org/Documentation:Modules/v4l2/))
:
```
vlc 'v4l2:///dev/video4:width=1920:height=1080:fps=30:chroma=MJPG'
```
and even specify metadata:

```sh
vlc --meta-title='Live Feed' \
    --meta-description='Straight from my desk' \
    'v4l2:///dev/video4:width=1920:height=1080:fps=15:chroma=H264:stereo=disabled:samplerate:44100'
```

## Video Streaming

[Streaming HowTo](https://wiki.videolan.org/Documentation:Streaming_HowTo/)


### RTP Multicast Live Streaming

Capture, transcode the video and send it to a multicast IP address with the
associated SAP announce:

```sh
cvlc --meta-title='Live Feed' \
    --meta-description='Straight from my desk' \
    --live-caching 300 \
    'v4l2:///dev/video4:width=1280:height=720:fps=15:chroma=H264:stereo=disabled:samplerate:44100' \
    --sout '#transcode{vcodec=h264,vb=6000,acodec=mp4a,aenc=fdkaac,ab=256}:rtp{mux=ts,dst=239.255.12.42,sdp=sap,name=Test}'
```
To view the stream:

```sh
vlc rtp://239.255.12.42
```

### RTSP Live Streaming

```sh
cvlc --meta-title='Live Feed' \
    --meta-description='Straight from my desk' \
    --live-caching 300 \
    'v4l2:///dev/video4:width=1280:height=720:fps=15:chroma=H264:stereo=disabled:samplerate:44100' \
    --sout '#transcode{vcodec=h264,vb=6000,acodec=mp4a,aenc=fdkaac,ab=256}:rtp{dst=127.0.0.1,port=1234,sdp=rtsp://localhost:554/test.sdp}'
```
To view the stream:

```sh
vlc rtsp://localhost:554/test.sdp
```

## Mosaic of RTSP streams

From
[here](https://stackoverflow.com/questions/59180160/mosaic-of-rtsp-streams-vlc-3-0-8):

Create [mosaic_vlc3.vlm](./mosaic_vlc3.vlm) and then:

```
vlc.exe --vlm-conf mosaic_vlc3.vlm
```
