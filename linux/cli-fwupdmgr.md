# fwupd client tool

[fwupdmgr](https://manpages.ubuntu.com/manpages/jammy/man1/fwupdmgr.1.html)
allows an administrator to update firmware:

```
alex@latitude7490:~/ > fwupdmgr --help
Usage:
  fwupdmgr [OPTION…]

  activate [DEVICE-ID|GUID]         Activate devices
  block-firmware [CHECKSUM]         Blocks a specific firmware from being installed
  clear-results DEVICE-ID|GUID      Clears the results from the last update
  device-test [FILENAME1] [FILENAME2]
                                    Test a device using a JSON manifest
  disable-remote REMOTE-ID          Disables a given remote
  downgrade [DEVICE-ID|GUID]        Downgrades the firmware on a device
  download LOCATION                 Download a file
  enable-remote REMOTE-ID           Enables a given remote
  get-approved-firmware             Gets the list of approved firmware
  get-blocked-firmware              Gets the list of blocked firmware
  get-details FILE                  Gets details about a firmware file
  get-devices                       Get all devices that support firmware updates
  get-history                       Show history of firmware updates
  get-plugins                       Get all enabled plugins registered with the system
  get-releases [DEVICE-ID|GUID]     Gets the releases for a device
  get-remotes                       Gets the configured remotes
  get-results DEVICE-ID|GUID        Gets the results from the last update
  get-topology                      Alias to get-devices
  get-updates [DEVICE-ID|GUID]      Gets the list of updates for connected hardware
  get-upgrades [DEVICE-ID|GUID]     Alias to get-updates
  install FILE [DEVICE-ID|GUID]     Install a firmware file on this hardware
  modify-config KEY,VALUE           Modifies a daemon configuration value
  modify-remote REMOTE-ID KEY VALUE
                                    Modifies a given remote
  refresh [FILE FILE_SIG REMOTE-ID]
                                    Refresh metadata from remote server
  reinstall [DEVICE-ID|GUID]        Reinstall current firmware on the device
  report-history                    Share firmware history with the developers
  security                          Gets the host security attributes
  set-approved-firmware FILENAME|CHECKSUM1[,CHECKSUM2][,CHECKSUM3]
                                    Sets the list of approved firmware
  switch-branch [DEVICE-ID|GUID] [BRANCH]
                                    Switch the firmware branch on the device
  sync-bkc                          Sync firmware versions to the host best known configuration
  unblock-firmware [CHECKSUM]       Unblocks a specific firmware from being installed
  unlock DEVICE-ID|GUID             Unlocks the device for firmware access
  update [DEVICE-ID|GUID]           Updates all specified devices to latest firmware version, or all devices if unspecified
  upgrade [DEVICE-ID|GUID]          Alias to update
  verify [DEVICE-ID|GUID]           Checks cryptographic hash matches firmware
  verify-update [DEVICE-ID|GUID]    Update the stored cryptographic hash with current ROM contents

Help Options:
  -h, --help                Show help options

Application Options:
  -v, --verbose             Show extra debugging information
  --version                 Show client and daemon versions
  --offline                 Schedule installation for next reboot when possible
  --allow-reinstall         Allow reinstalling existing firmware versions
  --allow-older             Allow downgrading firmware versions
  --allow-branch-switch     Allow switching firmware branch
  --force                   Force the action by relaxing some runtime checks
  -y, --assume-yes          Answer yes to all questions
  --sign                    Sign the uploaded data with the client certificate
  --no-unreported-check     Do not check for unreported history
  --no-metadata-check       Do not check for old metadata
  --no-remote-check         Do not check if download remotes should be enabled
  --no-reboot-check         Do not check or prompt for reboot after update
  --no-safety-check         Do not perform device safety checks
  --no-device-prompt        Do not prompt for devices
  --no-history              Do not write to the history database
  --show-all                Show all results
  --disable-ssl-strict      Ignore SSL strict checks when downloading files
  --ipfs                    Only use IPFS when downloading files
  --filter                  Filter with a set of device flags using a ~ prefix to exclude, e.g. 'internal,~needs-reboot'
  --json                    Output in JSON format

This tool allows an administrator to query and control the fwupd daemon, allowing them to perform actions such as installing or downgrading firmware.
```
## Listing the devices

Get the list of hardware that supports firmware updates:

```console
alex@latitude7490:~/ > fwupdmgr get-devices
Latitude 7490
│
├─System Firmware:
│ │   Device ID:          xxx
│ │   Summary:            UEFI ESRT device
│ │   Current version:    1.24.1
│ │   Minimum Version:    1.24.1
│ │   Vendor:             Dell (DMI:Dell Inc.)
│ │   Update State:       Needs reboot
│ │   Last modified:      2022-11-01 17:24
│ │   GUIDs:              xxx
│ │   Device Flags:       • Internal device
│ │                       • Updatable
│ │                       • System requires external power source
│ │                       • Supported on remote server
│ │                       • Needs a reboot after installation
│ │                       • Cryptographic hash verification is available
│ │                       • Device is usable for the duration of the update
│ │
│ └─UEFI dbx:
│       Device ID:        362301da643102b9f38477387e2193e57abaa590
│       Summary:          UEFI revocation database
│       Current version:  77
│       Minimum Version:  77
│       Vendor:           UEFI:Linux Foundation
│       Install Duration: 1 second
│       Update State:     Needs reboot
│       Last modified:    2022-11-01 17:24
│       GUIDs:            xxxx
│       Device Flags:     • Internal device
│                         • Updatable
│                         • Supported on remote server
│                         • Needs a reboot after installation
│                         • Only version upgrades are allowed
│                         • Signed Payload
│
├─TPM 2.0:
│     Device ID:          xxxx
│     Summary:            UEFI ESRT device
│     Current version:    7.2.0.1
│     Vendor:             Dell Inc. (PCI:0x1028)
│     Update State:       Success
│     Update Error:       Updating disabled due to TPM ownership
│     GUIDs:              xxxxx
│     Device Flags:       • Internal device
│                         • System requires external power source
│
├─Unifying Receiver:
│     Device ID:          xxx
│     Summary:            Miniaturised USB wireless receiver
│     Current version:    RQR12.10_B0032
│     Bootloader Version: BOT01.02_B0015
│     Vendor:             HIDRAW:0x046D|USB:0x046D
│     Install Duration:   30 seconds
│     GUIDs:              xxx
│     Device Flags:       • Updatable
│                         • Supported on remote server
│                         • Unsigned Payload
│
└─WDC WDS500G2B0C-00PXH0:
      Device ID:          xxx
      Summary:            NVM Express solid state drive
      Current version:    211070WD
      Vendor:             Sandisk Corp (NVME:0x15B7)
      GUIDs:              xxx
      Device Flags:       • Internal device
                          • Updatable
                          • System requires external power source
                          • Needs a reboot after installation
                          • Device is usable for the duration of the update

```

## Listing the upgrades available

List available upgrades:

```
alex@latitude7490:~/ > fwupdmgr get-upgrades
Devices with no available firmware updates:
 • WDC WDS500G2B0C-00PXH0
Devices with the latest available firmware version:
 • RTS5413 in Dell dock
 • RTS5487 in Dell dock
 • System Firmware
 • UEFI dbx
 • Unifying Receiver
Devices not currently updatable:
 • Package level of Dell dock — Pending activation
 • Thunderbolt controller in Dell dock — Pending activation
 • VMM5331 in Dell dock — Pending activation
 • WD19TB — (null)
No updates available
```

## Upgrade Firmware

Do the update:

```
alex@latitude7490:~/ > fwupdmgr update
Devices with no available firmware updates:
 • WDC WDS500G2B0C-00PXH0
╔══════════════════════════════════════════════════════════════════════════════╗
║ Upgrade Package level of Dell dock from 01.00.24.01 to 01.00.25.01?          ║
╠══════════════════════════════════════════════════════════════════════════════╣
║ -Update the firmware package version of Dell docking station's composite     ║
║ devices.                                                                     ║
║                                                                              ║
║ The update will continue when the device USB cable has been unplugged.       ║
╚══════════════════════════════════════════════════════════════════════════════╝

Perform operation? [Y|n]: y
╔══════════════════════════════════════════════════════════════════════════════╗
║ Reinstall RTS5413 in Dell dock to 01.21?                                     ║
╠══════════════════════════════════════════════════════════════════════════════╣
║ -Same as previous release, there is no change for this component.            ║
║                                                                              ║
║ The update will continue when the device USB cable has been unplugged.       ║
║                                                                              ║
║ RTS5413 in Dell dock must remain connected for the duration of the update    ║
║ to avoid damage.                                                             ║
╚══════════════════════════════════════════════════════════════════════════════╝

Perform operation? [Y|n]: n
Request canceled
alex@latitude7490:~/ >
alex@latitude7490:~/ > fwupdmgr update
Devices with no available firmware updates:
 • WDC WDS500G2B0C-00PXH0
╔══════════════════════════════════════════════════════════════════════════════╗
║ Upgrade Package level of Dell dock from 01.00.24.01 to 01.00.25.01?          ║
╠══════════════════════════════════════════════════════════════════════════════╣
║ -Update the firmware package version of Dell docking station's composite     ║
║ devices.                                                                     ║
║                                                                              ║
║ The update will continue when the device USB cable has been unplugged.       ║
╚══════════════════════════════════════════════════════════════════════════════╝

Perform operation? [Y|n]: Y
╔══════════════════════════════════════════════════════════════════════════════╗
║ Reinstall RTS5413 in Dell dock to 01.21?                                     ║
╠══════════════════════════════════════════════════════════════════════════════╣
║ -Same as previous release, there is no change for this component.            ║
║                                                                              ║
║ The update will continue when the device USB cable has been unplugged.       ║
║                                                                              ║
║ RTS5413 in Dell dock must remain connected for the duration of the update    ║
║ to avoid damage.                                                             ║
╚══════════════════════════════════════════════════════════════════════════════╝

Perform operation? [Y|n]: Y
╔══════════════════════════════════════════════════════════════════════════════╗
║ Reinstall RTS5487 in Dell dock to 01.47?                                     ║
╠══════════════════════════════════════════════════════════════════════════════╣
║ -Same as previous release, there is no change for this component.            ║
║                                                                              ║
║ The update will continue when the device USB cable has been unplugged.       ║
║                                                                              ║
║ RTS5487 in Dell dock must remain connected for the duration of the update    ║
║ to avoid damage.                                                             ║
╚══════════════════════════════════════════════════════════════════════════════╝

Perform operation? [Y|n]: Y
╔══════════════════════════════════════════════════════════════════════════════╗
║ Reinstall Thunderbolt controller in Dell dock to 60.00?                      ║
╠══════════════════════════════════════════════════════════════════════════════╣
║ -Same as previous release, there is no change for this component.            ║
║                                                                              ║
║ Thunderbolt controller in Dell dock must remain connected for the duration   ║
║ of the update to avoid damage.                                               ║
╚══════════════════════════════════════════════════════════════════════════════╝

Perform operation? [Y|n]: Y
╔══════════════════════════════════════════════════════════════════════════════╗
║ Reinstall VMM5331 in Dell dock to 05.06.03?                                  ║
╠══════════════════════════════════════════════════════════════════════════════╣
║ -Same as previous release, there is no change for this component.            ║
║                                                                              ║
║ VMM5331 in Dell dock must remain connected for the duration of the update    ║
║ to avoid damage.                                                             ║
╚══════════════════════════════════════════════════════════════════════════════╝

Perform operation? [Y|n]: Y
╔══════════════════════════════════════════════════════════════════════════════╗
║ Upgrade WD19TB from 01.01.00.01 to 01.01.00.03?                              ║
╠══════════════════════════════════════════════════════════════════════════════╣
║ -Improved the display compatibility between systems and monitors.            ║
║                                                                              ║
║ The update will continue when the device USB cable has been unplugged.       ║
╚══════════════════════════════════════════════════════════════════════════════╝

Perform operation? [Y|n]: Y
Downloading…             [***************************************]
Downloading…             [***************************************]
Decompressing…           [***************************************]
Decompressing…           [***************************************]
Authenticating…          [***************************************]
==== AUTHENTICATING FOR org.freedesktop.fwupd.update-hotplug-trusted ===
Authentication is required to update the firmware on a removable device
Authenticating as: Alex Sokolsky,,, (alex)
Password:
==== AUTHENTICATION COMPLETE ===
Authenticating…          [***************************************]
==== AUTHENTICATING FOR org.freedesktop.fwupd.update-hotplug-trusted ===
Authentication is required to update the firmware on a removable device
Authenticating as: Alex Sokolsky,,, (alex)
Password:
==== AUTHENTICATION COMPLETE ===
Restarting device…       [***************************************]
Writing…                 [***************************************]
Writing…                 [***************************************]
Restarting device…       [***************************************]
Waiting…                 [***************************************]
Successfully installed firmware
Updates will complete next time the dock USB cable is unplugged.  The dock will be unavailable for approximately 1 minute.
Devices with the latest available firmware version:
 • RTS5413 in Dell dock
 • RTS5487 in Dell dock
 • Thunderbolt controller in Dell dock
 • VMM5331 in Dell dock
 • WD19TB
╔══════════════════════════════════════════════════════════════════════════════╗
║ Upgrade System Firmware from 1.24.1 to 1.28.0?                               ║
╠══════════════════════════════════════════════════════════════════════════════╣
║ Fixed the issue where the monitor takes 20 seconds to turn on when           ║
║ connected to WD19 docking station.                                           ║
║                                                                              ║
║ Do not turn off your computer or remove the AC adapter while the update is   ║
║ in progress.                                                                 ║
║                                                                              ║
║ Latitude 7490 must remain plugged into a power source for the duration of    ║
║ the update to avoid damage.                                                  ║
╚══════════════════════════════════════════════════════════════════════════════╝

Perform operation? [Y|n]: Y
Downloading…             [***************************************]
Downloading…             [***************************************]
Decompressing…           [***************************************]
Decompressing…           [***************************************]
Authenticating…          [***************************************]
==== AUTHENTICATING FOR org.freedesktop.fwupd.update-internal-trusted ===
Authentication is required to update the firmware on this machine
Authenticating as: Alex Sokolsky,,, (alex)
Password:
==== AUTHENTICATION COMPLETE ===
Authenticating…          [***************************************]
Restarting device…       [***************************************]
Writing…                 [***************************************]
Scheduling…              [***************************************]
Decompressing…           [***************************************]
Restarting device…       [***************************************]
Waiting…                 [***************************************]
Successfully installed firmware
Updates will complete next time the dock USB cable is unplugged.  The dock will be unavailable for approximately 1 minute.
╔══════════════════════════════════════════════════════════════════════════════╗
║ Upgrade UEFI dbx from 77 to 217?                                             ║
╠══════════════════════════════════════════════════════════════════════════════╣
║ This updates the dbx to the latest release from Microsoft which adds         ║
║ insecure versions of grub and shim to the list of forbidden signatures due   ║
║ to multiple discovered security updates.                                     ║
║                                                                              ║
║ Before installing the update, fwupd will check for any affected executables  ║
║ in the ESP and will refuse to update if it finds any boot binaries signed    ║
║ with any of the forbidden signatures.If the installation fails, you will     ║
║ need to update shim and grub packages before the update can be deployed.     ║
║                                                                              ║
║ Once you have installed this dbx update, any DVD or USB installer images     ║
║ signed with the old signatures may not work correctly.You may have to        ║
║ temporarily turn off secure boot when using recovery or installation media,  ║
║ if new images have not been made available by your distribution.             ║
║                                                                              ║
║ UEFI dbx and all connected devices may not be usable while updating.         ║
╚══════════════════════════════════════════════════════════════════════════════╝

Perform operation? [Y|n]: Y
Downloading…             [***************************************]
Downloading…             [***************************************]
Decompressing…           [***************************************]
Decompressing…           [***************************************]
Authenticating…          [***************************************]
==== AUTHENTICATING FOR org.freedesktop.fwupd.update-internal-trusted ===
Authentication is required to update the firmware on this machine
Authenticating as: Alex Sokolsky,,, (alex)
Password:
==== AUTHENTICATION COMPLETE ===
Authenticating…          [***************************************]
Restarting device…       [***************************************]
Writing…                 [***************************************]
Decompressing…           [***************************************]
Writing…                 [***************************************]
Restarting device…       [***************************************]
Waiting…                 [***************************************]
Successfully installed firmware
Updates will complete next time the dock USB cable is unplugged.  The dock will be unavailable for approximately 1 minute.
 • Unifying Receiver

An update requires a reboot to complete. Restart now? [y|N]:
```
