# XigmaNAS in a VM on ProxMox

I use [XigmaNAS](https://en.wikipedia.org/wiki/XigmaNAS) to

* expose mass storage via SMB/NFS
* offer syslog destination for log collection

## Create a VM

Basics:

* CPU: 2 cores, type - host
* 12GB RAM, NO memory ballooning as PCI pass-through is used.
* Boot drive 16GB

Passthrough:

* [SATA controller](pcie-passthrough-sata.html).  I have some SATA SSDs
attached.
* NIC

## Install XigmaNAS

As usual:

* create local user
* enable ssh
* enable SMARTd
* ACPId - not in VM
* enable SMB, NFS as required
* NIC - first DHCP, then static to ensure router can always send syslog

## Install Productivity Packages

Install the editor, htop:
```sh
sudo pkg install emacs-nox
sudo pkg install htop
```

### Install and Configure Guest QEMU Agent

Install the guest agent:
```sh
sudo pkg install qemu-guest-agent
```

In GUI System / Advanced / loader.conf add:

Variable|Value|Description
--------|-----|--------
`virtio_console_load`|`YES`|for qemu-ga to work
`qemu_guest_agent_enable`|`YES`|
`qemu_guest_agent_flags`|`-d -v -l /var/log/qemu-ga.log`

Restart xigmanas, verify that the agent works:

```
xigmanas: ~# service -v qemu-guest-agent status
qemu-guest-agent is located in /usr/local/etc/rc.d
qemu_guest_agent is running as pid 3104.
```

## Email Setup

Configure XigmaNAS
[email to work with Gmail](https://www.xigmanas.com/forums/viewtopic.php?t=5).

## SysLog Collector

If you want to collect logs from your router and/or DHCP server, ensure the
collector has a static IP address.

Relevant:

* [setup-and-configure-freebsd-as-a-syslog-server](https://www.iceflatline.com/2014/08/how-to-setup-and-configure-freebsd-as-a-syslog-server/)
* [xigmanas-as-a-syslog-server](https://www.medo64.com/2020/07/xigmanas-as-a-syslog-server/)

### Out-of-the-box Functionality

XigmaNAS comes with [syslogd]((https://man.freebsd.org/cgi/man.cgi?syslogd)),
which can be configured in the XigmaNAS GUI to:

* accept messages from the remote servers: check Diagnostics / Log / Settings /
Accept remote syslog messages.

* [store logs persistently](https://www.xigmanas.com/wiki/doku.php?id=faq:0134):
in System / Advanced / rc.conf add:

Variable|Value|Description
--------|-----|-----
clog_logdir|`/mnt/_pool_/logs`|Log files location

Then `sudo /etc/rc.d/syslogd restart`.

Unfortunately syslogd is not flexible enough to store remote logs in separate
files by source.

### Replace syslog with rsyslog for remote logging

* DISABLE remote logging by syslog
* DO USE persistent location `/mnt/_pool_/logs` for logs

Install rsyslog:
```sh
pkg install rsyslog
```

Verify the install:
```sh
rsyslogd -v
```

* [rsyslog man](https://man.freebsd.org/cgi/man.cgi?query=rsyslogd&apropos=0&sektion=8&manpath=freebsd-ports&format=html)
* [rsyslog.conf man page](https://man.freebsd.org/cgi/man.cgi?query=rsyslog.conf&apropos=0&sektion=0&manpath=FreeBSD+13.2-RELEASE+and+Ports&arch=default&format=html)

Update `/usr/local/etc/rsyslog.conf`  file:
```
{% include_relative rsyslog.conf %}
```

Enable rsyslog start at system boot:
```sh
sysrc rsyslog_enable=”YES”
```

```sh
sudo service rsyslog start
```

Check:
```sh
sudo service rsyslog status
```

Relevant:

* [storing-and-forwarding-remote-messages](https://www.rsyslog.com/storing-and-forwarding-remote-messages/)
* [linux-freebsd-windows-rsyslog-server-client](https://blog.andreev.it/2017/12/118-linux-freebsd-windows-rsyslog-server-client/)
* [log-aggregation-rsyslog](https://www.redhat.com/sysadmin/log-aggregation-rsyslog)
* [configure-centralised-rsyslog-server](https://betterstack.com/community/guides/logging/how-to-configure-centralised-rsyslog-server/)

TODO:
* [journald-logging](https://sematext.com/blog/journald-logging-tutorial/)

To test logging functionality, use
[logger](https://man7.org/linux/man-pages/man1/logger.1.html):

```sh
logger -p local0.notice -t from_cmd_line "Test Message"
```

### Update DHCP Server

Option 7, UDP log server,
[RFC 2132](https://datatracker.ietf.org/doc/html/rfc2132#section-3.9), carries
the IP address of the syslog server that receives the client's log messages.

### Forward systemd journal to remote syslog server

[centralizing-with-syslog](https://www.loggly.com/ultimate-guide/centralizing-with-syslog/)

Two options:

* [configure journald](https://man7.org/linux/man-pages/man5/journald.conf.d.5.html)
to forward to syslog, the latter to forward to remote server.  Should be fast.
* use rsyslog
[imjournal](https://www.rsyslog.com/doc/configuration/modules/imjournal.html)
to ingest, then forward.

## Use Logrotate

Logrotate [man page](https://man.freebsd.org/cgi/man.cgi?query=logrotate),
[guide](https://betterstack.com/community/guides/logging/how-to-manage-log-files-with-logrotate-on-ubuntu-20-04/).


In `/etc/logrotate.d/rsyslog`
```

/mnt/_pool_/logs/*.log {
    daily
    rotate 3
    size 20K
    compress
    delaycompress
    sharedscripts
    #postrotate kill -HUP $(cat /var/run/rsyslogd.pid) > /dev/null 2>/dev/null || true
    postrotate
        /usr/lib/rsyslog/rsyslog-rotate
    endscript
}
```
To test:
```sh
logrotate -v /etc/logrotate.d/rsyslog
```
To test and to force rotation:
```sh
logrotate -v -f /etc/logrotate.d/rsyslog
```

Then daily cron job:
```sh
#!/bin/sh

/usr/sbin/logrotate -s /var/lib/logrotate/logrotate.status /etc/logrotate.conf
EXITVALUE=$?
if [ $EXITVALUE != 0 ]; then
    /usr/bin/logger -t logrotate "ALERT exited abnormally with [$EXITVALUE]"
fi
exit 0
```
