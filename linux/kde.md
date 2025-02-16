# Linux KDE Customization

Installed KDE Neon:

* Operating System: KDE neon 6.2
* KDE Plasma Version: 6.3.0
* KDE Frameworks Version: 6.10.0
* Qt Version: 6.8.2
* Kernel Version: 6.11.0-17-generic (64-bit)
* Graphics Platform: Wayland
* Processors: 8x Intel® Core™ i7-8650U CPU @ 1.90GHz
* Memory: 31.2 GiB of RAM
* Graphics Processor: Mesa Intel® UHD Graphics 620
* Manufacturer: Dell Inc.
* Product Name: Latitude 7490

```
alex@latitude7490:~$ lsb_release -a
No LSB modules are available.
Distributor ID: Neon
Description:    KDE neon 6.2
Release:        24.04
Codename:       noble
```

Kernel:
```
alex@latitude7490:~$ uname -a
Linux latitude7490 6.11.0-17-generic #17~24.04.2-Ubuntu SMP PREEMPT_DYNAMIC Mon Jan 20 22:48:29 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
```

## Installed Extras

```sh
sudo apt install pulseaudio-utils
```

## Challenges

### Swap CapsLock with LeftCtrl

Used https://github.com/rvaiya/keyd

### Accessing SMB shares in Dolphin

where to specify username/password?

Tried:

* smb://alex@nas/home

Observed:

* https://www.mail-archive.com/kde-bugs-dist@kde.org/msg439838.html
