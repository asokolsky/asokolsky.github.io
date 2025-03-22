# MacOS CLI Tips

## List Hardware

[system_profiler](./cli-system_profiler.html)

## Show hidden files and folders

```sh
defaults write com.apple.finder AppleShowAllFiles -bool true
```

## Enable Check for Updates

```sh
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
```

## Prevent sleep mode

Keep your Mac from falling asleep:

```sh
caffeinate
```

## Use ditto to Copy Files & Directories

[ditto](https://ss64.com/mac/ditto.html) preserves:

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

Show Interfaces:
```sh
ifconfig
```

Show Routes:
```sh
netstat -rn
```
