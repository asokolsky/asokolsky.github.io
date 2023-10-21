# Managing Displays in Linux

## xrandr

From [how-to-configure-your-monitors-with-xrandr-in-linux](https://linuxconfig.org/how-to-configure-your-monitors-with-xrandr-in-linux):

Query the attached monitors:
```
> xrandr -q
Screen 0: minimum 320 x 200, current 3440 x 1440, maximum 16384 x 16384
eDP-1 connected (normal left inverted right x axis y axis)
   1920x1080     60.05 +  60.05    48.04
   1680x1050     60.05
   1400x1050     60.05
   1600x900      60.05
...
HDMI-1 disconnected (normal left inverted right x axis y axis)
DP-1 connected primary 3440x1440+0+0 (normal left inverted right x axis y axis) 800mm x 334mm
   3440x1440     59.99*+
   1920x1080     60.00    60.00    59.94
   1280x720      60.00    59.94
   1024x768      60.00
   800x600       60.32
   720x480       60.00    59.94
   640x480       60.00    59.94
HDMI-2 disconnected (normal left inverted right x axis y axis)
DP-1-1 disconnected (normal left inverted right x axis y axis)
DP-1-2 disconnected (normal left inverted right x axis y axis)
DP-1-3 disconnected (normal left inverted right x axis y axis)
```

Setting the resolution and the refresh rate:

```sh
xrandr --output DP-1-1 --mode 3840x1600 --rate 30.00 \
       --output DP-1-2 --mode 3840x1600 --rate 30.00 \
       --output DP-1-3 --mode 3840x1600 --rate 30.00
```
