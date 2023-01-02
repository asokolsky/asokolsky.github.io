# Windows Stuff

Here:

* [Disable IPv6](#disable-ipv6)
* [(re)Mount NAS Network Share](#remount-shares)
* [Swap Caps Ctrl](#swap-caps-ctrl)
* [wmic](cli-wmic.html)
* [Merge MP3 files](cli.html)
* [systeminfo](cli-systeminfo.html)

## <a name="disable-ipv6"></a>Disable IPv6

Create a reg key from an elevated prompt:

```
reg add hklm\system\currentcontrolset\services\tcpip6\parameters /v DisabledComponents /t REG_DWORD /d 255
```

Reboot, IPv6 is disabled.  Your teredo, isatap, 6to4 interfaces are all gone.

To put it back how it was - just delete the key:
```
reg delete hklm\system\currentcontrolset\services\tcpip6\parameters\ /v DisabledComponents /f
```

Reboot.

This doesn't remove the IPv6 loopback - but it does keep from sending out any
IPv6 on the interfaces.

## <a name="remount-shares"></a>(re)Mount NAS Network Share

```cmd
{% include_relative nas.cmd %}
```

## <a name="swap-caps-ctrl"></a>SwapCapsCtrl.reg

```cmd
{% include_relative SwapCapsCtrl.reg %}
```
