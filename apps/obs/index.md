# Open Broadcaster

* [Open Broadcaster Software](https://obsproject.com/), now in version 30.2.3.
* [Plugins](plugins.html)
* [Organizing Scenes](scenes.html)


## Audio Chain

According to
[the-best-audio-filters-for-obs](https://streamgeeks.us/the-best-audio-filters-for-obs/),
order of the filters to use:

* Noise Suppression - I use `good quality, more CPU usage` option;
* Noise Gate - disabled it;
* 3-band Equalizer - High: 0dB, Mid: 0dB, Low: +3dB;
* Compressor - Ratio: 5:1, Threshold: -12.2dB, Atack: 2ms, Release: 70ms, Output gain: 0dB

## Video Chain

For [webcam](https://www.youtube.com/watch?v=DZnkyq4kqkE):

* disable low light enhancement - removes ghosting effects

I use no filters with a7iv.

## Screen Capture

* [Challenges in wayland](https://obsproject.com/forum/threads/no-screen-capture-option-wayland.178447/)

## Notes:

* OBS crashes when I power down my Sony a7iv when the latter is connected to PC
using USB cable.
