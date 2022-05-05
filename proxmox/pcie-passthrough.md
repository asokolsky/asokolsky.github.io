# Proxmox PCIe Pass Through

Sources:

* [Pci_passthrough](https://pve.proxmox.com/wiki/Pci_passthrough)
* [guide_to_gpu_passthrough](https://www.reddit.com/r/homelab/comments/b5xpua/the_ultimate_beginners_guide_to_gpu_passthrough/)
* https://www.youtube.com/watch?reload=9&v=fgx3NMk6F54
* [how-to-pass-through-pcie-with-proxmox](https://www.servethehome.com/how-to-pass-through-pcie-nics-with-proxmox-ve-on-intel-and-amd/)

## Grub Kernel Boot Command Line

Edit /etc/default/grub:

```console
GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on iommu=pt"
```

Then:

```console
# update-grub
```

Reboot.
Verify IOMMU enabled:

```console
root@fuji:~# dmesg | grep -e DMAR -e IOMMU
[    0.008035] ACPI: DMAR 0x0000000087ACAD28 000070 (v01 INTEL  SKL      00000001 INTL 00000001)
[    0.019700] DMAR: IOMMU enabled
[    0.048702] DMAR: Host address width 39
[    0.048703] DMAR: DRHD base: 0x000000fed90000 flags: 0x1
[    0.048706] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.048707] DMAR: RMRR base: 0x00000087813000 end: 0x00000087832fff
[    0.048709] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed90000 IOMMU 0
[    0.048709] DMAR-IR: HPET id 0 under DRHD base 0xfed90000
[    0.048710] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.050125] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.653713] DMAR: No ATSR found
[    0.653745] DMAR: dmar0: Using Queued invalidation
[    0.655720] DMAR: Intel(R) Virtualization Technology for Directed I/O
```

## VFIO Modules

Edit /etc/modules:
```sh
# /etc/modules: kernel modules to load at boot time.
#
# This file contains the names of kernel modules that should be loaded
# at boot time, one per line. Lines beginning with "#" are ignored.
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
```

Reboot.  Then:

```console
root@fuji:~# lsmod|grep vfio
vfio_pci               53248  0
vfio_virqfd            16384  1 vfio_pci
irqbypass              16384  2 vfio_pci,kvm
vfio_iommu_type1       32768  0
vfio                   32768  2 vfio_iommu_type1,vfio_pci
```
## IOMMU Interrupt Remapping

Verify remapping is enabled:

```console
root@fuji:~# dmesg | grep 'remapping'
[    0.048727] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.050142] DMAR-IR: Enabled IRQ remapping in x2apic mode
```

List PCI devices:
```console
root@fuji:~# lspci
00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers (rev 05)
00:01.0 PCI bridge: Intel Corporation Skylake PCIe Controller (x16) (rev 05)
00:14.0 USB controller: Intel Corporation Sunrise Point-H USB 3.0 xHCI Controller (rev 31)
00:14.2 Signal processing controller: Intel Corporation Sunrise Point-H Thermal subsystem (rev 31)
00:16.0 Communication controller: Intel Corporation Sunrise Point-H CSME HECI #1 (rev 31)
00:16.1 Communication controller: Intel Corporation Sunrise Point-H CSME HECI #2 (rev 31)
00:17.0 SATA controller: Intel Corporation Sunrise Point-H SATA controller [AHCI mode] (rev 31)
00:1c.0 PCI bridge: Intel Corporation Sunrise Point-H PCI Express Root Port #5 (rev f1)
00:1c.5 PCI bridge: Intel Corporation Sunrise Point-H PCI Express Root Port #6 (rev f1)
00:1c.6 PCI bridge: Intel Corporation Sunrise Point-H PCI Express Root Port #7 (rev f1)
00:1d.0 PCI bridge: Intel Corporation Sunrise Point-H PCI Express Root Port #9 (rev f1)
00:1f.0 ISA bridge: Intel Corporation Sunrise Point-H LPC Controller (rev 31)
00:1f.2 Memory controller: Intel Corporation Sunrise Point-H PMC (rev 31)
00:1f.4 SMBus: Intel Corporation Sunrise Point-H SMBus (rev 31)
01:00.0 Non-Volatile memory controller: Phison Electronics Corporation E12 NVMe Controller (rev 01)
02:00.0 VGA compatible controller: Matrox Electronics Systems Ltd. MGA G200e [Pilot] ServerEngines (SEP1) (rev 05)
02:00.1 Co-processor: Emulex Corporation ServerView iRMC HTI
03:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network Connection (rev 03)
04:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network Connection (rev 03)
05:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network Connection (rev 01)
05:00.1 Ethernet controller: Intel Corporation I350 Gigabit Network Connection (rev 01)
```

After VGA install and on another PC:
```console
root@duo:~# lspci
00:00.0 Host bridge: Intel Corporation 8th Gen Core Processor Host Bridge/DRAM Registers (rev 07)
00:01.0 PCI bridge: Intel Corporation Skylake PCIe Controller (x16) (rev 07)
00:02.0 Display controller: Intel Corporation UHD Graphics 630 (Desktop)
00:14.0 USB controller: Intel Corporation 200 Series/Z370 Chipset Family USB 3.0 xHCI Controller
00:14.2 Signal processing controller: Intel Corporation 200 Series PCH Thermal Subsystem
00:16.0 Communication controller: Intel Corporation 200 Series PCH CSME HECI
00:17.0 SATA controller: Intel Corporation 200 Series PCH SATA controller [AHCI mode]
00:1c.0 PCI bridge: Intel Corporation 200 Series PCH PCI Express Root Port (rev f0)
00:1c.5 PCI bridge: Intel Corporation 200 Series PCH PCI Express Root Port (rev f0)
00:1d.0 PCI bridge: Intel Corporation 200 Series PCH PCI Express Root Port (rev f0)
00:1f.0 ISA bridge: Intel Corporation Z370 Chipset LPC/eSPI Controller
00:1f.2 Memory controller: Intel Corporation 200 Series/Z370 Chipset Family Power Management Controller
00:1f.3 Audio device: Intel Corporation 200 Series PCH HD Audio
00:1f.4 SMBus: Intel Corporation 200 Series/Z370 Chipset Family SMBus Controller
00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (2) I219-V
01:00.0 VGA compatible controller: NVIDIA Corporation GP108 (rev a1)
01:00.1 Audio device: NVIDIA Corporation GP108 High Definition Audio Controller (rev a1)
03:00.0 Ethernet controller: Intel Corporation I211 Gigabit Network Connection (rev 03)
04:00.0 Non-Volatile memory controller: Sandisk Corp Device 5009 (rev 01)
root@duo:~# lspci -n -s 01:00
01:00.0 0300: 10de:1d01 (rev a1)
01:00.1 0403: 10de:0fb8 (rev a1)
```

The latter is important.


## Blacklist Drivers

Prevent host from using GT710:
```sh
echo "blacklist radeon" >> /etc/modprobe.d/blacklist.conf
echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
echo "blacklist nvidia" >> /etc/modprobe.d/blacklist.conf
```

reboot

# Add GPU to VFIO

Note that GT710 (pci device 05:00:0x) has a dedicated iommu group:

```console
root@fuji:~# find /sys/kernel/iommu_groups/ -type l
/sys/kernel/iommu_groups/7/devices/0000:00:1c.6
/sys/kernel/iommu_groups/5/devices/0000:00:1c.0
/sys/kernel/iommu_groups/13/devices/0000:05:00.1
/sys/kernel/iommu_groups/13/devices/0000:05:00.0
/sys/kernel/iommu_groups/3/devices/0000:00:16.0
/sys/kernel/iommu_groups/3/devices/0000:00:16.1
/sys/kernel/iommu_groups/11/devices/0000:03:00.0
/sys/kernel/iommu_groups/1/devices/0000:00:01.0
/sys/kernel/iommu_groups/1/devices/0000:01:00.0
/sys/kernel/iommu_groups/8/devices/0000:00:1c.7
/sys/kernel/iommu_groups/6/devices/0000:00:1c.5
/sys/kernel/iommu_groups/4/devices/0000:00:17.0
/sys/kernel/iommu_groups/12/devices/0000:04:00.0
/sys/kernel/iommu_groups/2/devices/0000:00:14.2
/sys/kernel/iommu_groups/2/devices/0000:00:14.0
/sys/kernel/iommu_groups/10/devices/0000:02:00.0
/sys/kernel/iommu_groups/10/devices/0000:02:00.1
/sys/kernel/iommu_groups/0/devices/0000:00:00.0
/sys/kernel/iommu_groups/9/devices/0000:00:1f.2
/sys/kernel/iommu_groups/9/devices/0000:00:1f.0
/sys/kernel/iommu_groups/9/devices/0000:00:1f.4
```

Use vendor ids for the GPU determined before:

```console
root@duo:~# lspci -n -s 01:00
01:00.0 0300: 10de:1d01 (rev a1)
01:00.1 0403: 10de:0fb8 (rev a1)
root@duo:~# cat /etc/modprobe.d/vfio.conf
cat: /etc/modprobe.d/vfio.conf: No such file or directory
root@duo:~# echo "options vfio-pci ids=10de:1d01,10de:0fb8" > /etc/modprobe.d/vfio.conf
root@duo:~# cat /etc/modprobe.d/vfio.conf
options vfio-pci ids=10de:1d01,10de:0fb8
```

# VM Configuration

Edit VM Hardware - set:

* BIOS: OVMF;
* Display: default
* Machine: q35;
* Add EFI disk;

Then add PCIe GPU - no need to add a separate PCIe device for audio, just choose all functions:

* select GT710,
* check allfunctions (this will also result in the HDMI audio being passed through)
* check primary VGA, PCIe;



Once GPU passthrough is configures, proxmox console (novnc) stops functioning.
You need to passthrough keyboard/mouse to the guest:
https://pve.proxmox.com/wiki/USB_physical_port_mapping

```console
root@duo:~# qm show 400 --pretty
/usr/bin/kvm \
  -id 400 \
  -name htpc \
  -no-shutdown \
  -chardev 'socket,id=qmp,path=/var/run/qemu-server/400.qmp,server,nowait' \
  -mon 'chardev=qmp,mode=control' \
  -chardev 'socket,id=qmp-event,path=/var/run/qmeventd.sock,reconnect=5' \
  -mon 'chardev=qmp-event,mode=control' \
  -pidfile /var/run/qemu-server/400.pid \
  -daemonize \
  -smbios 'type=1,uuid=b4758fe0-99b5-4c8a-b371-545a4c550732' \
  -drive 'if=pflash,unit=0,format=raw,readonly,file=/usr/share/pve-edk2-firmware//OVMF_CODE.fd' \
  -drive 'if=pflash,unit=1,format=raw,id=drive-efidisk0,size=131072,file=/dev/pve/vm-400-disk-1' \
  -smp '4,sockets=1,cores=4,maxcpus=4' \
  -nodefaults \
  -boot 'menu=on,strict=on,reboot-timeout=1000,splash=/usr/share/qemu-server/bootsplash.jpg' \
  -vga none \
  -nographic \
  -cpu 'kvm64,enforce,kvm=off,+kvm_pv_eoi,+kvm_pv_unhalt,+lahf_lm,+sep' \
  -m 8192 \
  -readconfig /usr/share/qemu-server/pve-q35-4.0.cfg \
  -device 'vmgenid,guid=859afcf5-a35b-4243-acec-1b3cb4da03c1' \
  -device 'usb-tablet,id=tablet,bus=ehci.0,port=1' \
  -device 'vfio-pci,host=0000:01:00.0,id=hostpci0.0,bus=ich9-pcie-port-1,addr=0x0.0,multifunction=on' \
  -device 'vfio-pci,host=0000:01:00.1,id=hostpci0.1,bus=ich9-pcie-port-1,addr=0x0.1' \
  -device 'usb-host,hostbus=1,hostport=1,id=usb0' \
  -device 'usb-host,hostbus=1,hostport=2,id=usb1' \
  -device 'virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x3' \
  -iscsi 'initiator-name=iqn.1993-08.org.debian:01:54856bfc519d' \
  -drive 'if=none,id=drive-ide2,media=cdrom,aio=threads' \
  -device 'ide-cd,bus=ide.1,unit=0,drive=drive-ide2,id=ide2,bootindex=101' \
  -device 'virtio-scsi-pci,id=scsihw0,bus=pci.0,addr=0x5' \
  -drive 'file=/dev/pve/vm-400-disk-0,if=none,id=drive-scsi0,format=raw,cache=none,aio=native,detect-zeroes=on' \
  -device 'scsi-hd,bus=scsihw0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0,id=scsi0,rotation_rate=1,bootindex=100' \
  -netdev 'type=tap,id=net0,ifname=tap400i0,script=/var/lib/qemu-server/pve-bridge,downscript=/var/lib/qemu-server/pve-bridgedown,vhost=on' \
  -device 'virtio-net-pci,mac=36:E7:45:23:9E:0D,netdev=net0,bus=pci.0,addr=0x12,id=net0,bootindex=102' \
  -machine 'type=q35+pve0'
root@duo:~# qm monitor 400
Entering Qemu Monitor for VM 400 - type 'help' for help
qm> info pci
```

### Guest Problems with HDMI Audio

After NVIDIA driver install HDMI Audio was not appearing in the Settings/Sounds.
This solved it:
```console
pulseaudio -k
```
https://forum.proxmox.com/threads/gpu-passthrough-hdmi-audio.55740/

After that (and before NVIDIA driver install) - crackling/broken as in
https://pve.proxmox.com/wiki/Pci_passthrough#HDMI_Audio_crackling.2Fbroken
