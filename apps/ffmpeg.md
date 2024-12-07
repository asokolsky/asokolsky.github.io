# ffmpeg

fast-forward mpeg?  Not really.
ffmpeg [man page](https://manpages.org/ffmpeg),
use [with webcam](https://trac.ffmpeg.org/wiki/Capture/Webcam).

## Prerequisites

Know thyself.

Identify the audio recording devices available
[with](/hardware/usb-audio.html) `pacmd list-sources`.
I picked `alsa_input.usb-046d_HD_Pro_Webcam_C920_CDF1191F-02.analog-stereo`.

Identify the video formats available [using](/hardware/usb-video.html)...
```sh
v4l2-ctl --list-formats-ext -d /dev/video4
```
or
```sh
ffmpeg -f v4l2 -list_formats all -i /dev/video0
```
I picked MJPG 1920x1080.

## Recording

This will:

* capture 10 seconds of video and audio
* video from `/dev/video4`, at 30 fps, in MJPG format, at resolution 1920x1080
* audio from `alsa_card.usb-046d_HD_Pro_Webcam_C920_CDF1191F-02`
* then compress video using `libx264` with `faster`
[preset](http://www.chaneru.com/Roku/HLS/X264_Settings.htm)
* compress audio using codec `ac3_fixed`
* and, finally, save it as `out.mkv`, overwriting it if the one exists:

```sh
ffmpeg -y \
    -f v4l2 -t 10 -framerate 30 -video_size 1920x1080 -input_format mjpeg -i /dev/video4 \
    -f pulse -t 10 -sample_rate 44100 -channels 1 -i alsa_input.usb-046d_HD_Pro_Webcam_C920_CDF1191F-02.analog-stereo \
    -c:v libx264 -preset faster -c:a ac3_fixed \
    -metadata title="From my desk" out.mkv
```
To avoid re-compression:
```sh
ffmpeg -f v4l2 -framerate 30 -video_size 1280x720 -input_format mjpeg \
    -i /dev/video0 -c copy out.mkv
```

Then...

## Take a picture

```sh
ffmpeg -f v4l2 -video_size 1280x720 -i /dev/video0 -frames 1 out.jpg
```

## Streaming

[ffmpeg streaming guide](https://trac.ffmpeg.org/wiki/StreamingGuide)

## More Utilities

Use [ffprobe](https://ffmpeg.org/ffprobe.html) to display stream info:

```sh
ffprobe out.mkv
```

Simple player:
```sh
ffplay /dev/video0
```

## Trimming / Extraction

To cut out 20 seconds starting from 1:50 minutes, use:

```sh
ffmpeg -i input.mkv -ss 00:01:50 -c copy -t 20 output.mkv
```

The `-ss` option can be placed in front of `-i`, resulting in faster copying
but less accuracy. If you experience out-of-sync audio or video, you will have
to have to re-encode:

```sh
ffmpeg -i input.mkv -ss 00:01:50 -c:v libx264 -c:a libfaac -t 20 output.mkv
```

## Hardware Acceleration

* [ffmpeg HWAccelIntro](https://trac.ffmpeg.org/wiki/HWAccelIntro)
* [ffmpeg QuickSync](https://trac.ffmpeg.org/wiki/Hardware/QuickSync)
* [NVidia GPU Support Matrix for NVENC/NVDEC](https://developer.nvidia.com/video-encode-and-decode-gpu-support-matrix-new)
* [Using FFmpeg with NVIDIA GPU Hardware Acceleration](https://docs.nvidia.com/video-technologies/video-codec-sdk/12.2/ffmpeg-with-nvidia-gpu/index.html)
