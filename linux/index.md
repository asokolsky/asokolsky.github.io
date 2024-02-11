# Linux Notes

Administering:

* [CentOS](../centos/)
* [Proxmox](../proxmox/)
* [SysOps Handbook](https://abarrak.gitbook.io/linux-sysops-handbook/)

Commands:

* [bluetooth](cli-bluetooth.html)
* [disk](cli-disk.html)
* [format (flash) disk](cli-disk-format.html)
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

Examples:

* show top 10 CPU consuming processes:
`ps -eo pcpu,pid,user,args|sort -k 1 -nr|head -10`
* show process command line: `cat /proc/_pid_/cmdline|xargs -0`
* reload DNS resolver: `sudo killall -USR2 systemd-resolved`

Tasks:

* [Benchmarks](benchmarks/)
* Convert [audio](convert-audio.html), [images](convert-image.html)
* [dot files](/apps/dot-files)
* [kernel tuning](kernel-tuning.html)

Internals:

* [Process States](https://raw.githubusercontent.com/abarrak/linux-sysops-handbook/main/images/process-states.png)

See also:

* [Programming](/programming/)
* [CLI](cli.html)


Books:

* [Networking2](http://nnc3.com/mags/networking/)
* [Networking2](http://nnc3.com/mags/Networking2/)
* [Unix](http://nnc3.com/mags/unix3/)
* [Linux web server](http://nnc3.com/mags/lnXwwwsvr/)
* [Linux Journal](http://nnc3.com/mags/LM18/LJ/tocindex.html)
* [Linux Magazine](http://nnc3.com/mags/LM10/)
