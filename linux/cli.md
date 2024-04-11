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

## List directories only:

```sh
ls -lad */|awk '{$1=$2=$3=$4=$5=$6=$7=$8=""; print $0}'|sed 's/^ *//'
```
or
```sh
ls -lad */|awk '{out = ""; for (i = 9; i <= NF; i++) {out = out " " $i}; print out}'
```
or better yet
```
ls -ld */|cut -c 53-
```
[more options](https://stackoverflow.com/questions/14352290/listing-only-directories-using-ls-in-bash)

## Scripting

* [Bash scripting cheatsheet](https://devhints.io/bash)
* [Cute cheat-sheet](https://pbs.twimg.com/media/FnBbebzaYAIkq1w?format=jpg&name=large)
