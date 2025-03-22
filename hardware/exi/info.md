# exi info

```
alex@exi > sudo inxi -FRmxxxrz
System:
  Kernel: 6.8.0-55-generic arch: x86_64 bits: 64 compiler: gcc v: 13.3.0
    clocksource: tsc
  Desktop: Cinnamon v: 6.4.8 tk: GTK v: 3.24.41 wm: Muffin v: 6.4.1
    dm: LightDM v: 1.30.0 Distro: Linux Mint 22.1 Xia base: Ubuntu 24.04 noble
Machine:
  Type: Desktop System: ASRock product: B760M Pro RS v: N/A serial: N/A
  Mobo: ASRock model: B760M Pro RS serial: <filter>
    uuid: 13006b9c-67db-0000-0000-000000000000 UEFI: American Megatrends LLC.
    v: 10.01 date: 09/30/2024
Battery:
  Device-1: hidpp_battery_1 model: Logitech M705 serial: <filter> charge: 55%
    rechargeable: yes status: discharging
Memory:
  System RAM: total: 64 GiB available: 62.51 GiB used: 9.17 GiB (14.7%)
  Array-1: capacity: 128 GiB slots: 4 modules: 4 EC: None
    max-module-size: 32 GiB note: est.
  Device-1: Controller0-ChannelA-DIMM0 type: DDR5 detail: synchronous
    size: 16 GiB speed: 5600 MT/s volts: 1.25 width (bits): data: 64 total: 64
    manufacturer: Micron Technology part-no: CP16G60C36U5B.M8D1
    serial: <filter>
  Device-2: Controller0-ChannelA-DIMM1 type: DDR5 detail: synchronous
    size: 16 GiB speed: 5600 MT/s volts: 1.25 width (bits): data: 64 total: 64
    manufacturer: Micron Technology part-no: CP16G60C36U5B.M8D1
    serial: <filter>
  Device-3: Controller1-ChannelA-DIMM0 type: DDR5 detail: synchronous
    size: 16 GiB speed: 5600 MT/s volts: 1.25 width (bits): data: 64 total: 64
    manufacturer: Micron Technology part-no: CP16G60C36U5B.M8D1
    serial: <filter>
  Device-4: Controller1-ChannelA-DIMM1 type: DDR5 detail: synchronous
    size: 16 GiB speed: 5600 MT/s volts: 1.25 width (bits): data: 64 total: 64
    manufacturer: Micron Technology part-no: CP16G60C36U5B.M8D1
    serial: <filter>
CPU:
  Info: 6-core model: 12th Gen Intel Core i5-12400F bits: 64 type: MT MCP
    smt: enabled arch: Alder Lake rev: 2 cache: L1: 480 KiB L2: 7.5 MiB
    L3: 18 MiB
  Speed (MHz): avg: 800 min/max: 800/4400 volts: 1.0 V ext-clock: 100 MHz
    cores: 1: 800 2: 800 3: 800 4: 800 5: 800 6: 800 7: 800 8: 800 9: 800
    10: 800 11: 800 12: 800 bogomips: 59904
  Flags: avx avx2 ht lm nx pae sse sse2 sse3 sse4_1 sse4_2 ssse3 vmx
Graphics:
  Device-1: NVIDIA GA106 [Geforce RTX 3050] vendor: Micro-Star MSI
    driver: nvidia v: 550.144.03 arch: Ampere ports: active: none off: HDMI-A-1
    empty: DP-1,DP-2,DP-3 bus-ID: 0000:01:00.0 chip-ID: 10de:2507
    class-ID: 0300
  Device-2: Sunplus Innovation UC40M Audio driver: snd-usb-audio,uvcvideo
    type: USB rev: 2.0 speed: 480 Mb/s lanes: 1 bus-ID: 1-2.2.2:21
    chip-ID: 1bcf:0b16 class-ID: 0102 serial: <filter>
  Display: x11 server: X.Org v: 21.1.11 with: Xwayland v: 23.2.6 driver: X:
    loaded: nouveau unloaded: fbdev,modesetting,vesa failed: nvidia
    gpu: nvidia,nvidia-nvswitch display-ID: :0 screens: 1
  Screen-1: 0 s-res: 3840x1600 s-dpi: 110 s-size: 887x373mm (34.92x14.69")
    s-diag: 962mm (37.88")
  Monitor-1: HDMI-0 res: 3840x1600 hz: 60 dpi: 111
    size: 879x366mm (34.61x14.41") diag: 952mm (37.49") modes: N/A
  API: EGL v: 1.5 hw: drv: nvidia platforms: device: 0 drv: nvidia device: 2
    drv: swrast surfaceless: drv: nvidia x11: drv: nvidia
    inactive: gbm,wayland,device-1
  API: OpenGL v: 4.6.0 compat-v: 4.5 vendor: nvidia mesa v: 550.144.03
    glx-v: 1.4 direct-render: yes renderer: NVIDIA GeForce RTX 3050/PCIe/SSE2
  API: Vulkan v: 1.3.275 layers: 4 surfaces: xcb,xlib device: 0
    type: discrete-gpu driver: N/A device-ID: 10de:2507 device: 1 type: cpu
    driver: N/A device-ID: 10005:0000
Audio:
  Device-1: Intel Raptor Lake High Definition Audio vendor: ASRock
    driver: snd_hda_intel v: kernel bus-ID: 0000:00:1f.3 chip-ID: 8086:7a50
    class-ID: 0403
  Device-2: NVIDIA GA106 High Definition Audio vendor: Micro-Star MSI
    driver: snd_hda_intel v: kernel bus-ID: 0000:01:00.1 chip-ID: 10de:228e
    class-ID: 0403
  Device-3: Sunplus Innovation UC40M Audio driver: snd-usb-audio,uvcvideo
    type: USB rev: 2.0 speed: 480 Mb/s lanes: 1 bus-ID: 1-2.2.2:21
    chip-ID: 1bcf:0b16 class-ID: 0102 serial: <filter>
  Device-4: GN Netcom Jabra EVOLVE 65 driver: jabra,snd-usb-audio,usbhid
    type: USB rev: 2.0 speed: 12 Mb/s lanes: 1 bus-ID: 1-6:19 chip-ID: 0b0e:030c
    class-ID: 0300 serial: <filter>
  API: ALSA v: k6.8.0-55-generic status: kernel-api
  Server-1: PipeWire v: 1.0.5 status: n/a (root, process) with:
    1: pipewire-pulse status: active 2: wireplumber status: active
    3: pipewire-alsa type: plugin
Network:
  Device-1: Intel Raptor Lake-S PCH CNVi WiFi driver: iwlwifi v: kernel
    bus-ID: 0000:00:14.3 chip-ID: 8086:7a70 class-ID: 0280
  IF: wlp0s20f3 state: down mac: <filter>
  Device-2: Realtek RTL8125 2.5GbE vendor: ASRock driver: r8169 v: kernel
    port: 3000 bus-ID: 0000:03:00.0 chip-ID: 10ec:8125 class-ID: 0200
  IF: enp3s0 state: up speed: 1000 Mbps duplex: full mac: <filter>
Bluetooth:
  Device-1: Intel AX201 Bluetooth driver: btusb v: 0.8 type: USB rev: 2.0
    speed: 12 Mb/s lanes: 1 bus-ID: 1-14:7 chip-ID: 8087:0026 class-ID: e001
  Report: hciconfig ID: hci0 rfk-id: 1 state: down
    bt-service: enabled,running rfk-block: hardware: no software: yes
    address: <filter>
RAID:
  Hardware-1: Intel Volume Management Device NVMe RAID Controller driver: vmd
    v: 0.6 port: N/A bus-ID: 0000:00:0e.0 chip-ID: 8086:467f rev: class-ID: 0104
Drives:
  Local Storage: total: 465.76 GiB used: 237.36 GiB (51.0%)
  ID-1: /dev/nvme0n1 vendor: Western Digital model: WDS500G2B0C-00PXH0
    size: 465.76 GiB speed: 31.6 Gb/s lanes: 4 tech: SSD serial: <filter>
    fw-rev: 211070WD temp: 39.9 C scheme: GPT
Partition:
  ID-1: / size: 456.89 GiB used: 237.36 GiB (52.0%) fs: ext4
    dev: /dev/nvme0n1p2
  ID-2: /boot/efi size: 511 MiB used: 6.1 MiB (1.2%) fs: vfat
    dev: /dev/nvme0n1p1
Swap:
  ID-1: swap-1 type: file size: 2 GiB used: 0 KiB (0.0%) priority: -2
    file: /swapfile
Sensors:
  System Temperatures: cpu: 16.0 C mobo: 31.0 C gpu: nvidia temp: 40 C
  Fan Speeds (rpm): fan-1: 994 fan-2: 563 fan-3: 0 fan-4: 0 fan-5: 0
    fan-6: 0 fan-7: 0 gpu: nvidia fan: 0%
Repos:
  Packages: 2539 pm: dpkg pkgs: 2529 pm: flatpak pkgs: 10
  No active apt repos in: /etc/apt/sources.list
  Active apt repos in: /etc/apt/sources.list.d/cuda-ubuntu2404-x86_64.list
    1: deb [signed-by=/usr/share/keyrings/cuda-archive-keyring.gpg] https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/ /
  No active apt repos in: /etc/apt/sources.list.d/drinstaller.list
  Active apt repos in: /etc/apt/sources.list.d/github-cli.list
    1: deb [arch=amd64 signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main
  Active apt repos in: /etc/apt/sources.list.d/malcscott-ppa-noble.list
    1: deb [signed-by=/etc/apt/keyrings/malcscott-ppa-noble.gpg] https://ppa.launchpadcontent.net/malcscott/ppa/ubuntu noble main
  Active apt repos in: /etc/apt/sources.list.d/official-package-repositories.list
    1: deb https://mirror.fcix.net/linuxmint-packages xia main upstream import backport
    2: deb http://mirror.math.ucdavis.edu/ubuntu noble main restricted universe multiverse
    3: deb http://mirror.math.ucdavis.edu/ubuntu noble-updates main restricted universe multiverse
    4: deb http://mirror.math.ucdavis.edu/ubuntu noble-backports main restricted universe multiverse
    5: deb http://security.ubuntu.com/ubuntu/ noble-security main restricted universe multiverse
  Active apt repos in: /etc/apt/sources.list.d/vscode.list
    1: deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/repos/code stable main
Info:
  Processes: 389 Power: uptime: 2d 4h 10m states: freeze,mem,disk
    suspend: deep wakeups: 0 hibernate: platform Init: systemd v: 255
    target: graphical (5) default: graphical
  Compilers: gcc: 13.3.0 Shell: Sudo (sudo) v: 1.9.15p5 default: Bash
    v: 5.2.21 running-in: code inxi: 3.3.34
 ```