# Useful Linux Commands

## Show top 10 CPU consuming processes

```sh
ps -eo pcpu,pid,user,args|sort -k 1 -nr|head -10
```

## Show process command line

```sh
cat /proc/_pid_/cmdline|xargs -0
```

## Reload DNS resolver

```sh
sudo killall -USR2 systemd-resolved
```

## Scripting

* [Bash scripting cheatsheet](https://devhints.io/bash)
* [Cute cheatsheet](https://pbs.twimg.com/media/FnBbebzaYAIkq1w?format=jpg&name=large)
