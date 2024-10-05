# DaVinci Resolve on Linux

Sources of information:

* https://github.com/flolu/davinci-resolve-linux
* [DaVinci Resolve on Ubuntu 24.04 - the easy way](https://www.youtube.com/watch?v=FHnNqtAwJ6M&t=0s)
* [with AMD graphics](https://forums.linuxmint.com/viewtopic.php?t=426123),
* [generic Mint22](https://www.reddit.com/r/linuxmint/comments/1eljohq/mint_22_and_davinci_resolve/)

Download from https://www.blackmagicdesign.com/products/davinciresolve


```
alex@exi | ~ > sudo apt install libxcb-cursor0
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following NEW packages will be installed:
  libxcb-cursor0
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 10.7 kB of archives.
After this operation, 39.9 kB of additional disk space will be used.
Get:1 http://mirror.math.ucdavis.edu/ubuntu noble/universe amd64 libxcb-cursor0 amd64 0.1.4-1build1 [10.7 kB]
Fetched 10.7 kB in 1s (9,770 B/s)
Selecting previously unselected package libxcb-cursor0:amd64.
(Reading database ... 506475 files and directories currently installed.)
Preparing to unpack .../libxcb-cursor0_0.1.4-1build1_amd64.deb ...
Unpacking libxcb-cursor0:amd64 (0.1.4-1build1) ...
Setting up libxcb-cursor0:amd64 (0.1.4-1build1) ...
Processing triggers for libc-bin (2.39-0ubuntu8.3) ...

alex@exi | ~ > sudo apt install libapr1 libaprutil1 libasound2
[sudo] password for alex:
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Note, selecting 'libapr1t64' instead of 'libapr1'
Note, selecting 'libaprutil1t64' instead of 'libaprutil1'
Package libasound2 is a virtual package provided by:
  liboss4-salsa-asound2 4.2-build2020-1ubuntu3
  libasound2t64 1.2.11-1build2 (= 1.2.11-1build2)
You should explicitly select one to install.

E: Package 'libasound2' has no installation candidate

```
