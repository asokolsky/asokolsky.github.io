# wmic

`wmic` [is a](https://en.wikipedia.org/wiki/Windows_Management_Instrumentation)
"command-line tool designed to ease WMI information retrieval about a system by
using some simple keywords (aliases)."

Note: "There is a Linux port of WMI command line tool".

`wmic` is deprecated: "text encoding is a mess. Some programs output using the
OEM codepage, some use the ANSI codepage, some use the current console input or
output codepage, and some can do UTF-16, but usually only to a disk file (e.g.
wmic.exe)."


Hence, instead of `wmic memorychip get capacity`, use:

```
Get-CimInstance -ClassName Win32_PhysicalMemory | Select-Object capacity
```

The rest are examples of `wmic` use.  For a full list of commands use
`wmic -?`.

## wmic bios

Try `wmic bios list full` or, e.g.,

```
$ wmic bios get serialnumber
SerialNumber
PF1JZKC1
```

## wmic cpu

Try `wmic cpu list full` or, e.g.,

```
$ wmic cpu get name
Name
Intel(R) Core(TM) i7-8750H CPU @ 2.20GHz
```

## wmic computersystem

```
$ wmic computersystem get name
Name
L07A97UF
```

## wmic csproduct

Try `wmic csproduct list full` or, e.g.,

```
$ wmic csproduct get name
Name
20M9CTO1WW
```

## wmic memorychip

Display memory information:

```
C:\Users\asoko>wmic memorychip get banklabel, devicelocator, manufacturer, partnumber, speed, serialnumber, capacity
BankLabel  Capacity    DeviceLocator   Manufacturer  PartNumber        SerialNumber  Speed
BANK 0     8589934592  ChannelA-DIMM0  Samsung       M471A1K43CB1-CTD  410C6036      2667
BANK 1     8589934592  ChannelA-DIMM1  Micron        8ATF1G64HZ-2G6E1  212DCB8B      2667
BANK 2     8589934592  ChannelB-DIMM0  Samsung       M471A1K43CB1-CTD  410C60C6      2667
BANK 3     8589934592  ChannelB-DIMM1  Micron        8ATF1G64HZ-2G6E1  1DFE21C7      2667
```

or just

```
wmic memorychip list full
```

## wmic process

```
wmic process get name,processid
```

You can also use queries:

```
wmic process where ExecutablePath='C:\\windows\\system32\\notepad.exe' get ProcessId
```

or

```
wmic process where "name='chrome.exe'" get ProcessID, ExecutablePath
```
