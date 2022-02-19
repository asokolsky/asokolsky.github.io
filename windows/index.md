# Content

* [cli](cli.html)
* [nas.cmd](nas.cmd)
* [SwapCapsCtrl.reg](SwapCapsCtrl.reg)

## Disable IPv6

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
