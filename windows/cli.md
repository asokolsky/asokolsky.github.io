# Windows Power Shell Commands

## Merge MP3 files

In Power Shell

```cmd
get-content 06* -Enc Byte -Read 512 | set-content -Encoding Byte 06.mp3
```

## Display/Uninstall Apps

As admin, to display apps:

```cmd
DISM /Online /Get-ProvisionedAppxPackages | select-string Packagename
```

Uninstall:
```cmd
DISM.exe /Online /Remove-ProvisionedAppxPackage \
    /PackageName:Microsoft.Xbox.TCUI_1.23.28002.0_neutral_~_8wekyb3d8bbwe
```

## systeminfo

```
C:\Users\asoko>systeminfo

Host Name:                 L07A97UF
OS Name:                   Microsoft Windows 11 Home
OS Version:                10.0.22000 N/A Build 22000
OS Manufacturer:           Microsoft Corporation
OS Configuration:          Standalone Workstation
OS Build Type:             Multiprocessor Free
Registered Owner:          asokolsky@live.com
Registered Organization:
Product ID:                00325-81270-82577-AAOEM
Original Install Date:     11/1/2021, 6:18:44 AM
System Boot Time:          8/5/2022, 9:40:16 AM
System Manufacturer:       LENOVO
System Model:              20M9CTO1WW
System Type:               x64-based PC
Processor(s):              1 Processor(s) Installed.
                           [01]: Intel64 Family 6 Model 158 Stepping 10 GenuineIntel ~2208 Mhz
BIOS Version:              LENOVO N2CET58W (1.41 ), 3/5/2021
Windows Directory:         C:\WINDOWS
System Directory:          C:\WINDOWS\system32
Boot Device:               \Device\HarddiskVolume2
System Locale:             en-us;English (United States)
Input Locale:              en-us;English (United States)
Time Zone:                 (UTC-08:00) Pacific Time (US & Canada)
Total Physical Memory:     32,501 MB
Available Physical Memory: 24,960 MB
Virtual Memory: Max Size:  37,365 MB
Virtual Memory: Available: 28,226 MB
Virtual Memory: In Use:    9,139 MB
Page File Location(s):     C:\pagefile.sys
Domain:                    WORKGROUP
Logon Server:              \\L07A97UF
Hotfix(s):                 5 Hotfix(s) Installed.
                           [01]: KB5015732
                           [02]: KB5004567
                           [03]: KB5008295
                           [04]: KB5015814
                           [05]: KB5016353
Network Card(s):           4 NIC(s) Installed.
                           [01]: Intel(R) Ethernet Connection (7) I219-V
                                 Connection Name: Ethernet
                                 Status:          Media disconnected
                           [02]: Intel(R) Wireless-AC 9560 160MHz
                                 Connection Name: Wi-Fi
                                 DHCP Enabled:    Yes
                                 DHCP Server:     192.168.10.1
                                 IP address(es)
                                 [01]: 192.168.10.137
                           [03]: IVPN-TAP-Windows Adapter V9
                                 Connection Name: Ethernet 2
                                 Status:          Media disconnected
                           [04]: Bluetooth Device (Personal Area Network)
                                 Connection Name: Bluetooth Network Connection
                                 Status:          Media disconnected
Hyper-V Requirements:      A hypervisor has been detected. Features required for Hyper-V will not be displayed.

```
