# Looking into Process Details

[man proc](https://man7.org/linux/man-pages/man5/proc.5.html),
[man proc/pid](https://man7.org/linux/man-pages/man5/proc_pid.5.html)

## Process Details

Given a PID of the process....

Path:
```sh
ls -la /proc/PID/exe
```

Note the use of `self` to refer to the PID of the querying process:
```
$ ls -la /proc/self/exe
lrwxrwxrwx 1 ubuntu ubuntu 0 Apr 30 17:58 /proc/self/exe -> /usr/bin/ls
```

Current working directory:
```sh
ls -la /proc/PID/cwd
```

Command line:
```sh
cat /proc/PID/cmdline
```
