# systemd-analyze

```
alex@t14g3 > systemd-analyze
Startup finished in 25.736s (firmware) + 3.577s (loader) + 2.950s (kernel) + 8.694s (userspace) = 40.959s
graphical.target reached after 8.678s in userspace.

alex@t14g3 > systemd-analyze blame
5.988s NetworkManager-wait-online.service
3.096s fwupd-refresh.service
1.353s fwupd.service
1.352s systemd-suspend.service
1.119s NetworkManager.service
 900ms systemd-backlight@backlight:intel_backlight.service
 817ms lightdm.service
 801ms plymouth-quit-wait.service
 727ms postfix@-.service
 539ms accounts-daemon.service
 520ms udisks2.service
 507ms power-profiles-daemon.service
 504ms polkit.service
 495ms e2scrub_reap.service
 487ms systemd-logind.service
 486ms switcheroo-control.service
 259ms dpkg-db-backup.service
 258ms dev-nvme0n1p2.device
 217ms user@1000.service
 151ms systemd-udev-trigger.service
 132ms gpu-manager.service

alex@t14g3 > systemd-analyze critical-chain
The time when unit became active or started is printed after the "@" character.
The time the unit took to start is printed after the "+" character.

graphical.target @8.678s
└─multi-user.target @8.678s
  └─postfix.service @8.674s +2ms
    └─postfix@-.service @7.934s +727ms
      └─network-online.target @7.855s
        └─NetworkManager-wait-online.service @1.865s +5.988s
          └─NetworkManager.service @734ms +1.119s
            └─dbus.service @685ms +25ms
              └─basic.target @673ms
                └─sockets.target @673ms
                  └─uuidd.socket @673ms
                    └─sysinit.target @671ms
                      └─systemd-backlight@backlight:intel_backlight.service @1.657s +900ms
                        └─system-systemd\x2dbacklight.slice @498ms
                          └─system.slice @182ms
                            └─-.slice @182ms

alex@t14g3 > sudo systemctl disable postfix
[sudo] password for alex:
Synchronizing state of postfix.service with SysV service script with /usr/lib/systemd/systemd-sysv-install.
Executing: /usr/lib/systemd/systemd-sysv-install disable postfix
Removed "/etc/systemd/system/multi-user.target.wants/postfix.service".
```

after reboot:

```
alex@t14g3 > systemd-analyze
Startup finished in 25.580s (firmware) + 3.636s (loader) + 2.931s (kernel) + 8.147s (userspace) = 40.296s
graphical.target reached after 8.129s in userspace.

alex@t14g3 > systemd-analyze blame
5.708s NetworkManager-wait-online.service
1.087s loadcpufreq.service
1.004s gpu-manager.service
 877ms systemd-backlight@backlight:intel_backlight.service
 859ms NetworkManager.service
 313ms systemd-resolved.service
 244ms dev-nvme0n1p2.device
 239ms blueman-mechanism.service
 179ms user@1000.service
 173ms networkd-dispatcher.service
 144ms rsyslog.service
 144ms systemd-udev-trigger.service
 140ms ubuntu-system-adjustments.service
 137ms udisks2.service
 128ms upower.service
 127ms accounts-daemon.service
 119ms plymouth-quit-wait.service
 101ms lightdm.service
 101ms avahi-daemon.service
  99ms power-profiles-daemon.service
  97ms polkit.service

alex@t14g3 > systemd-analyze critical-chain
The time when unit became active or started is printed after the "@" character.
The time the unit took to start is printed after the "+" character.

graphical.target @8.129s
└─multi-user.target @8.129s
  └─kerneloops.service @8.097s +30ms
    └─network-online.target @8.072s
      └─NetworkManager-wait-online.service @2.362s +5.708s
        └─NetworkManager.service @1.487s +859ms
          └─dbus.service @1.386s +46ms
            └─basic.target @1.265s
              └─sockets.target @1.265s
                └─uuidd.socket @1.265s
                  └─sysinit.target @1.261s
                    └─systemd-backlight@backlight:intel_backlight.service @1.490s +877ms
                      └─system-systemd\x2dbacklight.slice @531ms
                        └─system.slice @186ms
                          └─-.slice @186ms

> systemctl disable NetworkManager-wait-online.service
```

after reboot

```
alex@t14g3 > systemd-analyze
Startup finished in 25.502s (firmware) + 3.649s (loader) + 2.906s (kernel) + 2.568s (userspace) = 34.627s
graphical.target reached after 2.561s in userspace.

alex@t14g3 > systemd-analyze blame
927ms NetworkManager.service
872ms systemd-backlight@backlight:intel_backlight.service
790ms lightdm.service
766ms plymouth-quit-wait.service
371ms accounts-daemon.service
364ms blueman-mechanism.service
348ms udisks2.service
346ms power-profiles-daemon.service
337ms bluetooth.service
332ms polkit.service
326ms e2scrub_reap.service
323ms systemd-logind.service
303ms switcheroo-control.service
232ms dev-nvme0n1p2.device
216ms user@1000.service
157ms networkd-dispatcher.service
151ms gpu-manager.service
146ms rsyslog.service
138ms systemd-udev-trigger.service
130ms systemd-resolved.service
119ms upower.service

alex@t14g3 > systemd-analyze critical-chain
The time when unit became active or started is printed after the "@" character.
The time the unit took to start is printed after the "+" character.

graphical.target @2.561s
└─multi-user.target @2.561s
  └─getty.target @2.561s
    └─getty@tty1.service @2.561s
      └─system-getty.slice @2.560s
        └─setvtrgb.service @2.557s +1ms
          └─plymouth-quit-wait.service @1.768s +766ms
            └─systemd-user-sessions.service @1.756s +8ms
              └─network.target @1.734s
                └─NetworkManager.service @807ms +927ms
                  └─dbus.service @747ms +27ms
                    └─basic.target @721ms
                      └─sockets.target @721ms
                        └─uuidd.socket @721ms
                          └─sysinit.target @719ms
                            └─systemd-backlight@backlight:intel_backlight.service @1.540s +872ms
                              └─system-systemd\x2dbacklight.slice @517ms
                                └─system.slice @192ms
```
