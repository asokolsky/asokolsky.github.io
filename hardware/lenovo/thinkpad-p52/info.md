```
alex@p52 > sudo inxi -FRmxxxrz
System:
  Kernel: 6.8.0-54-generic arch: x86_64 bits: 64 compiler: gcc v: 13.3.0
    clocksource: tsc
  Desktop: Cinnamon v: 6.4.8 tk: GTK v: 3.24.41 wm: Muffin v: 6.4.1
    dm: LightDM v: 1.30.0 Distro: Linux Mint 22.1 Xia base: Ubuntu 24.04 noble
Machine:
  Type: Laptop System: LENOVO product: 20M9CTO1WW v: ThinkPad P52
    serial: <filter> Chassis: type: 10 serial: <filter>
  Mobo: LENOVO model: 20M9CTO1WW v: SDK0R32862 WIN serial: <filter>
    part-nu: LENOVO_MT_20M9_BU_Think_FM_ThinkPad P52
    uuid: 5eaa53cc-352f-11b2-a85c-eba42e829a7f UEFI: LENOVO
    v: N2CET70W (1.53 ) date: 03/11/2024
Battery:
  ID-1: BAT0 charge: 38.3 Wh (45.9%) condition: 83.4/90.0 Wh (92.7%)
    power: 51.5 W volts: 12.5 min: 11.2 model: SMP 01AV496 type: Li-poly
    serial: <filter> status: charging cycles: 232
  Device-1: hidpp_battery_0 model: Logitech Marathon Mouse/Performance Plus
    M705 serial: <filter> charge: 55% (should be ignored) rechargeable: yes
    status: discharging
Memory:
  System RAM: total: 32 GiB available: 30.99 GiB used: 2.72 GiB (8.8%)
    igpu: 64 MiB
  Array-1: capacity: 64 GiB slots: 4 modules: 4 EC: None
    max-module-size: 16 GiB note: est.
  Device-1: ChannelA-DIMM0 type: DDR4 detail: synchronous size: 8 GiB
    speed: 2667 MT/s volts: 1.2 width (bits): data: 64 total: 64
    manufacturer: Samsung part-no: M471A1K43CB1-CTD serial: <filter>
  Device-2: ChannelA-DIMM1 type: DDR4 detail: synchronous size: 8 GiB
    speed: 2667 MT/s volts: 1.2 width (bits): data: 64 total: 64
    manufacturer: Micron part-no: 8ATF1G64HZ-2G6E1 serial: <filter>
  Device-3: ChannelB-DIMM0 type: DDR4 detail: synchronous size: 8 GiB
    speed: 2667 MT/s volts: 1.2 width (bits): data: 64 total: 64
    manufacturer: Samsung part-no: M471A1K43CB1-CTD serial: <filter>
  Device-4: ChannelB-DIMM1 type: DDR4 detail: synchronous size: 8 GiB
    speed: 2667 MT/s volts: 1.2 width (bits): data: 64 total: 64
    manufacturer: Micron part-no: 8ATF1G64HZ-2G6E1 serial: <filter>
CPU:
  Info: 6-core model: Intel Core i7-8750H bits: 64 type: MT MCP smt: enabled
    arch: Coffee Lake rev: A cache: L1: 384 KiB L2: 1.5 MiB L3: 9 MiB
  Speed (MHz): avg: 833 high: 901 min/max: 800/4100 volts: 0.8 V
    ext-clock: 100 MHz cores: 1: 800 2: 901 3: 800 4: 800 5: 800 6: 900 7: 800
    8: 900 9: 900 10: 800 11: 800 12: 800 bogomips: 52799
  Flags: avx avx2 ht lm nx pae sse sse2 sse3 sse4_1 sse4_2 ssse3 vmx
Graphics:
  Device-1: Intel CoffeeLake-H GT2 [UHD Graphics 630] vendor: Lenovo
    driver: i915 v: kernel arch: Gen-9.5 ports: active: eDP-1 empty: DP-1,
    DP-2, HDMI-A-1, HDMI-A-2, HDMI-A-3 bus-ID: 00:02.0 chip-ID: 8086:3e9b
    class-ID: 0300
  Device-2: NVIDIA GP107GLM [Quadro P1000 Mobile] vendor: Lenovo
    driver: nvidia v: 535.183.01 arch: Pascal pcie: speed: 8 GT/s lanes: 16
    ports: active: none empty: DP-3, DP-4, DP-5, HDMI-A-4 bus-ID: 01:00.0
    chip-ID: 10de:1cbb class-ID: 0300
  Device-3: Chicony Integrated Camera (1280x720@30) driver: uvcvideo
    type: USB rev: 2.0 speed: 480 Mb/s lanes: 1 bus-ID: 1-8:3 chip-ID: 04f2:b604
    class-ID: 0e02 serial: <filter>
  Display: x11 server: X.Org v: 21.1.11 with: Xwayland v: 23.2.6 driver: X:
    loaded: modesetting,nvidia unloaded: fbdev,nouveau,vesa dri: iris gpu: i915
    display-ID: :0 screens: 1
  Screen-1: 0 s-res: 1920x1080 s-dpi: 102 s-size: 480x270mm (18.90x10.63")
    s-diag: 551mm (21.68")
  Monitor-1: eDP-1 mapped: eDP-1-1 model: BOE Display 0x0792 res: 1920x1080
    hz: 60 dpi: 142 size: 344x194mm (13.54x7.64") diag: 395mm (15.5")
    modes: 1920x1080
  API: EGL v: 1.5 hw: drv: intel iris drv: nvidia platforms: device: 0
    drv: nvidia device: 1 drv: iris device: 3 drv: swrast gbm: drv: iris
    surfaceless: drv: nvidia x11: drv: nvidia inactive: wayland,device-2
  API: OpenGL v: 4.6.0 compat-v: 4.5 vendor: nvidia mesa v: 535.183.01
    glx-v: 1.4 direct-render: yes renderer: Quadro P1000/PCIe/SSE2
Audio:
  Device-1: Intel Cannon Lake PCH cAVS vendor: Lenovo driver: snd_hda_intel
    v: kernel bus-ID: 00:1f.3 chip-ID: 8086:a348 class-ID: 0403
  Device-2: NVIDIA GP107GL High Definition Audio driver: snd_hda_intel
    v: kernel pcie: speed: 8 GT/s lanes: 16 bus-ID: 01:00.1 chip-ID: 10de:0fb9
    class-ID: 0403
  API: ALSA v: k6.8.0-54-generic status: kernel-api
  Server-1: PipeWire v: 1.0.5 status: n/a (root, process) with:
    1: pipewire-pulse status: active 2: wireplumber status: active
    3: pipewire-alsa type: plugin
Network:
  Device-1: Intel Cannon Lake PCH CNVi WiFi driver: iwlwifi v: kernel
    bus-ID: 00:14.3 chip-ID: 8086:a370 class-ID: 0280
  IF: wlp0s20f3 state: up mac: <filter>
  Device-2: Intel Ethernet I219-V vendor: Lenovo driver: e1000e v: kernel
    port: N/A bus-ID: 00:1f.6 chip-ID: 8086:15bc class-ID: 0200
  IF: enp0s31f6 state: down mac: <filter>
Bluetooth:
  Device-1: Intel Bluetooth 9460/9560 Jefferson Peak (JfP) driver: btusb
    v: 0.8 type: USB rev: 2.0 speed: 12 Mb/s lanes: 1 bus-ID: 1-14:5
    chip-ID: 8087:0aaa class-ID: e001
  Report: hciconfig ID: hci0 rfk-id: 3 state: up address: <filter> bt-v: 5.1
    lmp-v: 10 sub-v: 100 hci-v: 10 rev: 100 class-ID: 7c010c
RAID:
  Message: No RAID data found.
Drives:
  Local Storage: total: 1.88 TiB used: 244.42 GiB (12.7%)
  ID-1: /dev/nvme0n1 vendor: Crucial model: CT1000P3SSD8 size: 931.51 GiB
    speed: 31.6 Gb/s lanes: 4 tech: SSD serial: <filter> fw-rev: P9CR313
    temp: 25.9 C scheme: GPT
  ID-2: /dev/sda vendor: Crucial model: CT1000MX500SSD1 size: 931.51 GiB
    speed: 6.0 Gb/s tech: SSD serial: <filter> fw-rev: 022 scheme: GPT
  ID-3: /dev/sdb vendor: Actions model: HS USB FlashDisk size: 62.23 GiB
    type: USB rev: 2.0 spd: 480 Mb/s lanes: 1 tech: SSD serial: <filter>
Partition:
  ID-1: / size: 915.32 GiB used: 129.14 GiB (14.1%) fs: ext4
    dev: /dev/nvme0n1p2
  ID-2: /boot/efi size: 511 MiB used: 6.1 MiB (1.2%) fs: vfat
    dev: /dev/nvme0n1p1
Swap:
  ID-1: swap-1 type: file size: 2 GiB used: 0 KiB (0.0%) priority: -2
    file: /swapfile
Sensors:
  System Temperatures: cpu: 52.0 C pch: 46.0 C mobo: N/A gpu: nvidia
    temp: 44 C
  Fan Speeds (rpm): N/A
Repos:
  Packages: 2879 pm: dpkg pkgs: 2864 pm: flatpak pkgs: 15
  No active apt repos in: /etc/apt/sources.list
  Active apt repos in: /etc/apt/sources.list.d/obsproject-obs-studio-noble.list
    1: deb [signed-by=/etc/apt/keyrings/obsproject-obs-studio-noble.gpg] https://ppa.launchpadcontent.net/obsproject/obs-studio/ubuntu noble main
  Active apt repos in: /etc/apt/sources.list.d/official-package-repositories.list
    1: deb https://mirror.fcix.net/linuxmint-packages xia main upstream import backport
    2: deb http://mirror.math.ucdavis.edu/ubuntu noble main restricted universe multiverse
    3: deb http://mirror.math.ucdavis.edu/ubuntu noble-updates main restricted universe multiverse
    4: deb http://mirror.math.ucdavis.edu/ubuntu noble-backports main restricted universe multiverse
    5: deb http://security.ubuntu.com/ubuntu/ noble-security main restricted universe multiverse
  Active apt repos in: /etc/apt/sources.list.d/vscode.list
    1: deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/repos/code stable main
Info:
  Processes: 337 Power: uptime: 20h 6m states: freeze,mem,disk suspend: deep
    wakeups: 1 hibernate: platform Init: systemd v: 255 target: graphical (5)
    default: graphical
  Compilers: gcc: 13.3.0 alt: 11/12 Shell: Sudo (sudo) v: 1.9.15p5
    default: Bash v: 5.2.21 running-in: code inxi: 3.3.34
```