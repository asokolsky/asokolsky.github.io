# RSYNC CLI

From a source nasty (192.168.11.55) to destination nas (http://192.168.11.30):

```
rsync --dry-run --verbose --archive --recursive --human-readable --inplace \
  --no-whole-file --delete-delay --info=BACKUP,COPY,DEL,REMOVE,SKIP,STATS \
  --log-file=/tmp/rsync.log \
  /mnt/tank/Documents/Books \
  barbara@192.168.11.30:/mnt/tank/documents/
```
