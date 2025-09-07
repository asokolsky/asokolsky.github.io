# MacOS CLI Tips

* [brew](cli-brew.html)
* [launchctl](cli-launchctl.html)
* [smbutil](cli-smbutil.html)
* List hardware using [system_profiler](cli-system_profiler.html)
* more [macOS (bash) commands](https://ss64.com/mac/index.html)

## Launch an App

Launch Firefox profile manager:
```sh
open -a /Applications/Firefox.app --args -P default -no-remote
```

Open a file with a specific application, TextEdit:
```sh
open ~/Downloads/Instructions.doc -a TextEdit
```

## Show hidden files and folders
Use [defaults](https://ss64.com/mac/defaults.html):
```sh
defaults write com.apple.finder AppleShowAllFiles -bool true
```

## Enable Check for Updates
Use [defaults](https://ss64.com/mac/defaults.html):
```sh
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
```

## Prevent Sleep Mode

Use [caffeinate](https://ss64.com/mac/caffeinate.html) to keep your Mac from falling asleep:
```sh
caffeinate
```

## Copy Files & Directories

Use [ditto](https://ss64.com/mac/ditto.html), it preserves:

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

## Show system temps using CLI

Use [powermetrics](https://ss64.com/mac/powermetrics.html):
```sh
sudo powermetrics --samplers smc
```

On my Intel MacBook Pro:
```
sudo powermetrics --samplers smc
Password:
Machine model: MacBookPro16,1
SMC version: Unknown
EFI version: 2069.3.0
OS version: 24D70
Boot arguments:
Boot time: Thu Feb 20 08:26:07 2025

*** Sampled system activity (Thu Mar 13 10:16:36 2025 -0700) (5006.14ms elapsed) ***

**** SMC sensors ****

CPU Thermal level: 66
GPU Thermal level: 16
IO Thermal level: 16
Fan: 2942.43 rpm
CPU die temperature: 76.93 C
GPU die temperature: 71.00 C
CPU Plimit: 0.00
GPU Plimit (Int): 0.00
Number of prochots: 0
```

## Networking

Use [ifconfig](https://ss64.com/mac/ifconfig.html) to show interfaces:
```sh
ifconfig
```

Show Routes:
```sh
netstat -rn
```
