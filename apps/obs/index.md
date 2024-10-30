# Open Broadcaster

* [Open Broadcaster Software](https://obsproject.com/), now in version 30.2.3.
* [Plugins](plugins.html)
* [Organizing Scenes](scenes.html)


## Audio Chain

### Recoder Settings

Unfortunately, my only choice is:

* 44 kHz sampling rate
* 16 bit/sample

## OBS Audio Filters

According to
[the-best-audio-filters-for-obs](https://streamgeeks.us/the-best-audio-filters-for-obs/),
order of the filters to use:

* Noise Suppression - I use `good quality, more CPU usage` option;
* Noise Gate - disabled it;
* 3-band Equalizer - High: 0dB, Mid: 0dB, Low: +3dB;
* Compressor - Ratio: 5:1, Threshold: -12.2dB, Atack: 2ms, Release: 70ms, Output gain: 0dB

## Video Chain

### Camera Settings

Sony a7iv....

* in the USB streaming mode does not support Pictire Profiles, so my
choice of
[PP11/S-Cinetone](https://helpguide.sony.net/di/pp/v1/en/contents/TP0000909106.html)
had no effect.
* [Creative Mode](https://www.sony.com/electronics/support/articles/00273574) - I use Standard.

More: [What is S-Cinetone, and How Do You Use It?](https://alphauniverse.sony-asia.com/learn/tips/what-s-cinetone-and-how-do-you-use-it)

## OBS Video Filters

For [webcam](https://www.youtube.com/watch?v=DZnkyq4kqkE):

* disable low light enhancement - removes ghosting effects

For Sony a7iv I use:

*  color correction filter - Saturation: -0.20


## Screen Capture

* [Challenges in wayland](https://obsproject.com/forum/threads/no-screen-capture-option-wayland.178447/)

## Notes:

* OBS crashes when I power down my Sony a7iv when the latter is connected to PC
using USB cable.
