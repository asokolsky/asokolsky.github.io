# vcgencmd

[vcgencmd](https://www.raspberrypi.com/documentation/computers/os.html#vcgencmd)

## codec_enabled type

Reports whether the specified CODEC type  is  enabled.  Possible
options  for  type are AGIF, FLAC, H263, H264, MJPA, MJPB, MJPG,
MPG2, MPG4, MVC0, PCM, THRA, VORB, VP6, VP8, WMV9, WVC1.

MPG2, WMV9, and WVC1 currently require a paid for  licence  (see the  [FAQ]  for more info), except on the Pi4, where these hardware codecs are disabled in  preference  to  software  decoding, which  requires no licence. Note that because the H265 hardware block on the Raspberry Pi4 is not part of the VideoCore GPU, its status is not accessed via this command.

## get_camera

Displays the enabled and detected state of the official  camera.
1  means  yes,  0  means no.
Whilst all firmware (except cutdown versions) will support the camera, this support needs to be  enabled by using the start_x boot option [BOOT].

## get_config type|name

This returns  all the configuration items of the specified type that have been set in `config.txt`, or a single configuration item. Possible values for type parameter are `int`, `str`, or simply use the name of the configuration item.

## get_lcd_info

Displays the resolution and colour depth of any attached display.

## get_mem type

Reports on the amount of memory allocated to the ARM cores with
```sh
vcgencmd get_mem arm
```

or the VC4 with
```sh
vcgencmd get_mem gpu
```

Note: On a Raspberry Pi 4 with greater than 1GB of RAM, the  arm option is inaccurate. This is because the GPU firmware which implements this command is only aware of the first gigabyte of RAM on the system, so the arm setting will always return 1GB minus the gpu memory value. To get an accurate report of the amount of ARM memory, use one of the standard Linux commands, such as `free` or `cat /proc/meminfo`.

## get_throttled

```sh
vcgencmd get_throttled
```

Returns the throttled state of the system. This is a bit pattern - a bit being set indicates the following meanings:

Bit|Meaning
---|------------------------------------
0|Under-voltage detected
1|Arm frequency capped
2|Currently throttled
3|Soft temperature limit active
16|Under-voltage has occurred
17|Arm frequency capping has occurred
18|Throttling has occurred
19|Soft temperature limit has occurred

A value of zero indicates that none of the above conditions is true.

To find if one of these bits has been set, convert the value returned to binary, then number each bit along the top. You can then see which bits are set. For example:
```
0x50000 = 0101 0000 0000 0000 0000
```
Adding the bit numbers along the top we get:
```
19   18   17   16   15   14   13   12   11   10   9   8   7   6   5   4   3   2   1   0
0    1    0    1    0    0    0    0    0    0   0   0   0   0   0   0   0   0   0   0
```
From  this  we  can  see that bits 18 and 16 are set, indicating that the Pi has previously been throttled due to  under-voltage, but is not currently throttled for any reason.

## measure_clock clock

This returns the current frequency of the specified  clock.  The options are:

Clock|Description
-----|-----------
arm|ARM cores
core|VC4 scaler cores
h264|H.264 block
isp|Image Signal Processor
v3d|3D block
uart|UART
pwm|PWM block (analog audio output)
emmc|SD card interface
pixel|Pixel valve
vec|Analog video encoder
hdmi|HDMI
dpi|Display Peripheral Interface

## measure_temp

```sh
vcgencmd measure_temp
```

Returns the temperature of the SoC as measured by the on-board temperature sensor.

## measure_volts block

Displays the current voltages used by the specific block.

Block|Description
-----|-----------
core|VC4 core voltage
sdram_c|.
sdram_i|.
sdram_p|.

## mem_oom

Displays  statistics on any Out Of Memory events occuring in the VC4 memory space.

## mem_reloc_stats

Displays statistics from the relocatable memory allocator on the VC4.


## otp_dump

Displays  the content of the One Time Programmable (OTP) memory, which is part of the SoC. These are 32 bit values, indexed  from 8 to 64. See the raspi-otp(7) for more details.

## read_ring_osc

Returns the current speed voltage and temperature of the ring oscillator.

## hdmi_timings

Displays the current HDMI settings timings. See [VIDEO] for  details of the values returned.

## dispmanx_list

Dump a list of all dispmanx items currently being displayed.

## display_power 0|1|-1, display_power 0|1|-1 display

Show  current  display power state, or set the display power state.
```sh
vcgencmd display_power 0
```
will turn off power to the current display.
```sh
vcgencmd  display_power 1
```
will turn on power to the display. If no parameter is set, this will display the  current power state. The final parameter is an optional display ID, as returned by `tvservice -l` or from the table below,  which  allows a specific display to be turned on or off.

`vcgencmd  display_power 0 7` will turn off power to display ID 7, which is HDMI 1 on a Raspberry Pi 4.

Display|ID
-------|--
Main LCD|0
Secondary LCD|1
HDMI 0|2
Composite|3
HDMI 1|7

To determine if a specific display ID is on or off,  use -1 as the first parameter.

`vcgencmd  display_power -1 7`  will return 0 if display ID 7 is off, 1 if display ID 7 is on, or -1 if display ID 7 is in an unknown state, for example undetected.

## EXIT STATUS

0 Command completed successfully

-1 Problem with VHCI

-2 VideoCore returned an error
