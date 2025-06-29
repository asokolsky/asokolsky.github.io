# inxi

```
alex@t14gen3 > sudo inxi -FRmxxxrz
System:
  Kernel: 6.14.0-22-generic arch: x86_64 bits: 64 compiler: gcc v: 14.2.0
    clocksource: tsc
  Desktop: KDE Plasma v: 6.3.4 tk: Qt v: N/A wm: kwin_wayland dm: SDDM
    Distro: Kubuntu 25.04 (Plucky Puffin) base: Ubuntu
Machine:
  Type: Laptop System: LENOVO product: 21AH00BNUS v: ThinkPad T14 Gen 3
    serial: <filter> Chassis: type: 10 serial: <filter>
  Mobo: LENOVO model: 21AH00BNUS v: SDK0T76538 WIN serial: <filter>
    part-nu: LENOVO_MT_21AH_BU_Think_FM_ThinkPad T14 Gen 3
    uuid: 6df767cc-270e-11b2-a85c-a8eb0cb78673 UEFI: LENOVO
    v: N3MET23W (1.22 ) date: 11/07/2024
Battery:
  ID-1: BAT0 charge: 47.1 Wh (100.0%) condition: 47.1/52.6 Wh (89.6%)
    volts: 16.9 min: 15.5 model: SMP 5B10W51865 type: Li-poly serial: <filter>
    status: full cycles: 41
  Device-1: hidpp_battery_0 model: Logitech M510 serial: <filter>
    charge: 55% (should be ignored) rechargeable: yes status: discharging
Memory:
  System RAM: total: 16 GiB available: 15.3 GiB used: 4.35 GiB (28.4%)
    igpu: 64 MiB
  Array-1: capacity: 256 GiB slots: 8 modules: 2 EC: None
    max-module-size: 32 GiB note: est.
  Device-1: Controller0-ChannelA type: DDR4 detail: synchronous size: 8 GiB
    speed: 3200 MT/s volts: 1.2 width (bits): data: 64 total: 64
    manufacturer: Samsung part-no: M471A1G44BB0-CWE serial: N/A
  Device-2: Controller0-ChannelB-DIMM0 type: no module installed
  Device-3: Controller0-ChannelC-DIMM0 type: no module installed
  Device-4: Controller0-ChannelD-DIMM0 type: no module installed
  Device-5: Controller1-ChannelA-DIMM0 type: DDR4 detail: synchronous
    size: 8 GiB speed: 3200 MT/s volts: 1.2 width (bits): data: 64 total: 64
    manufacturer: Samsung part-no: M471A1G44BB0-CWE serial: <filter>
  Device-6: Controller1-ChannelB-DIMM0 type: no module installed
  Device-7: Controller1-ChannelC-DIMM0 type: no module installed
  Device-8: Controller1-ChannelD-DIMM0 type: no module installed
CPU:
  Info: 12-core (4-mt/8-st) model: 12th Gen Intel Core i7-1270P bits: 64
    type: MST AMCP smt: enabled arch: Alder Lake rev: 3 cache: L1: 1.1 MiB
    L2: 9 MiB L3: 18 MiB
  Speed (MHz): avg: 400 min/max: 400/4800:3500 volts: 1.0 V
    ext-clock: 100 MHz cores: 1: 400 2: 400 3: 400 4: 400 5: 400 6: 400 7: 400
    8: 400 9: 400 10: 400 11: 400 12: 400 13: 400 14: 400 15: 400 16: 400
    bogomips: 79872
  Flags: avx avx2 ht lm nx pae sse sse2 sse3 sse4_1 sse4_2 ssse3 vmx
Graphics:
  Device-1: Intel Alder Lake-P GT2 [Iris Xe Graphics] vendor: Lenovo
    driver: i915 v: kernel arch: Xe ports: active: eDP-1 empty: DP-1, DP-2,
    DP-3, DP-4, HDMI-A-1 bus-ID: 00:02.0 chip-ID: 8086:46a6 class-ID: 0300
  Device-2: Syntek Integrated Camera driver: uvcvideo type: USB rev: 2.0
    speed: 480 Mb/s lanes: 1 bus-ID: 3-4:3 chip-ID: 174f:1812 class-ID: fe01
    serial: <filter>
  Display: unspecified server: X.Org v: 24.1.6 with: Xwayland v: 24.1.6
    compositor: kwin_wayland driver: X: loaded: modesetting unloaded: fbdev,vesa
    dri: iris gpu: i915 display-ID: :1 screens: 1
  Screen-1: 0 s-res: 2240x1400 s-dpi: 96 s-size: 593x370mm (23.35x14.57")
    s-diag: 699mm (27.52")
  Monitor-1: eDP-1 model: BOE Display 0x0ac9 res: mode: 2240x1400 hz: 60
    scale: 100% (1) dpi: 188 size: 302x189mm (11.89x7.44") diag: 356mm (14")
    modes: 2240x1400
  API: EGL v: 1.5 hw: drv: intel iris platforms: device: 0 drv: iris
    device: 1 drv: swrast gbm: drv: iris surfaceless: drv: iris x11: drv: iris
    inactive: wayland
  API: OpenGL v: 4.6 compat-v: 4.5 vendor: intel mesa v: 25.0.3-1ubuntu2
    glx-v: 1.4 direct-render: yes renderer: Mesa Intel Iris Xe Graphics (ADL
    GT2) device-ID: 8086:46a6
  API: Vulkan v: 1.4.304 layers: 3 surfaces: xcb,xlib device: 0
    type: integrated-gpu driver: N/A device-ID: 8086:46a6 device: 1 type: cpu
    driver: N/A device-ID: 10005:0000
  Info: Tools: api: clinfo, eglinfo, glxinfo, vulkaninfo
    de: kscreen-console,kscreen-doctor wl: wayland-info x11: xdriinfo,
    xdpyinfo, xprop, xrandr
Audio:
  Device-1: Intel Alder Lake PCH-P High Definition Audio vendor: Lenovo
    driver: sof-audio-pci-intel-tgl bus-ID: 00:1f.3 chip-ID: 8086:51c8
    class-ID: 0403
  API: ALSA v: k6.14.0-22-generic status: kernel-api
  Server-1: PipeWire v: 1.2.7 status: n/a (root, process) with:
    1: pipewire-pulse status: active 2: wireplumber status: active
    3: pipewire-alsa type: plugin 4: pw-jack type: plugin
Network:
  Device-1: Intel Alder Lake-P PCH CNVi WiFi driver: iwlwifi v: kernel
    bus-ID: 00:14.3 chip-ID: 8086:51f0 class-ID: 0280
  IF: wlp0s20f3 state: up mac: <filter>
  Device-2: Intel Ethernet I219-LM vendor: Lenovo driver: e1000e v: kernel
    port: N/A bus-ID: 00:1f.6 chip-ID: 8086:1a1e class-ID: 0200
  IF: enp0s31f6 state: down mac: <filter>
Bluetooth:
  Device-1: Intel AX211 Bluetooth driver: btusb v: 0.8 type: USB rev: 2.0
    speed: 12 Mb/s lanes: 1 bus-ID: 3-10:4 chip-ID: 8087:0033 class-ID: e001
  Report: hciconfig ID: hci0 rfk-id: 1 state: up address: <filter> bt-v: 5.3
    lmp-v: 12 sub-v: 37c8 hci-v: 12 rev: 37c8 class-ID: 6c010c
RAID:
  Message: No RAID data found.
Drives:
  Local Storage: total: 476.94 GiB used: 15.06 GiB (3.2%)
  ID-1: /dev/nvme0n1 vendor: Micron model: MTFDKBA512TFK size: 476.94 GiB
    speed: 63.2 Gb/s lanes: 4 tech: SSD serial: <filter> fw-rev: 7003V5LN
    temp: 31.9 C scheme: GPT
Partition:
  ID-1: / size: 467.35 GiB used: 15.05 GiB (3.2%) fs: ext4 dev: /dev/nvme0n1p2
  ID-2: /boot/efi size: 1.05 GiB used: 6.2 MiB (0.6%) fs: vfat
    dev: /dev/nvme0n1p1
Swap:
  ID-1: swap-1 type: file size: 4 GiB used: 0 KiB (0.0%) priority: -2
    file: /swap.img
Sensors:
  Src: /sys System Temperatures: cpu: 49.0 C mobo: N/A
  Fan Speeds (rpm): cpu: 2063
  Power: 12v: N/A 5v: 5 3.3v: N/A vbat: N/A
Repos:
  Packages: 2263 pm: dpkg pkgs: 2246 pm: snap pkgs: 17
  No active apt repos in: /etc/apt/sources.list
  Active apt repos in: /etc/apt/sources.list.d/ubuntu.sources
    1: deb http://archive.ubuntu.com/ubuntu/ plucky plucky-updates plucky-backports main restricted universe multiverse
    2: deb http://security.ubuntu.com/ubuntu/ plucky-security main restricted universe multiverse
  Active apt repos in: /etc/apt/sources.list.d/vscode.sources
    1: deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/repos/code stable main
Info:
  Processes: 404 Power: uptime: 21m states: freeze,mem,disk suspend: s2idle
    wakeups: 0 hibernate: platform Init: systemd v: 257 default: graphical
  Compilers: N/A Shell: Sudo (sudo) v: 1.9.16p2 default: Bash v: 5.2.37
    running-in: konsole inxi: 3.3.37
```
