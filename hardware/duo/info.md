```
alex@duo > sudo inxi -FRmxxxrz
System:
  Kernel: 6.8.0-55-generic arch: x86_64 bits: 64 compiler: gcc v: 13.3.0
    clocksource: tsc
  Desktop: Cinnamon v: 6.4.8 tk: GTK v: 3.24.41 wm: Muffin v: 6.4.1
    dm: LightDM v: 1.30.0 Distro: Linux Mint 22.1 Xia base: Ubuntu 24.04 noble
Machine:
  Type: Desktop Mobo: ASRock model: Z370M-ITX/ac serial: <filter>
    uuid: 66c28570-7df8-0000-0000-000000000000 UEFI: American Megatrends
    v: P4.20 date: 10/31/2019
Battery:
  Device-1: hidpp_battery_0 model: Logitech MX Vertical Advanced Ergonomic
    Mouse serial: <filter> charge: 100% (should be ignored) rechargeable: yes
    status: discharging
Memory:
  System RAM: total: 32 GiB available: 31.27 GiB used: 2.43 GiB (7.8%)
  Array-1: capacity: 32 GiB slots: 2 modules: 2 EC: None
    max-module-size: 16 GiB note: est.
  Device-1: ChannelA-DIMM0 type: DDR4 detail: synchronous unbuffered
    (unregistered) size: 16 GiB speed: 3200 MT/s volts: 1.2 width (bits):
    data: 64 total: 64 manufacturer: Crucial part-no: CP16G4DFRA32A.C8FF
    serial: <filter>
  Device-2: ChannelB-DIMM0 type: DDR4 detail: synchronous unbuffered
    (unregistered) size: 16 GiB speed: 3200 MT/s volts: 1.2 width (bits):
    data: 64 total: 64 manufacturer: Crucial part-no: CP16G4DFRA32A.C8FF
    serial: <filter>
CPU:
  Info: 6-core model: Intel Core i5-9400 bits: 64 type: MCP smt: <unsupported>
    arch: Coffee Lake rev: A cache: L1: 384 KiB L2: 1.5 MiB L3: 9 MiB
  Speed (MHz): avg: 800 min/max: 800/4100 volts: 1.0 V ext-clock: 100 MHz
    cores: 1: 800 2: 800 3: 800 4: 800 5: 800 6: 800 bogomips: 34798
  Flags: avx avx2 ht lm nx pae sse sse2 sse3 sse4_1 sse4_2 ssse3 vmx
Graphics:
  Device-1: NVIDIA GA107 [GeForce RTX 3050 6GB] vendor: Gigabyte
    driver: nvidia v: 555.42.06 arch: Ampere pcie: speed: 5 GT/s lanes: 8 ports:
    active: none off: HDMI-A-1,HDMI-A-2 empty: DP-1,DP-2 bus-ID: 01:00.0
    chip-ID: 10de:2584 class-ID: 0300
  Device-2: EMEET SmartCam S800
    driver: cdc_acm,hid-generic,snd-usb-audio,usbhid,uvcvideo type: USB rev: 3.2
    speed: 5 Gb/s lanes: 1 bus-ID: 2-5:2 chip-ID: 328f:009b class-ID: 0a00
    serial: <filter>
  Display: server: X.Org v: 21.1.11 with: Xwayland v: 23.2.6 driver: X:
    loaded: nouveau unloaded: fbdev,intel,modesetting,vesa failed: nvidia
    gpu: nvidia,nvidia-nvswitch display-ID: :0 screens: 1
  Screen-1: 0 s-res: 3000x1920 s-dpi: 96 s-size: 794x508mm (31.26x20.00")
    s-diag: 943mm (37.11")
  Monitor-1: HDMI-0 pos: left res: 1080x1920 hz: 60 dpi: 102
    size: 268x477mm (10.55x18.78") diag: 547mm (21.54") modes: N/A
  Monitor-2: HDMI-1 pos: primary,right res: 1920x1080 hz: 60 dpi: 102
    size: 476x268mm (18.74x10.55") diag: 546mm (21.51") modes: N/A
  API: EGL v: 1.5 hw: drv: nvidia platforms: device: 0 drv: nvidia device: 2
    drv: swrast surfaceless: drv: nvidia x11: drv: nvidia
    inactive: gbm,wayland,device-1
  API: OpenGL v: 4.6.0 compat-v: 4.5 vendor: nvidia mesa v: 555.42.06
    glx-v: 1.4 direct-render: yes renderer: NVIDIA GeForce RTX 3050/PCIe/SSE2
Audio:
  Device-1: Intel 200 Series PCH HD Audio vendor: ASRock driver: snd_hda_intel
    v: kernel bus-ID: 00:1f.3 chip-ID: 8086:a2f0 class-ID: 0403
  Device-2: NVIDIA vendor: Gigabyte driver: snd_hda_intel v: kernel pcie:
    speed: 8 GT/s lanes: 8 bus-ID: 01:00.1 chip-ID: 10de:2291 class-ID: 0403
  Device-3: EMEET SmartCam S800
    driver: cdc_acm,hid-generic,snd-usb-audio,usbhid,uvcvideo type: USB rev: 3.2
    speed: 5 Gb/s lanes: 1 bus-ID: 2-5:2 chip-ID: 328f:009b class-ID: 0a00
    serial: <filter>
  API: ALSA v: k6.8.0-55-generic status: kernel-api
  Server-1: PipeWire v: 1.0.5 status: n/a (root, process) with:
    1: pipewire-pulse status: active 2: wireplumber status: active
    3: pipewire-alsa type: plugin
Network:
  Device-1: Intel Ethernet I219-V vendor: ASRock driver: e1000e v: kernel
    port: N/A bus-ID: 00:1f.6 chip-ID: 8086:15b8 class-ID: 0200
  IF: eno1 state: up speed: 1000 Mbps duplex: full mac: <filter>
  Device-2: Intel I211 Gigabit Network vendor: ASRock driver: igb v: kernel
    pcie: speed: 2.5 GT/s lanes: 1 port: d000 bus-ID: 03:00.0 chip-ID: 8086:1539
    class-ID: 0200
  IF: enp3s0 state: down mac: <filter>
  Device-3: Intel Dual Band Wireless-AC 3168NGW [Stone Peak] driver: iwlwifi
    v: kernel pcie: speed: 2.5 GT/s lanes: 1 bus-ID: 04:00.0 chip-ID: 8086:24fb
    class-ID: 0280
  IF: wlp4s0 state: up mac: <filter>
Bluetooth:
  Device-1: Intel Wireless-AC 3168 Bluetooth driver: btusb v: 0.8 type: USB
    rev: 2.0 speed: 12 Mb/s lanes: 1 bus-ID: 1-13:7 chip-ID: 8087:0aa7
    class-ID: e001
  Report: hciconfig ID: hci0 rfk-id: 0 state: up address: <filter> bt-v: 4.2
    lmp-v: 8 sub-v: 1100 hci-v: 8 rev: 1100 class-ID: 7c0104
RAID:
  Message: No RAID data found.
Drives:
  Local Storage: total: 465.76 GiB used: 55.92 GiB (12.0%)
  ID-1: /dev/nvme0n1 vendor: Western Digital model: WDS500G2B0C-00PXH0
    size: 465.76 GiB speed: 31.6 Gb/s lanes: 4 tech: SSD serial: <filter>
    fw-rev: 211070WD temp: 35.9 C scheme: GPT
Partition:
  ID-1: / size: 456.89 GiB used: 55.91 GiB (12.2%) fs: ext4
    dev: /dev/nvme0n1p2
  ID-2: /boot/efi size: 510.9 MiB used: 6.1 MiB (1.2%) fs: vfat
    dev: /dev/nvme0n1p1
Swap:
  ID-1: swap-1 type: file size: 2 GiB used: 0 KiB (0.0%) priority: -2
    file: /swapfile
Sensors:
  System Temperatures: cpu: 33.0 C mobo: N/A gpu: nvidia temp: 38 C
  Fan Speeds (rpm): fan-1: 0 fan-2: 1006 fan-3: 0 fan-4: 0 fan-5: 611
    gpu: nvidia fan: 31%
Repos:
  Packages: 2246 pm: dpkg pkgs: 2235 pm: flatpak pkgs: 11
  No active apt repos in: /etc/apt/sources.list
  Active apt repos in: /etc/apt/sources.list.d/cuda-ubuntu2404-x86_64.list
    1: deb [signed-by=/usr/share/keyrings/cuda-archive-keyring.gpg] https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/ /
  Active apt repos in: /etc/apt/sources.list.d/ivpn.list
    1: deb [arch=amd64 signed-by=/usr/share/keyrings/ivpn-archive-keyring.gpg] https://repo.ivpn.net/stable/mint ./generic main
  Active apt repos in: /etc/apt/sources.list.d/mkvtoolnix.download.list
    1: deb [arch=amd64 signed-by=/usr/share/keyrings/gpg-pub-moritzbunkus.gpg] https://mkvtoolnix.download/linuxmint/ wilma main
  Active apt repos in: /etc/apt/sources.list.d/official-package-repositories.list
    1: deb https://mirrors.sonic.net/mint/packages xia main upstream import backport
    2: deb http://mirror.us-sc.kamatera.com/ubuntu noble main restricted universe multiverse
    3: deb http://mirror.us-sc.kamatera.com/ubuntu noble-updates main restricted universe multiverse
    4: deb http://mirror.us-sc.kamatera.com/ubuntu noble-backports main restricted universe multiverse
    5: deb http://security.ubuntu.com/ubuntu/ noble-security main restricted universe multiverse
  Active apt repos in: /etc/apt/sources.list.d/remmina-ppa-team-remmina-next-noble.list
    1: deb [signed-by=/etc/apt/keyrings/remmina-ppa-team-remmina-next-noble.gpg] https://ppa.launchpadcontent.net/remmina-ppa-team/remmina-next/ubuntu noble main
  Active apt repos in: /etc/apt/sources.list.d/vscode.list
    1: deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/repos/code stable main
Info:
  Processes: 285 Power: uptime: 12m states: freeze,mem,disk suspend: deep
    wakeups: 0 hibernate: platform Init: systemd v: 255 target: graphical (5)
    default: graphical
  Compilers: gcc: 13.3.0 Shell: Sudo (sudo) v: 1.9.15p5 default: Bash
    v: 5.2.21 running-in: gnome-terminal inxi: 3.3.34
```
