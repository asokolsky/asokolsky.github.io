# Intel i915 Driver Video Tearing

Test [video1](https://www.youtube.com/watch?v=MfL_JkcEFbE),
[video2](https://www.youtube.com/watch?v=2wVC-ZLhIHI),
[tearing test video](https://www.youtube.com/watch?v=5xkNy9gfKOg)

## Fix for UHD Graphics 630

Based on
[Intel_graphics](https://wiki.archlinux.org/title/Intel_graphics)
created `/etc/X11/xorg.conf.d/20-intel.conf`:

```
Section "Device"
 Identifier "Intel Graphics"
 Driver "intel"
 #Option "AccelMethod" "sna"
 Option "TearFree" "true"
 Option "TripleBuffer" "true"
EndSection
```

That did work!
