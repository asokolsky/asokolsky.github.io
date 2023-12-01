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

Low level: [Alsa](https://wiki.archlinux.org/title/Advanced_Linux_Sound_Architecture)

* cli: [alsactl](https://linux.die.net/man/1/alsactl),
[aplay](https://linux.die.net/man/1/aplay)
* config: `/etc/asound.conf`

Alsa multi-channel sound output via HDMI:

* [How to use HDMI sound w/ alsa and alsamixer?](https://forums.gentoo.org/viewtopic-t-1094774-start-0.html)
* [Output 5.1 AC-3 through Alsa, enabling Pulseaudio to use it](https://help.ubuntu.com/community/DigitalAC-3Pulseaudio)
* [DTS via HDMI using pulseaudio](https://blogs.gentoo.org/mgorny/2021/07/25/getting-dts-5-1-sound-via-s-pdif-or-hdmi-using-pulseaudio/)


Low latency [Jack](https://wiki.archlinux.org/title/JACK_Audio_Connection_Kit)
middleware API.

Legacy middleware:
[PulseAudio](https://wiki.archlinux.org/title/PulseAudio)

* [pactl](https://linux.die.net/man/1/pactl)
* [pavucontrol](http://0pointer.de/lennart/projects/pavucontrol/)



Evolving middleware alternative:
[Pipewire](https://wiki.archlinux.org/title/PipeWire).

### In MacOS

Does not seem to be supported?

## Ubuntu PulseAudio -> PipeWire

Ubuntu 22.04 uses pulseaudio by default, but
[can be switched to pipewire](https://ubuntuhandbook.org/index.php/2022/04/pipewire-replace-pulseaudio-ubuntu-2204/).
Also: https://linuxconfig.org/how-to-install-pipewire-on-ubuntu-linux.


```sh
sudo apt install pipewire-audio-client-libraries libspa-0.2-bluetooth libspa-0.2-jack
sudo apt install wireplumber pipewire-media-session-
```

For ALSA clients to use PipeWire:
```sh
sudo cp /usr/share/doc/pipewire/examples/alsa.conf.d/99-pipewire-default.conf \
     /etc/alsa/conf.d/
```

For JACK clients to use PipeWire:

```sh
sudo cp /usr/share/doc/pipewire/examples/ld.so.conf.d/pipewire-jack-*.conf \
    /etc/ld.so.conf.d/
```

Then: `sudo ldconfig`.

For Bluetooth, just remove the pulseaudio-module-bluetooth package:
```sh
sudo apt remove pulseaudio-module-bluetooth
```

And, finally enable the media session by running command:

```sh
systemctl --user --now disable pulseaudio.service pulseaudio.socket
systemctl --user --now enable pipewire-pulse.service pipewire-pulse.socket
systemctl --user --now enable wireplumber.service
```


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
