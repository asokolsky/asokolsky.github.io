# Linux Notes

## Administering

* [CentOS](../centos/)
* [Proxmox](../proxmox/)
* [SysOps Handbook](https://abarrak.gitbook.io/linux-sysops-handbook/)

## CLI

* [bluetooth](cli-bluetooth.html)
* [disk](cli-disk.html), [disk formatting](cli-disk-format.html)
* [dmidecode](cli-dmidecode.html)
* [ethtool](cli-ethtool.html)
* [find](cli-find.html)
* [fwupd client tool](cli-fwupdmgr.html)
* [ipcalc](cli-ipcalc.html)
* [iperf](cli-iperf.html)
* [ipmi](cli-ipmi.html)
* [jq](cli-jq.html)
* [netstat](cli-netstat.html)
* [pdsh](cli-pdsh.html)
* [bulk rename](cli-rename-files.html)
* [rsync](cli-rsync.html)
* [socket stats](cli-ss.html)
* [systemctl](cli-systemctl.html)

## Examples

show top 10 CPU consuming processes:
```sh
ps -eo pcpu,pid,user,args|sort -k 1 -nr|head -10
```
show process command line:
```sh
cat /proc/_pid_/cmdline|xargs -0
```
reload DNS resolver:
```sh
sudo killall -USR2 systemd-resolved
```

## Linux Tasks

* [Benchmarks](benchmarks/)
* Convert [audio](convert-audio.html), [images](convert-image.html)
* [dot files](/apps/dot-files)
* [kernel tuning](kernel-tuning.html)

## Linux Internals

* [Process States](https://raw.githubusercontent.com/abarrak/linux-sysops-handbook/main/images/process-states.png) from
[Linux SysOps Handbook](https://github.com/abarrak/linux-sysops-handbook/)

See also:

* [Programming](/programming/)
* [CLI](cli.html)


## Linux Books

* [Networking](http://nnc3.com/mags/networking/)
* [Networking2](http://nnc3.com/mags/Networking2/)
* [Unix](http://nnc3.com/mags/unix3/)
* [Linux web server](http://nnc3.com/mags/lnXwwwsvr/)
* [Linux Journal](http://nnc3.com/mags/LM18/LJ/tocindex.html)
* [Linux Magazine](http://nnc3.com/mags/LM10/)
