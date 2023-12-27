# ffmpeg

ffmpeg [man page](https://manpages.org/ffmpeg),
use [with webcam](https://trac.ffmpeg.org/wiki/Capture/Webcam).

## Prerequisites

Know thyself:

* [Use](/hardware/usb-audio.html) `pacmd list-sources` to identify the audio
recording devices available.
I picked `alsa_input.usb-046d_HD_Pro_Webcam_C920_CDF1191F-02.analog-stereo`.
* [Use](/hardware/usb-video.html) `v4l2-ctl --list-formats-ext -d /dev/video4` to
identify video formats available.  I picked MJPG 192x1080.

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

## Streaming

https://trac.ffmpeg.org/wiki/StreamingGuide
