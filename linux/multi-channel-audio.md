# Connecting a Linux HTPC to a DD/DTS Receiver

Related:

* Notes on my use of [vlc media player](../apps/vlc.md)

## Architecture

Low Level: [Alsa](https://wiki.archlinux.org/title/Advanced_Linux_Sound_Architecture)

Low latency [Jack](https://wiki.archlinux.org/title/JACK_Audio_Connection_Kit)
middleware API.

Middle level, incumbent: [Pulse Audio](https://pulse.audio/) with
[pavucontrol](https://freedesktop.org/software/pulseaudio/pavucontrol/).

Middle level, winner: [PipeWire](https://pipewire.org/)

# Alsa Use

Use:

* cli: [alsactl](https://linux.die.net/man/1/alsactl),
[aplay](https://linux.die.net/man/1/aplay)
* config: `/etc/asound.conf`

Alsa multi-channel sound output via HDMI:

* [How to use HDMI sound w/ alsa and alsamixer?](https://forums.gentoo.org/viewtopic-t-1094774-start-0.html)
* [Output 5.1 AC-3 through Alsa, enabling Pulseaudio to use it](https://help.ubuntu.com/community/DigitalAC-3Pulseaudio)
* [DTS via HDMI using pulseaudio](https://blogs.gentoo.org/mgorny/2021/07/25/getting-dts-5-1-sound-via-s-pdif-or-hdmi-using-pulseaudio/)


## Pulse Audio Use

Use:
* [pavucontrol](https://freedesktop.org/software/pulseaudio/pavucontrol/),
[pavucontrol](http://0pointer.de/lennart/projects/pavucontrol/)
* [pactl](https://linux.die.net/man/1/pactl)
* [multi-channel-playback-on-linux](https://immersiveaudioalbum.com/multi-channel-playback-on-linux/)


## PipeWire Use

Evolving middleware alternative:
[Pipewire](https://wiki.archlinux.org/title/PipeWire):

* [PipeWire](https://pipewire.org/) with [Jack](https://jackaudio.org/)
* to get there use
[Ubuntu Studio 23.10](https://ubuntustudio.org/ubuntu-studio-installer/)

## Setting Multichannel Audio Output with ALSA

Test clips

* https://www.demolandia.net/cinema.html
* https://www2.iis.fraunhofer.de/AAC/multichannel.html
* https://drive.google.com/drive/folders/1JxmeedtAtgmoafXv9rroiDOS2vEX7N4b

Identify audio devices.  Using Alsa:
```
alex@exi:~$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC897 Analog [ALC897 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 3: HDMI 0 [SAMSUNG]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 8: HDMI 2 [HDMI 2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 9: HDMI 3 [HDMI 3]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
```

The device for card 0 is `plughw:0,0`. The two zeros come from the device 0 and
Subdevice #0.

Identify devices using pipewire
[pw-cli](https://man.archlinux.org/man/pw-cli.1.en):
```
alex@exi:~$ pw-cli list-objects | grep node.name
 		node.name = "Dummy-Driver"
 		node.name = "Freewheel-Driver"
 		node.name = "Midi-Bridge"
 		node.name = "alsa_output.pci-0000_01_00.1.hdmi-surround"
```
or just
```sh
pw-cli info all
```

## More stuff

* [Carla](https://github.com/falkTX/Carla/) audio plugin host
* [Claudia](https://kx.studio/Applications:Claudia)
