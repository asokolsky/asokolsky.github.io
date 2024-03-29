# TrueNAS Scale as LAN SysLog Destination

TrueNAS Scale uses syslog-ng with configuration in
`/etc/syslog-ng/syslog-ng.conf`.

* [primer](https://www.crowdstrike.com/guides/syslog-logging/working-with-syslog-ng/)
* [use-syslog-ng-to-collect-logs](https://www.techrepublic.com/article/how-to-use-syslog-ng-to-collect-logs-from-remote-linux-machines/)

My plan:

* leave local logs (those coming from TrueNAS) intact;
* collect messages from the remote clients sent to UDP port 554;
* store such logs in a persistent dataset.

## Prepare Log Storage

I created a dedicated dataset and mounted it at
`/mnt/bmp/logs/`.  Log rotation to be addressed later.

## Configure syslog-ng

* to accept syslog messages from the remote clients, define
[network](https://www.syslog-ng.com/technical-documents/doc/syslog-ng-open-source-edition/3.16/administration-guide/19#TOPIC-956455)
or
[syslog](https://www.syslog-ng.com/technical-documents/doc/syslog-ng-open-source-edition/3.16/administration-guide/23#TOPIC-956472)
source;
* define
[file](https://www.syslog-ng.com/technical-documents/doc/syslog-ng-open-source-edition/3.16/administration-guide/31#TOPIC-956501)
destination;
* combine the above using a `log` statement.

File `/etc/syslog-ng/conf.d/remote.conf`:
```
source s_network {
    syslog(transport("udp"));
};

destination d_network {
    file("/mnt/bmp/logs/$HOST/$PROGRAM.log"
        create-dirs(yes)
        owner("root")
        group("root")
        perm(0777));
};

log {
    source(s_network);
    destination(d_network);
};
```

Restart the service with `sudo systemctl restart syslog-ng.service`

Verify the listening socket using `ss -4l`

## Use Logrotate

Logrotate [man page](https://man.freebsd.org/cgi/man.cgi?query=logrotate),
[guide](https://betterstack.com/community/guides/logging/how-to-manage-log-files-with-logrotate-on-ubuntu-20-04/) is pre-installed in
`/sbin/logrotate` and log rotation is done weekly.

All you need is to create `/etc/logrotate.d/syslog-ng-remote`:
```
"/mnt/bmp/logs/192.168.11.1/*.log"
"/mnt/bmp/logs/192.168.11.1/usr/sbin/*.log"
"/mnt/bmp/logs/192.168.11.4/*.log"
"/mnt/bmp/logs/192.168.11.5/*.log"
"/mnt/bmp/logs/192.168.11.7/*.log"
{
    daily
    rotate 3
    size 20K
    compress
    delaycompress
    sharedscripts
    postrotate
        invoke-rc.d syslog-ng reload > /dev/null
    endscript
}
```
To test:
```sh
logrotate -v /etc/logrotate.d/syslog-ng-remote
```
