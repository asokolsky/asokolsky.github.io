# Useful Linux Commands

## Processes

Use `ps` ([man
page](https://www.man7.org/linux/man-pages/man1/ps.1.html))
to show the top 10 CPU consumers:

```sh
ps -eo pcpu,pid,user,args|sort -k 1 -nr|head -10
```

## Process Command Line

Given _pid_, show the process' command line:

```sh
cat /proc/_pid_/cmdline|xargs -0
```
