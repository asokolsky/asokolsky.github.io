# Top Consumers Recipes

See [performance-monitoring.sh](https://github.com/100daysofdevops/100daysofdevops/blob/master/performance_tuning/performance-monitoring.sh)

Note the differences in the way CPU consumption is measured:

* `ps`: [CPU usage is .. expressed as the percentage of time spent running during the entire lifetime of a process](https://man7.org/linux/man-pages/man1/ps.1.html#NOTES).
* `top`: [The task's share of the elapsed CPU time since the last screen update, expressed as a percentage of total CPU time](https://man7.org/linux/man-pages/man1/top.1.html#3._FIELDS_/_Columns).


Hence, `ps` gives you historical value, in contrast to the instanteneous value
given by `top`.

## Identify CPU usage of a Process

[Details](https://stackoverflow.com/questions/1221555/retrieve-cpu-usage-and-memory-usage-of-a-single-process-on-linux) -

Note:

* the need for `-n 2`.
* the delay time (here 0.2 seconds) heavily impacts the measurement.
Increase to 0.4 gives the result closer to what `top` displays interactively.

By pid:
```sh
top -b -n 2 -d 0.2 -p _pid_ | tail -1 | awk '{print $9}'
```
By name:
```sh
top -b -n 2 -d 0.2 -p `pidof -s _pname_` | tail -1 | awk '{print $9}'
```

If the process has multiple instances:
```sh
#!/usr/bin/env bash
#
# Given process name, run top on its pids, sort by the increasing CPU%
#
pname=$1
pids=$(pidof $pname)
p_options=''
# top takes <20 -p options ;-(
p_count=0
for pid in $pids; do
    p_options="$p_options -p $pid"
    p_count=$((p_count+1))
    if [[ "$p_count" -gt 19 ]]; then
        break
    fi
done

top -b -n 2 -d 0.2 $p_options|tail -$p_count|sort -k9
```

## Top 5 Processes by CPU usage

```sh
ps -eo pcpu,pid,user,args | sort -k 1 -r | head -n 5
```

## Top 5 Processes by Memory
```sh
ps -eo pmem,pid,user,args | sort -k 1 -r | head -n 5
```

## Top 5 Processes by I/O

Assumes `iotop`.
```sh
sudo iotop -o -b -n 5
```

## Top 5 Processes by Network I/O

Assumes `iftop`.
```sh
sudo iftop -P -n -t -s 5
```
