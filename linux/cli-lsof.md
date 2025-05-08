# lsof

[man page](https://man7.org/linux/man-pages/man8/lsof.8.html)


List the TCP server sockets in the LISTEN state:

```sh
sudo lsof -iTCP -sTCP:LISTEN -P -n
```
