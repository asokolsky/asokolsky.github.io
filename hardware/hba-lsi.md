# LSI HBA Firmware upgrade

I have the following HBA: LSI SAS 9300-8i 8-port 12Gb/s SATA+SAS PCIe 3.0,
2x SFF-8643 mini-SAS, 13W.

Must read:
[lsi9300 firmware 16.00.12.00 update](https://www.truenas.com/community/resources/lsi-9300-xx-firmware-update.145/)

[Guide to cross-flashing](https://www.truenas.com/community/resources/detailed-newcomers-guide-to-crossflashing-lsi-9211-9300-9305-9311-9400-94xx-hba-and-variants.54/)

[sas-hba-crossflashing-or-flashing-to-it-mode](https://techmattr.wordpress.com/2016/04/11/updated-sas-hba-crossflashing-or-flashing-to-it-mode-dell-perc-h200-and-h310/)

[controller-listing](https://forums.servethehome.com/index.php?threads/lsi-raid-controller-and-hba-complete-listing-plus-oem-models.599/)

[Upgrading LSI HBA 9300-8i via UEFI (Phase 06)](https://www.bussink.ch/?p=1489)

## Plan

Given that I will boot from the NVME device (NOT the device attached to the HBA),
I will:

* wipe the ROM/BIOS clean and
* install the latest firmware.

## Prepare the UEFI USB stick

It must be [formatted](/linux/cli-disk-format.html) as FAT16 or FAT32.

[flashing-firmware-and-bios-on-lsi-sas-hbas](https://www.broadcom.com/support/knowledgebase/1211161501344/flashing-firmware-and-bios-on-lsi-sas-hbas)
contains the firmware updater `sas3flash.efi`.

The `SAS3_UEFI_BSD_P6` contains the BIOS for the updater `X64SAS3.ROM` - ignore
it.

The `9300_8i_Package_P6_IR_IT_firmware_BIOS_for_MSDOS_Windows` contains the
`SAS9300_8i_IT.bin` firmware (you weill use it) and the `MPTSAS3.ROM` bios
(ignore it).

Firmware version: 16.00.12.00

I also had to search for a `Shell.efi` and copied it on the stick - in the root
and `/efi/boot`.

## Boot into UEFI shell

[uefi shell and commands](https://linuxhint.com/use-uefi-interactive-shell-and-its-common-commands/)

Press F12 to get the boot prompt.

## Firmware upgrade

In the motherboard BIOS I chose to disable the CSM -
[compatibility support mode](http://www.rodsbooks.com/efi-bootloaders/csm-good-bad-ugly.html)
- this reduces the number of boot options available to UEFI only.

I had to look for an option to `invoke the UEFI shell` and worked only when I
plugged USB stick into a front USB socket.

Commands I used:

```
map
fs0:
sas3flash.efi -list
sas3flash.efi -o -e 6
sas3flash.efi -f SAS9300_8i_IT.bin
```
