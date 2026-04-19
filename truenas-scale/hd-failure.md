# HD Management in TrueNAS

## Errors Identified

My raidz2 zpool has errors:
```
# zpool status
  pool: boot-pool
 state: ONLINE
status: One or more features are enabled on the pool despite not being
	requested by the 'compatibility' property.
action: Consider setting 'compatibility' to an appropriate value, or
	adding needed features to the relevant file in
	/etc/zfs/compatibility.d or /usr/share/zfs/compatibility.d.
  scan: scrub repaired 0B in 00:00:50 with 0 errors on Fri Mar 27 03:45:52 2026
config:

	NAME                                             STATE     READ WRITE CKSUM
	boot-pool                                        ONLINE       0     0     0
	  ata-SuperMicro_SSD_SMC0515D91120B964037-part2  ONLINE       0     0     0

errors: No known data errors

  pool: tank
 state: ONLINE
status: One or more devices has experienced an unrecoverable error.  An
	attempt was made to correct the error.  Applications are unaffected.
action: Determine if the device needs to be replaced, and clear the errors
	using 'zpool clear' or replace the device with 'zpool replace'.
   see: https://openzfs.github.io/openzfs-docs/msg/ZFS-8000-9P
  scan: scrub in progress since Sun Mar 29 09:07:17 2026
	4.23T / 20.2T scanned at 1.33G/s, 1.90T / 20.2T issued at 612M/s
	0B repaired, 9.42% done, 08:41:54 to go
config:

	NAME                                          STATE     READ WRITE CKSUM
	tank                                          ONLINE       0     0     0
	  raidz2-0                                    ONLINE       0     0     0
	    ata-ST6000VN001-2BB186_ZCT2WLTH           ONLINE       0     0     0
	    ata-WDC_WD60EFZX-68B3FN0_WD-C81G6HGK      ONLINE       0     0     0
	    ata-WDC_WD60EFZX-68B3FN0_WD-C81EX39K      ONLINE       0     0     0
	    ata-WDC_WD8003FFBX-68B9AN0_VR368JHK       ONLINE       0     0     0
	    ata-WDC_WD60EFRX-68MYMN1_WD-WX31DB48X2ZY  ONLINE       1     0     0

errors: No known data errors
```

Seems like `/dev/sda` has a history of errors:

```
oot@nass:~# smartctl -x /dev/sda|grep Error
Error logging capability:        (0x01)	Error logging supported.
					SCT Error Recovery Control supported.
  1 Raw_Read_Error_Rate     POSR-K   200   200   051    -    0
  7 Seek_Error_Rate         -OSR-K   200   200   000    -    0
199 UDMA_CRC_Error_Count    -O--CK   200   200   000    -    3
200 Multi_Zone_Error_Rate   ---R--   200   200   000    -    0
0x10       GPL     R/O      1  NCQ Command Error log
SMART Extended Comprehensive Error Log Version: 1 (6 sectors)
Device Error Count: 35 (device log contains only the most recent 24 errors)
	ER     = Error register
Error 35 [10] occurred at disk power-on lifetime: 3409 hours (142 days + 1 hours)
  40 -- 51 00 40 00 00 2c cd 57 a8 40 00  Error: UNC at LBA = 0x2ccd57a8 = 751654824
Error 34 [9] occurred at disk power-on lifetime: 64104 hours (2671 days + 0 hours)
  10 -- 51 00 40 00 01 7a 87 28 e8 40 00  Error: IDNF at LBA = 0x17a8728e8 = 6350645480
Error 33 [8] occurred at disk power-on lifetime: 57832 hours (2409 days + 16 hours)
  10 -- 51 00 40 00 02 b5 2e 80 18 40 00  Error: IDNF at LBA = 0x2b52e8018 = 11629658136
Error 32 [7] occurred at disk power-on lifetime: 57529 hours (2397 days + 1 hours)
  10 -- 51 00 40 00 01 1d 80 b3 78 40 00  Error: IDNF at LBA = 0x11d80b378 = 4789941112
Error 31 [6] occurred at disk power-on lifetime: 57307 hours (2387 days + 19 hours)
  10 -- 51 00 40 00 02 b5 50 1b 10 40 00  Error: IDNF at LBA = 0x2b5501b10 = 11631860496
Error 30 [5] occurred at disk power-on lifetime: 56039 hours (2334 days + 23 hours)
  10 -- 51 00 40 00 00 00 00 01 b0 40 00  Error: IDNF at LBA = 0x000001b0 = 432
Error 29 [4] occurred at disk power-on lifetime: 54935 hours (2288 days + 23 hours)
  10 -- 51 00 40 00 02 0e 18 66 10 40 00  Error: IDNF at LBA = 0x20e186610 = 8826414608
Error 28 [3] occurred at disk power-on lifetime: 54401 hours (2266 days + 17 hours)
  10 -- 51 00 40 00 01 f1 e6 3d b8 40 00  Error: IDNF at LBA = 0x1f1e63db8 = 8353365432
SCT Error Recovery Control:
```

According to [Common Hard Drive Error Codes and Diagnostics](https://www.datarecovery.net/articles/hard-drive-sector-damage.aspx):

* UNC - Uncorrectable Error
* IDNF - Sector ID Not Found. If the sector that holds this information is corrupt there is no way for the hard drive to locate this sector and it will return the result IDNF.

Compare the above to `/dev/sdb`:
```
root@nass:~# smartctl -x /dev/sdb|grep Error
Error logging capability:        (0x01)	Error logging supported.
					SCT Error Recovery Control supported.
  1 Raw_Read_Error_Rate     POSR--   100   064   006    -    0
  7 Seek_Error_Rate         POSR--   093   060   045    -    1966565051
184 End-to-End_Error        -O--CK   100   100   099    -    0
191 G-Sense_Error_Rate      -O--CK   100   100   000    -    3
199 UDMA_CRC_Error_Count    -OSRCK   200   200   000    -    0
0x10       GPL     R/O      1  NCQ Command Error log
SMART Extended Comprehensive Error Log Version: 1 (5 sectors)
No Errors Logged
SCT Error Recovery Control:
0x04  =====  =               =  ===  == General Errors Statistics (rev 1) ==
0x04  0x008  4               0  ---  Number of Reported Uncorrectable Errors
0x06  0x018  4               0  ---  Number of Interface CRC Errors
```

## Replace the HD using GUI

### Take it offline

Do it using GUI.  Shutdown the system, replace the HD

### Replace the HD in GUI

This results in:

```
alex@nass:~/ > zpool status tank
  pool: tank
 state: ONLINE
  scan: resilvered 3.68T in 08:17:36 with 0 errors on Mon Mar 30 04:16:00 2026
config:

	NAME                                      STATE     READ WRITE CKSUM
	tank                                      ONLINE       0     0     0
	  raidz2-0                                ONLINE       0     0     0
	    ata-ST6000VN001-2BB186_ZCT2WLTH       ONLINE       0     0     0
	    ata-WDC_WD60EFZX-68B3FN0_WD-C81G6HGK  ONLINE       0     0     0
	    ata-WDC_WD60EFZX-68B3FN0_WD-C81EX39K  ONLINE       0     0     0
	    ata-WDC_WD8003FFBX-68B9AN0_VR368JHK   ONLINE       0     0     0
	    3176c860-44e4-4b34-9591-674d2dd2203e  ONLINE       0     0     0

errors: No known data errors
```

Note the last disk is referred to by the GUID(?).  I'd rather for it to be referenced by the serial number!

## Replace the HD using CLI

Before:
```
alex@nass:~/ > zpool status tank
  pool: tank
 state: ONLINE
  scan: resilvered 3.68T in 08:17:36 with 0 errors on Mon Mar 30 04:16:00 2026
config:

	NAME                                      STATE     READ WRITE CKSUM
	tank                                      ONLINE       0     0     0
	  raidz2-0                                ONLINE       0     0     0
	    ata-ST6000VN001-2BB186_ZCT2WLTH       ONLINE       0     0     0
	    ata-WDC_WD60EFZX-68B3FN0_WD-C81G6HGK  ONLINE       0     0     0
	    ata-WDC_WD60EFZX-68B3FN0_WD-C81EX39K  ONLINE       0     0     0
	    ata-WDC_WD8003FFBX-68B9AN0_VR368JHK   ONLINE       0     0     0
	    3176c860-44e4-4b34-9591-674d2dd2203e  ONLINE       0     0     0

errors: No known data errors
```

Note the last disk is referred to by the GUID(?).  I'd rather for it to be referenced by the serial number.

### Take the HD offline

```sh
sudo zpool offline tank 3176c860-44e4-4b34-9591-674d2dd2203e
```

Verify it:
```
alex@nass:~/ > zpool status tank
  pool: tank
 state: DEGRADED
status: One or more devices has been taken offline by the administrator.
	Sufficient replicas exist for the pool to continue functioning in a
	degraded state.
action: Online the device using 'zpool online' or replace the device with
	'zpool replace'.
  scan: resilvered 3.68T in 08:17:36 with 0 errors on Mon Mar 30 04:16:00 2026
config:

	NAME                                      STATE     READ WRITE CKSUM
	tank                                      DEGRADED     0     0     0
	  raidz2-0                                DEGRADED     0     0     0
	    ata-ST6000VN001-2BB186_ZCT2WLTH       ONLINE       0     0     0
	    ata-WDC_WD60EFZX-68B3FN0_WD-C81G6HGK  ONLINE       0     0     0
	    ata-WDC_WD60EFZX-68B3FN0_WD-C81EX39K  ONLINE       0     0     0
	    ata-WDC_WD8003FFBX-68B9AN0_VR368JHK   ONLINE       0     0     0
	    3176c860-44e4-4b34-9591-674d2dd2203e  OFFLINE      0     0     0

errors: No known data errors
```

### Replace it

```sh
sudo zpool replace tank 3176c860-44e4-4b34-9591-674d2dd2203e /dev/disk/by-id/ata-WDC_WD8003FFBX-68B9AN0_VYH9LELM
```

Verify it:
```
alex@nass:~/ > zpool status tank
  pool: tank
 state: DEGRADED
status: One or more devices is currently being resilvered.  The pool will
	continue to function, possibly in a degraded state.
action: Wait for the resilver to complete.
  scan: resilver in progress since Mon Mar 30 17:48:32 2026
	7.84G / 18.4T scanned at 243M/s, 0B / 18.4T issued
	0B resilvered, 0.00% done, no estimated completion time
config:

	NAME                                        STATE     READ WRITE CKSUM
	tank                                        DEGRADED     0     0     0
	  raidz2-0                                  DEGRADED     0     0     0
	    ata-ST6000VN001-2BB186_ZCT2WLTH         ONLINE       0     0     0
	    ata-WDC_WD60EFZX-68B3FN0_WD-C81G6HGK    ONLINE       0     0     0
	    ata-WDC_WD60EFZX-68B3FN0_WD-C81EX39K    ONLINE       0     0     0
	    ata-WDC_WD8003FFBX-68B9AN0_VR368JHK     ONLINE       0     0     0
	    replacing-4                             DEGRADED     0     0     0
	      3176c860-44e4-4b34-9591-674d2dd2203e  OFFLINE      0     0     0
	      ata-WDC_WD8003FFBX-68B9AN0_VYH9LELM   ONLINE       0     0     0

errors: No known data errors
```
