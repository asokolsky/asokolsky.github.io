# Open Broadcaster

* [Open Broadcaster Software](https://obsproject.com/), now in version 30.2.3.
* [Plugins](plugins.html)
* [Organizing Scenes](scenes.html)
* [obs-cmd](obs-cmd.html)

## Audio Chain

### Recoder Settings

Unfortunately, my only choice is:

* 44 kHz sampling rate
* 16 bit/sample

### OBS Audio Filters

According to
[the-best-audio-filters-for-obs](https://streamgeeks.us/the-best-audio-filters-for-obs/),
order of the filters to use:

* Noise Suppression - I use `good quality, more CPU usage` option;
* Noise Gate - disabled it;
* 3-band Equalizer - High: 0dB, Mid: 0dB, Low: +3dB;
* Compressor - Ratio: 5:1, Threshold: -12.2dB, Atack: 2ms, Release: 70ms, Output gain: 0dB

### Codec

libfdk-AAC
[is better](https://superuser.com/questions/1610747/is-fdk-aac-still-better-than-ffmpegs-native-aac-encoder)
than FFmpeg AAC.

## Video Chain

### Camera Settings

Sony a7iv....

* in the USB streaming mode does not support Pictire Profiles, so my
choice of
[PP11/S-Cinetone](https://helpguide.sony.net/di/pp/v1/en/contents/TP0000909106.html)
had no effect.
* [Creative Mode](https://www.sony.com/electronics/support/articles/00273574) - I use Standard.

More: [What is S-Cinetone, and How Do You Use It?](https://alphauniverse.sony-asia.com/learn/tips/what-s-cinetone-and-how-do-you-use-it)

### OBS Video Filters

For [webcam](https://www.youtube.com/watch?v=DZnkyq4kqkE):

* disable low light enhancement - removes ghosting effects

For Sony a7iv I use:

*  color correction filter - Saturation: -0.20


### Codec

Guides:

* [Recording in OBS](https://www.xaymar.com/guides/obs/high-quality-recording/)
* Streaming in OBS with
[Intel QSV](https://www.xaymar.com/guides/obs/high-quality-streaming/qsv/)
[NVENC](https://www.xaymar.com/guides/obs/high-quality-streaming/nvenc/)
* [NVIDIA NvEnc](https://obsproject.com/forum/resources/nvidia-nvenc-guide.740/)


The order of preference is
[unclear](https://obsproject.com/forum/threads/comparison-of-x264-nvenc-quicksync-vce.57358/)
and is determined by the PC capabilities:

* NVENC, preset=P6:Slower (Better Quality)
* QuickSync
* x264
* FFmpeg [VAAPI](https://en.wikipedia.org/wiki/Video_Acceleration_API)

#### NVENC

My steamer GPU, GeForce GT 1030, does NOT support NVENC.

#### QuickSync

For my streamer/recorder PC with UHD Graphics 730, QuickSync uses GPU for H.264
encoding and CPU for HEVC, hence recommended is QuickSync H.264:

GPU|UHD Graphics 730, 750, 770
---|--------------------------
Rate Control|CBR
Target Usage|TU1 or TU2
Profile|high
Latency|normal
B Frames|3

#### x264

Option|Lossless|Near Lossless|Indistinguishable|High Quality|Acceptable Quality
------|--------|-------------|-----------------|------------|------------------
Rate Control|CRF
CRF|0|0...4|5...10|11...16|17...22
Keyframe Interval|1
x264 Options|bframes=0 keyint=1 min-keyint=1
OBS Color Format|4:4:4|4:4:4 or 4:2:2|4:4:4, 4:2:2 or 4:2:0

Common:

Option|Value
------|-----
Preset|ultrafast - placebo, a slower preset only affects file size, quality should be unaffected.
Profile|High, required for 4:4:4 and 4:2:2 encoding
Tune|None, tuning can slightly improve compression efficiency, but often harms it instead.


## Screen Capture

* [Challenges in wayland](https://obsproject.com/forum/threads/no-screen-capture-option-wayland.178447/)

## Notes:

* OBS crashes when I power down my Sony a7iv when the latter is connected to PC
using USB cable.
