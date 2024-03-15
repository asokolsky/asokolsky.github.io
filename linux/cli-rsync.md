# RSYNC CLI

From a source nasty (192.168.11.55) to destination nas (http://192.168.11.30):

```sh
rsync --dry-run --verbose --archive --recursive --human-readable --inplace \
  --no-whole-file --delete-delay --info=BACKUP,COPY,DEL,REMOVE,SKIP,STATS \
  --log-file=/tmp/rsync.log \
  /mnt/tank/Documents/Books \
  barbara@192.168.11.30:/mnt/tank/documents/
```

To copy a folder to a remote LAN computer:

```sh
rsync -va rest2gpio/ alex@192.168.10.30:rest2gpio
```
