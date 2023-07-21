# LSI HBA Firmware upgrade

I have the following HBA: LSI SAS 9300-8i 8-port 12Gb/s SATA+SAS PCIe 3.0,
2x SFF-8643 mini-SAS, 13W.

Must read:
[lsi9300 firmware update](https://www.truenas.com/community/resources/lsi-9300-xx-firmware-update.145/)

[Guide to cross-flashing](https://www.truenas.com/community/resources/detailed-newcomers-guide-to-crossflashing-lsi-9211-9300-9305-9311-9400-94xx-hba-and-variants.54/)

https://techmattr.wordpress.com/2016/04/11/updated-sas-hba-crossflashing-or-flashing-to-it-mode-dell-perc-h200-and-h310/

https://forums.servethehome.com/index.php?threads/lsi-raid-controller-and-hba-complete-listing-plus-oem-models.599/

[Upgrading LSI HBA 9300-8i via UEFI (Phase 06)](https://www.bussink.ch/?p=1489)

Given that I do not plan to boot from the attached device, my plan is to wipe
the ROM clean and install the latest firmware.

## Prepare the USB stick

It must be formatted as FAT16 or FAT32.

[flashing-firmware-and-bios-on-lsi-sas-hbas](https://www.broadcom.com/support/knowledgebase/1211161501344/flashing-firmware-and-bios-on-lsi-sas-hbas)
contains the firmware updater `sas3flash.efi`.

The `SAS3_UEFI_BSD_P6` contains the BIOS for the updater `X64SAS3.ROM`.

The `9300_8i_Package_P6_IR_IT_firmware_BIOS_for_MSDOS_Windows` contains the
`SAS9300_8i_IT.bin` firmware and the `MPTSAS3.ROM` bios.

Firmware version: 16.00.12.00

## Boot into UEFI shell

[uefi shell and commands](https://linuxhint.com/use-uefi-interactive-shell-and-its-common-commands/)

Press F12?

## Firmware upgrade

`fs1:`

`dir`

`sas3flash.efi -list`

Perform preliminary flash of the firmware:
`sas3flash.efi -noreset -f SAS9300_8i_IT.bin`

Once you receive a confirmation that the flash was successful, reboot.

Wipe the card: `sas3flash.efi -o -e 6`

Flash the firmware: `sas3flash.efi -f SAS9300_8i_IT.bin`
