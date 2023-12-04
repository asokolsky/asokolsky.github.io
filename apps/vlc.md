# VLC Settings

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
