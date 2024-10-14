# Open Broadcaster Notes

* [Open Broadcaster Software](https://obsproject.com/), now in version 30.2.3.
* [Plugins](plugins.html)

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


## Notes:

* OBS crashes when I power down my Sony a7iv when the latter is connected to PC
using USB cable.

## Scenes

We start with low level scenes:

* Main Native
* Main Masked

and then introduce the higher abstraction level scenes:

* Main
* Window

This allows us to reuse the device settings between scenes of different
abstraction level.

### Low Level Scene: Main Native

Configure your video capture device and microphone.  Setup microphone filters
as described above.

### Low Level Scene: Main Masked

* source: scene `Main Native`

Scene (NOT source!) filter:

* Image Mask/Blend: Type: `Alpha Mask (Alpha Channel)`,

![mask-circle](./mask-circle.png)

To apply the scene filter: right mouse click on the scene, select Filters

### End User Scene: Main

Source: scene `Main Native`

### End User Scene: Window

Sources:

* Scene `Main Masked` - offset to the right bottom
* Screen capture - takes all the frame, z-order move to back.
