# Socket Statistics - ss

[man page](https://man7.org/linux/man-pages/man8/ss.8.html)

## Show TCP IPv4 sockets with Processes

Use numbers instead of symbols:
```sh
ss -4tnp
```

## Also Show Listening Sockets

```sh
ss -4tpl
```

## Show Listening Unix Sockets

```sh
ss --unix -l
```
As above, but also show process and thread:
```sh
ss -xlT
```
