# Suprox Block Devices

Given that the on-board SATA controller is passed through to NAS VM, only the NVME device is visible:

```
root@suprox:~# lsblk
NAME                         MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
nvme0n1                      259:0    0 465.8G  0 disk
├─nvme0n1p1                  259:1    0  1007K  0 part
├─nvme0n1p2                  259:2    0   512M  0 part /boot/efi
└─nvme0n1p3                  259:3    0 465.3G  0 part
  ├─pve-swap                 252:0    0     8G  0 lvm  [SWAP]
  ├─pve-root                 252:1    0    96G  0 lvm  /
  ├─pve-data_tmeta           252:2    0   3.5G  0 lvm
  │ └─pve-data-tpool         252:4    0 338.4G  0 lvm
  │   ├─pve-data             252:5    0 338.4G  1 lvm
  │   ├─pve-vm--100--disk--0 252:6    0    32G  0 lvm
  │   ├─pve-vm--101--disk--0 252:7    0    32G  0 lvm
  │   ├─pve-vm--102--disk--0 252:8    0     8G  0 lvm
  │   ├─pve-vm--103--disk--0 252:9    0    32G  0 lvm
  │   ├─pve-vm--104--disk--0 252:10   0     8G  0 lvm
  │   ├─pve-vm--105--disk--0 252:11   0     2G  0 lvm
  │   ├─pve-vm--106--disk--0 252:12   0     4M  0 lvm
  │   ├─pve-vm--106--disk--1 252:13   0    32G  0 lvm
  │   ├─pve-vm--107--disk--0 252:14   0     8G  0 lvm
  │   ├─pve-vm--108--disk--0 252:15   0    32G  0 lvm
  │   └─pve-vm--109--disk--0 252:16   0    16G  0 lvm
  └─pve-data_tdata           252:3    0 338.4G  0 lvm
    └─pve-data-tpool         252:4    0 338.4G  0 lvm
      ├─pve-data             252:5    0 338.4G  1 lvm
      ├─pve-vm--100--disk--0 252:6    0    32G  0 lvm
      ├─pve-vm--101--disk--0 252:7    0    32G  0 lvm
      ├─pve-vm--102--disk--0 252:8    0     8G  0 lvm
      ├─pve-vm--103--disk--0 252:9    0    32G  0 lvm
      ├─pve-vm--104--disk--0 252:10   0     8G  0 lvm
      ├─pve-vm--105--disk--0 252:11   0     2G  0 lvm
      ├─pve-vm--106--disk--0 252:12   0     4M  0 lvm
      ├─pve-vm--106--disk--1 252:13   0    32G  0 lvm
      ├─pve-vm--107--disk--0 252:14   0     8G  0 lvm
      ├─pve-vm--108--disk--0 252:15   0    32G  0 lvm
      └─pve-vm--109--disk--0 252:16   0    16G  0 lvm
```