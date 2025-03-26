# latitude info

```
alex@latitude7490:~$  sudo inxi -FRmxxxrz
System:
  Kernel: 6.11.0-21-generic arch: x86_64 bits: 64 compiler: gcc v: 13.3.0
    clocksource: tsc
  Desktop: KDE Plasma v: 6.3.3 tk: Qt v: N/A wm: kwin_wayland dm: SDDM
    Distro: KDE neon 24.04 6.3 base: Ubuntu 24.04 LTS Noble
Machine:
  Type: Laptop System: Dell product: Latitude 7490 v: N/A serial: <filter>
    Chassis: type: 10 serial: <filter>
  Mobo: Dell model: N/A serial: <filter> part-nu: 081C
    uuid: 4c4c4544-0030-5410-804d-b8c04f344d32 UEFI: Dell v: 1.41.0
    date: 11/06/2024
Battery:
  ID-1: BAT0 charge: 41.0 Wh (83.2%) condition: 49.3/60.0 Wh (82.1%)
    volts: 8.4 min: 7.6 model: SMP DELL DM3WC64 type: Li-poly serial: <filter>
    status: charging
  Device-1: hidpp_battery_0 model: Logitech M510 serial: <filter>
    charge: 55% (should be ignored) rechargeable: yes status: discharging
Memory:
  System RAM: total: 32 GiB available: 31.2 GiB used: 3.43 GiB (11.0%)
    igpu: 32 MiB
  Array-1: capacity: 32 GiB slots: 2 modules: 2 EC: None
    max-module-size: 16 GiB note: est.
  Device-1: DIMM A type: DDR4 detail: synchronous unbuffered (unregistered)
    size: 16 GiB speed: spec: 3200 MT/s actual: 2400 MT/s volts: 1.2
    width (bits): data: 64 total: 64 manufacturer: 859B0000802C
    part-no: CT16G4SFRA32A.C16FR serial: <filter>
  Device-2: DIMM B type: DDR4 detail: synchronous unbuffered (unregistered)
    size: 16 GiB speed: spec: 3200 MT/s actual: 2400 MT/s volts: 1.2
    width (bits): data: 64 total: 64 manufacturer: 859B0000802C
    part-no: CT16G4SFRA32A.C16FR serial: <filter>
CPU:
  Info: quad core model: Intel Core i7-8650U bits: 64 type: MT MCP
    smt: enabled arch: Coffee Lake rev: A cache: L1: 256 KiB L2: 1024 KiB
    L3: 8 MiB
  Speed (MHz): avg: 650 high: 800 min/max: 400/4200 volts: 0.7 V
    ext-clock: 100 MHz cores: 1: 400 2: 800 3: 800 4: 800 5: 800 6: 800 7: 400
    8: 400 bogomips: 33599
  Flags: avx avx2 ht lm nx pae sse sse2 sse3 sse4_1 sse4_2 ssse3 vmx
Graphics:
  Device-1: Intel UHD Graphics 620 vendor: Dell driver: i915 v: kernel
    arch: Gen-9.5 ports: active: eDP-1 empty: DP-1,HDMI-A-1,HDMI-A-2
    bus-ID: 00:02.0 chip-ID: 8086:5917 class-ID: 0300
  Device-2: Realtek Integrated_Webcam_HD driver: uvcvideo type: USB rev: 2.1
    speed: 480 Mb/s lanes: 1 bus-ID: 1-5:2 chip-ID: 0bda:58ca class-ID: 0e02
    serial: <filter>
  Display: server: X.Org v: 23.2.6 with: Xwayland v: 23.2.6
    compositor: kwin_wayland driver: X: loaded: modesetting unloaded: fbdev,vesa
    dri: iris gpu: i915 display-ID: :1 screens: 1
  Screen-1: 0 s-res: 1920x1080 s-dpi: 96 s-size: 508x286mm (20.00x11.26")
    s-diag: 583mm (22.95")
  Monitor-1: eDP-1 model: AU Optronics 0x223d res: 1920x1080 hz: 60 dpi: 158
    size: 309x174mm (12.17x6.85") diag: 355mm (14") modes: 1920x1080
  API: EGL v: 1.5 hw: drv: intel iris platforms: device: 0 drv: iris
    device: 1 drv: swrast gbm: drv: iris surfaceless: drv: iris x11: drv: iris
    inactive: wayland
  API: OpenGL v: 4.6 compat-v: 4.5 vendor: intel mesa
    v: 24.2.8-1ubuntu1~24.04.1 glx-v: 1.4 direct-render: yes renderer: Mesa
    Intel UHD Graphics 620 (KBL GT2) device-ID: 8086:5917
  API: Vulkan v: 1.3.275 layers: 3 surfaces: xcb,xlib device: 0
    type: integrated-gpu driver: N/A device-ID: 8086:5917 device: 1 type: cpu
    driver: N/A device-ID: 10005:0000
Audio:
  Device-1: Intel Sunrise Point-LP HD Audio vendor: Dell driver: snd_hda_intel
    v: kernel bus-ID: 00:1f.3 chip-ID: 8086:9d71 class-ID: 0403
  API: ALSA v: k6.11.0-21-generic status: kernel-api
  Server-1: PipeWire v: 1.2.6 status: n/a (root, process) with:
    1: pipewire-pulse status: active 2: wireplumber status: active
Network:
  Device-1: Intel Ethernet I219-LM vendor: Dell driver: e1000e v: kernel
    port: N/A bus-ID: 00:1f.6 chip-ID: 8086:15d7 class-ID: 0200
  IF: enp0s31f6 state: down mac: <filter>
  Device-2: Intel Wi-Fi 6E AX210/AX1675 2x2 [Typhoon Peak] driver: iwlwifi
    v: kernel pcie: speed: 5 GT/s lanes: 1 bus-ID: 02:00.0 chip-ID: 8086:2725
    class-ID: 0280
  IF: wlp2s0 state: up mac: <filter>
Bluetooth:
  Device-1: Intel AX210 Bluetooth driver: btusb v: 0.8 type: USB rev: 2.0
    speed: 12 Mb/s lanes: 1 bus-ID: 1-7:3 chip-ID: 8087:0032 class-ID: e001
  Report: hciconfig ID: hci0 rfk-id: 0 state: up address: <filter> bt-v: 5.3
    lmp-v: 12 sub-v: 363c hci-v: 12 rev: 363c class-ID: 7c010c
RAID:
  Message: No RAID data found.
Drives:
  Local Storage: total: 465.76 GiB used: 16.92 GiB (3.6%)
  ID-1: /dev/nvme0n1 vendor: Western Digital model: WDS500G2B0C-00PXH0
    size: 465.76 GiB speed: 31.6 Gb/s lanes: 4 tech: SSD serial: <filter>
    fw-rev: 211070WD temp: 36.9 C scheme: GPT
Partition:
  ID-1: / size: 457.09 GiB used: 16.9 GiB (3.7%) fs: ext4 dev: /dev/nvme0n1p2
  ID-2: /boot/efi size: 299.4 MiB used: 17.4 MiB (5.8%) fs: vfat
    dev: /dev/nvme0n1p1
Swap:
  ID-1: swap-1 type: file size: 512 MiB used: 0 KiB (0.0%) priority: -2
    file: /swapfile
Sensors:
  System Temperatures: cpu: 46.0 C pch: 44.0 C mobo: N/A
  Fan Speeds (rpm): N/A
Repos:
  Packages: 2085 pm: dpkg pkgs: 2081 pm: snap pkgs: 4
  Active apt repos in: /etc/apt/sources.list
    1: deb http://archive.ubuntu.com/ubuntu/ noble main restricted universe multiverse
    2: deb http://security.ubuntu.com/ubuntu/ noble-security main restricted universe multiverse
    3: deb http://archive.ubuntu.com/ubuntu/ noble-updates main restricted universe multiverse
  No active apt repos in: /etc/apt/sources.list.d/neon.list
  Active apt repos in: /etc/apt/sources.list.d/neon.sources
    1: deb deb-src http://archive.neon.kde.org/user noble main
  Active apt repos in: /etc/apt/sources.list.d/org.kde.neon.packages.mozilla.org.sources
    1: deb https://packages.mozilla.org/apt mozilla main
  No active apt repos in: /etc/apt/sources.list.d/preinstalled-pool.sources
Info:
  Processes: 268 Power: uptime: 1h 19m states: freeze,mem,disk suspend: deep
    wakeups: 0 hibernate: platform Init: systemd v: 255 target: graphical (5)
    default: graphical
  Compilers: gcc: 13.3.0 Shell: Sudo (sudo) v: 1.9.15p5 default: Bash
    v: 5.2.21 running-in: konsole inxi: 3.3.34
```
