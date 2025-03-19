```
root@fuji:~# inxi -FRmxxxrz
System:
  Kernel: 6.8.12-8-pve arch: x86_64 bits: 64 compiler: gcc v: 12.2.0 Console: pty pts/2
    Distro: Debian GNU/Linux 12 (bookworm)
Machine:
  Type: Server System: FUJITSU product: PRIMERGY TX1320 M3 v: N/A serial: <filter> Chassis:
    type: 17 v: TX1320M3F1 serial: <filter>
  Mobo: FUJITSU model: D3373-B1 v: S26361-D3373-B12 WGS03 GS02 serial: <filter> UEFI: FUJITSU
    // American Megatrends v: 5.0.0.11 R1.37.0 for D3373-B1x date: 10/20/2023
Memory:
  RAM: total: 62.67 GiB used: 33.52 GiB (53.5%)
  Array-1: capacity: 64 GiB slots: 4 EC: Single-bit ECC max-module-size: 16 GiB note: est.
  Device-1: DIMM CHA3 type: DDR4 detail: synchronous size: 16 GiB speed: spec: 2667 MT/s
    actual: 2400 MT/s volts: 1.2 width (bits): data: 64 total: 72 manufacturer: Micron Technology
    part-no: 18ASF2G72AZ-2G6D1 serial: <filter>
  Device-2: DIMM CHA1 type: DDR4 detail: synchronous size: 16 GiB speed: spec: 2667 MT/s
    actual: 2400 MT/s volts: 1.2 width (bits): data: 64 total: 72 manufacturer: Micron Technology
    part-no: 18ASF2G72AZ-2G6E2 serial: <filter>
  Device-3: DIMM CHB4 type: DDR4 detail: synchronous size: 16 GiB speed: spec: 2667 MT/s
    actual: 2400 MT/s volts: 1.2 width (bits): data: 64 total: 72 manufacturer: Micron Technology
    part-no: 18ASF2G72AZ-2G6D1 serial: <filter>
  Device-4: DIMM CHB2 type: DDR4 detail: synchronous size: 16 GiB speed: spec: 2667 MT/s
    actual: 2400 MT/s volts: 1.2 width (bits): data: 64 total: 72 manufacturer: Micron Technology
    part-no: 18ASF2G72AZ-2G6E2 serial: <filter>
CPU:
  Info: quad core model: Intel Xeon E3-1230 v6 bits: 64 type: MT MCP smt: enabled arch: Kaby Lake
    rev: 9 cache: L1: 256 KiB L2: 1024 KiB L3: 8 MiB
  Speed (MHz): avg: 1413 high: 2573 min/max: 800/3900 volts: 1.0 V ext-clock: 100 MHz cores:
    1: 800 2: 2573 3: 2169 4: 800 5: 800 6: 1666 7: 1700 8: 800 bogomips: 55998
  Flags: avx avx2 ht lm nx pae sse sse2 sse3 sse4_1 sse4_2 ssse3 vmx
Graphics:
  Device-1: Matrox Systems MGA G200e [Pilot] ServerEngines vendor: Fujitsu Solutions
    driver: mgag200 v: kernel pcie: speed: 2.5 GT/s lanes: 1 ports: active: VGA-1 empty: none
    bus-ID: 02:00.0 chip-ID: 102b:0522 class-ID: 0300
  Display: server: No display server data found. Headless machine? tty: 155x81
  Monitor-1: VGA-1 size-res: N/A in console modes: max: 1024x768 min: 640x480
  API: OpenGL Message: GL data unavailable in console for root.
Audio:
  Message: No device data found.
Network:
  Device-1: Intel I210 Gigabit Network vendor: Fujitsu Solutions driver: igb v: kernel pcie:
    speed: 2.5 GT/s lanes: 1 port: e000 bus-ID: 03:00.0 chip-ID: 8086:1533 class-ID: 0200
  IF: eno1 state: up speed: 1000 Mbps duplex: full mac: <filter>
  Device-2: Intel I210 Gigabit Network vendor: Fujitsu Solutions driver: vfio-pci v: N/A pcie:
    speed: 2.5 GT/s lanes: 1 port: d000 bus-ID: 04:00.0 chip-ID: 8086:1533 class-ID: 0200
  Device-3: Intel I350 Gigabit Network driver: vfio-pci v: N/A pcie: speed: 5 GT/s lanes: 4
    port: N/A bus-ID: 05:00.0 chip-ID: 8086:1521 class-ID: 0200
  Device-4: Intel I350 Gigabit Network driver: vfio-pci v: N/A pcie: speed: 5 GT/s lanes: 4
    port: N/A bus-ID: 05:00.1 chip-ID: 8086:1521 class-ID: 0200
  IF-ID-1: bonding_masters state: N/A speed: N/A duplex: N/A mac: N/A
  IF-ID-2: docker0 state: up speed: 10000 Mbps duplex: unknown mac: <filter>
  IF-ID-3: fwbr1005i0 state: up speed: 10000 Mbps duplex: unknown mac: <filter>
  IF-ID-4: fwln1005i0 state: up speed: 10000 Mbps duplex: full mac: <filter>
  IF-ID-5: fwpr1005p0 state: up speed: 10000 Mbps duplex: full mac: <filter>
  IF-ID-6: tap104i0 state: unknown speed: 10000 Mbps duplex: full mac: <filter>
  IF-ID-7: veth1003i0 state: up speed: 10000 Mbps duplex: full mac: <filter>
  IF-ID-8: veth1004i0 state: up speed: 10000 Mbps duplex: full mac: <filter>
  IF-ID-9: veth1005i0 state: up speed: 10000 Mbps duplex: full mac: <filter>
  IF-ID-10: veth68f980a state: up speed: 10000 Mbps duplex: full mac: <filter>
  IF-ID-11: vmbr0 state: up speed: 10000 Mbps duplex: unknown mac: <filter>
RAID:
  Message: No RAID data found.
Drives:
  Local Storage: total: 238.47 GiB lvm-free: 16 GiB used: 38.56 GiB (16.2%)
  ID-1: /dev/nvme0n1 vendor: Sabrent model: N/A size: 238.47 GiB speed: 31.6 Gb/s lanes: 4
    type: SSD serial: <filter> rev: RKT343.1 temp: 28.9 C scheme: GPT
Partition:
  ID-1: / size: 58.02 GiB used: 38.54 GiB (66.4%) fs: ext4 dev: /dev/dm-1 mapped: pve-root
  ID-2: /boot/efi size: 511 MiB used: 328 KiB (0.1%) fs: vfat dev: /dev/nvme0n1p2
Swap:
  ID-1: swap-1 type: partition size: 4 GiB used: 16.2 MiB (0.4%) priority: -2 dev: /dev/dm-0
    mapped: pve-swap
Sensors:
  Src: ipmi System Temperatures: cpu: 43 C mobo: 33 C ambient: 23 C
  Fan Speeds (RPM): fan-1: 1260 fan-2: 1020 psu: 800
  Power: 12v: 11.940 5v: 5.150 3.3v: 3.345 vbat: 3.000 dimm-p1: N/A dimm-p2: N/A
  Src: lm-sensors System Temperatures: cpu: 34.0 C pch: 59.5 C mobo: N/A
  Fan Speeds (RPM): N/A
Repos:
  Packages: pm: dpkg pkgs: 1077
  Active apt repos in: /etc/apt/sources.list
    1: deb http://ftp.us.debian.org/debian bookworm main contrib
    2: deb http://ftp.us.debian.org/debian bookworm-updates main contrib
    3: deb http://security.debian.org bookworm-security main contrib
    4: deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription
  Active apt repos in: /etc/apt/sources.list.d/docker.list
    1: deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable
  No active apt repos in: /etc/apt/sources.list.d/nodesource.list
  No active apt repos in: /etc/apt/sources.list.d/pve-enterprise.list
  No active apt repos in: /etc/apt/sources.list.d/pve-install-repo.list
  Active apt repos in: /etc/apt/sources.list.d/runner_gitlab-runner.list
    1: deb [signed-by=/usr/share/keyrings/runner_gitlab-runner-archive-keyring.gpg] https://packages.gitlab.com/runner/gitlab-runner/debian/ bookworm main
    2: deb-src [signed-by=/usr/share/keyrings/runner_gitlab-runner-archive-keyring.gpg] https://packages.gitlab.com/runner/gitlab-runner/debian/ bookworm main
Info:
  Processes: 312 Uptime: 10h 2m wakeups: 2 Init: systemd v: 252 target: graphical (5)
  default: graphical Compilers: gcc: 12.2.0 alt: 10/12 Shell: Sudo (sudo) v: 1.9.13p3
  default: Bash v: 5.2.15 running-in: pty pts/2 inxi: 3.3.26
```
