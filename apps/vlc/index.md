# Video Lan Client (VLC) Use

* [vlc cli](https://wiki.videolan.org/VLC_command-line_help/)
* [vlc video capture](video-capture.html)

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



## RTSP Support

vlc in some distros is packed without RTSP support due to a [license](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=982299) [issue](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=981439).

Use snap instead:

```sh
sudo apt purge -y vlc
snap install vlc
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

From [here](https://stackoverflow.com/questions/59180160/mosaic-of-rtsp-streams-vlc-3-0-8):

Create [mosaic_vlc3.vlm](mosaic_vlc3.vlm) and then:

```
vlc.exe --vlm-conf mosaic_vlc3.vlm
```
