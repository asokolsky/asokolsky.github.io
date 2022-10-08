# MacOS CLI Tips

## List Hardware

```console
asokolsky in ~ > system_profiler -detailLevel full SPEthernetDataType
system_profiler -detailLevel full SPEthernetDataType
Ethernet:

    Apple T2 Controller:

      Bus: USB
      Vendor Name: Apple Inc.
      Product Name: Apple T2 Controller
      Vendor ID: 0x05ac
      Product ID: 0x8233
      USB Link Speed: Up to 480 Mb/s
      Driver: com.apple.driver.usb.cdc.ncm
      BSD Device Name: en5
      MAC Address: ac:de:48:00:11:22
      AVB Support: No
      Maximum Link Speed: 2.5 Gb/s

    USB 10/100/1000 LAN:

      Bus: USB
      Vendor Name: Realtek
      Product Name: USB 10/100/1000 LAN
      Vendor ID: 0x0bda
      Product ID: 0x8153
      USB Link Speed: Up to 5 Gb/s
      Driver: com.apple.DriverKit.AppleUserECM
      BSD Device Name: en7
      MAC Address: 00:00:00:00:00:00
      AVB Support: No
```

## Show hidden files and folders

```sh
defaults write com.apple.finder AppleShowAllFiles -bool true
```

## Enable Check for Updates

```
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
```

## Prevent sleep mode

Keep your Mac from falling asleep:

```sh
caffeinate
```

## Copy Files & Directories


ditto preserves:

* ownership attributes and permissions
* file resource forks
* file and folder metadata

```sh
ditto ~/Desktop/FluffyBackups /Volumes/FluffyBackups/
```

Merge the directories:
```sh
ditto ~/Pictures/Fall2015/ /Volumes/PhotoBackup/2015/
```
