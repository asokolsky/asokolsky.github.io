# XigmaNAS guest README

## Install Packages

Install the editor, and htop
```sh
sudo pkg install emacs-nox
sudo pkg install htop
```

### Guest QEMU Agent

Install the guest agent:
```sh
sudo pkg install qemu-guest-agent
```

Add to `/etc/rc.conf`:
```
qemu_guest_agent_enable="YES"
```

System\Advanced\loader.conf add:

* `virtio_console_load`, `YES`, `for qemu-ga to work`

System\Advanced\loader.conf add

* `qemu_guest_agent_enable`, `YES`
* `qemu_guest_agent_flags`, `-d -v -l /var/log/qemu-ga.log`

restart, verify that the agent works:

```
xigmanas: ~# service -v qemu-guest-agent status
qemu-guest-agent is located in /usr/local/etc/rc.d
qemu_guest_agent is running as pid 3104.
```

## Email Setup

[[HOWTO] Configure XigmaNAS email to work with Gmail](https://www.xigmanas.com/forums/viewtopic.php?t=5)

## XigmaNAS as a SysLog Server

Diagnostics/Log/Settings/Accept remote syslog messages.

Might be relevant:

* https://www.medo64.com/2020/07/xigmanas-as-a-syslog-server/
* [syslogd man page](https://man.freebsd.org/cgi/man.cgi?syslogd)

In `/etc/rc.d/syslogd` replace
```
            syslogd_flags="${syslogd_flags} -ss"
```
with
```
            syslogd_flags="${syslogd_flags} -a 192.168.10.0/24"
```

[To specify log location](https://www.xigmanas.com/wiki/doku.php?id=faq:0134):
in System / Advanced / rc.conf add:

Param|Info
--------|------------
Variable|`clog_logdir`
Value|`/mnt/ssd/logs`
Description|Log files location.

Then `sudo /etc/rc.d/syslogd restart`.

## More

[FreeBSD Tuning and Optimization](https://calomel.org/freebsd_network_tuning.html)
