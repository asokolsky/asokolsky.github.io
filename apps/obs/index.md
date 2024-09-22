# Open Broadcaster Notes

[Open Broadcaster Software](https://obsproject.com/).

[Plugins](plugins.html)

## Audio Chain

According to
[the-best-audio-filters-for-obs](https://streamgeeks.us/the-best-audio-filters-for-obs/),
order of the filters to use:

* Noise Suppression
* Noise Gate - I disabled it
* EQ
* Compression. My settings: threshold - 20dB, ratio - 10:1

## Video Chain

https://www.youtube.com/watch?v=DZnkyq4kqkE


* disable low light enhancement - removes ghosting effects

## Scenes

We start with low level scenes:

* Main Native
* Main Masked

and then introduce the higher abstraction level
scenes:

* Main
* Window

This allows us to reuse the device settings between scenes of different
abstraction level.

### Low Level Scene: Main Native

Configure your video capture device and microphone.  Setup microphone filters
as described above.

### Low Level Scene: Main Masked

* source: scene `Main Native`
+ mask applied
* filter: `Image Mask/Blend`
* image: [mask-circle](./mask-circle.png)
* type: `mask_alpha_filter.effect`

### End User Scene: Main

Source: scene `Main Native`

### End User Scene: Window

Sources:

* Scene `Main Masked` - offset to the right bottom
* Screen capture - takes all the frame, z-order move to back.
