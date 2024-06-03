# ECC RAM Monitoring

I use [rasdaemon](https://github.com/mchehab/rasdaemon),
[howto](https://www.setphaserstostun.org/posts/monitoring-ecc-memory-on-linux-with-rasdaemon/):

```
root@fuji:~# ras-mc-ctl --mainboard
ras-mc-ctl: mainboard: FUJITSU model D3373-B1

root@fuji:~# ras-mc-ctl --error-count
Label               	CE	UE
mc#0csrow#1channel#0	0	0
mc#0csrow#3channel#1	0	0
mc#0csrow#0channel#1	0	0
mc#0csrow#2channel#0	0	0
mc#0csrow#0channel#0	0	0
mc#0csrow#2channel#1	0	0
mc#0csrow#1channel#1	0	0
mc#0csrow#3channel#0	0	0
```
