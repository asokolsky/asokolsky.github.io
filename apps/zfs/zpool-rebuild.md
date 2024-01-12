## Rebuild the zpool

Referring to disk as `/dev/sdX` is a bad idea.
Better use serial number as in `/dev/disk/by-id/`:

```
root@nass[~]# lsblk -o NAME,SIZE,SERIAL,WWN,LABEL,FSTYPE
NAME    SIZE SERIAL               WWN                LABEL     FSTYPE
sda     5.5T WD-WX31DB48X2ZY      0x50014ee260e0f1d2 tank      zfs_member
sdb     7.3T VR368JHK             0x5000cca0c3ed20c4 tank      zfs_member
sdc     5.5T WD-C81EX39K          0x50014ee2beea769c tank      zfs_member
sdd     5.5T WD-C81G6HGK          0x50014ee2143f42b0 tank      zfs_member
sde     5.5T ZCT2WLTH             0x5000c500c6881e0b tank      zfs_member
sdf    29.5G SMC0515D91120B964037 0x515d91120b000037
├─sdf1  260M                      0x515d91120b000037           vfat
└─sdf2 29.2G                      0x515d91120b000037 boot-pool zfs_member
root@nass[~]# ll /dev/disk/by-id
total 0
drwxr-xr-x 2 root 360 Jan 18 11:31 ./
drwxr-xr-x 7 root 140 Jan 18 11:31 ../
lrwxrwxrwx 1 root   9 Jan 18 19:23 ata-ST6000VN001-2BB186_ZCT2WLTH -> ../../sde
lrwxrwxrwx 1 root   9 Jan 18 11:31 ata-SuperMicro_SSD_SMC0515D91120B964037 -> ../../sdf
lrwxrwxrwx 1 root  10 Jan 18 11:31 ata-SuperMicro_SSD_SMC0515D91120B964037-part1 -> ../../sdf1
lrwxrwxrwx 1 root  10 Jan 18 11:31 ata-SuperMicro_SSD_SMC0515D91120B964037-part2 -> ../../sdf2
lrwxrwxrwx 1 root   9 Jan 18 19:23 ata-WDC_WD60EFRX-68MYMN1_WD-WX31DB48X2ZY -> ../../sda
lrwxrwxrwx 1 root   9 Jan 18 19:23 ata-WDC_WD60EFZX-68B3FN0_WD-C81EX39K -> ../../sdc
lrwxrwxrwx 1 root   9 Jan 18 19:23 ata-WDC_WD60EFZX-68B3FN0_WD-C81G6HGK -> ../../sdd
lrwxrwxrwx 1 root   9 Jan 18 19:23 ata-WDC_WD8003FFBX-68B9AN0_VR368JHK -> ../../sdb
lrwxrwxrwx 1 root   9 Jan 18 19:23 wwn-0x5000c500c6881e0b -> ../../sde
lrwxrwxrwx 1 root   9 Jan 18 19:23 wwn-0x5000cca0c3ed20c4 -> ../../sdb
lrwxrwxrwx 1 root   9 Jan 18 19:23 wwn-0x50014ee2143f42b0 -> ../../sdd
lrwxrwxrwx 1 root   9 Jan 18 19:23 wwn-0x50014ee260e0f1d2 -> ../../sda
lrwxrwxrwx 1 root   9 Jan 18 19:23 wwn-0x50014ee2beea769c -> ../../sdc
lrwxrwxrwx 1 root   9 Jan 18 11:31 wwn-0x515d91120b000037 -> ../../sdf
lrwxrwxrwx 1 root  10 Jan 18 11:31 wwn-0x515d91120b000037-part1 -> ../../sdf1
lrwxrwxrwx 1 root  10 Jan 18 11:31 wwn-0x515d91120b000037-part2 -> ../../sdf2
```

Plan:

Export pool tank via TrueNAS GUI.

Then:
```
zpool import \
  -d /dev/disk/by-id/ata-WDC_WD60EFRX-68MYMN1_WD-WX31DB48X2ZY \
  -d /dev/disk/by-id/ata-WDC_WD8003FFBX-68B9AN0_VR368JHK \
  -d /dev/disk/by-id/ata-WDC_WD60EFZX-68B3FN0_WD-C81EX39K \
  -d /dev/disk/by-id/ata-WDC_WD60EFZX-68B3FN0_WD-C81G6HGK \
  -d /dev/disk/by-id/ata-ST6000VN001-2BB186_ZCT2WLTH \
  tank
```

Success!

Except TrueNAS GUI does not recognize the pool.  When imported via GUI the pool
is restored to using `sdX`.
[Bummer](https://www.truenas.com/community/threads/pool-import-cli-vs-gui.107131/).
