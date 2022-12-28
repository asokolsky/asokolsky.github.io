# Top Consumers Recipes

See https://github.com/100daysofdevops/100daysofdevops/blob/master/performance_tuning/performance-monitoring.sh

## the top 5 processes by CPU usage

```sh
ps -eo pcpu,pid,user,args | sort -k 1 -r | head -n 5
```

## the top 5 processes by memory usage
```sh
ps -eo pmem,pid,user,args | sort -k 1 -r | head -n 5
```

## the top 5 processes by I/O usage

Assumes `iotop`.

```sh
sudo iotop -o -b -n 5
```


## the top 5 processes by network usage

Assumes `iftop`.

```sh
sudo iftop -P -n -t -s 5
```
