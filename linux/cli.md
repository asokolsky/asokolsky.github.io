# Useful Linux Commands

[Top consuming processes](cli-top-consumers.html)

## Show the process' command line

```sh
cat /proc/_pid_/cmdline|xargs -0
```

## Show the process' environment

```sh
cat /proc/_pid_/environ | tr '\0' '\n'
```

## Reload DNS resolver

```sh
sudo killall -USR2 systemd-resolved
```

## List directories only

Not elegant but works:

```sh
ls -lad */|awk '{$1=$2=$3=$4=$5=$6=$7=$8=""; print $0}'|sed 's/^ *//'
```

better but results in a leading whitespace:

```sh
ls -lad */|awk '{out = ""; for (i = 9; i <= NF; i++) {out = out " " $i}; print out}'
```

best:

```
ls -ld */|cut -c 53-
```

[more options](https://stackoverflow.com/questions/14352290/listing-only-directories-using-ls-in-bash)

## URL-decode

```
echo -n "%21%20" | python3 -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()));"
```

## Scripting

- [Bash scripting cheatsheet](https://devhints.io/bash)
- [Cute cheat-sheet](https://pbs.twimg.com/media/FnBbebzaYAIkq1w?format=jpg&name=large)

## Troubleshooting

A server is acting slow at 2am? Here are the commands to run — in this order:

1. `top -c` - Who's eating CPU? What's the load average vs core count?
1. `iostat -xz 1 5` - Is it disk I/O? High await or %util tells the real story.
1. `free -h` - Is swap being used heavily? That's your first red flag.
1. `ss -tulnp` - What's [listening](cli-ss.html)? Anything unexpected open?
1. `df -hT` - Disk full?
1. `dmesg | tail -30` - Kernel / hardware errors show up here first.
1. `journalctl -p err -n 50` - Last 50 error-level logs.
