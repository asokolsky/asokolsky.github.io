# CLI FAQ

## Network

```
sudo netstat -plutn
```

## Disk

Show how much space is used by directories in this folder:

```
du -sh -- *
```

## systemctl

Restart x11vnc service:

```
sudo systemctl start x11vnc.service
```

Show running services:

```
systemctl list-units --type=service | grep running
```

Show ntpdate service status

```
systemctl status ntpdate.service
```

## find

Find a file called testfile.txt in current and sub-directories:
```
find . -name testfile.txt	
```

Find all .jpg files in the /home and sub-directories:
```
find /home -name *.jpg	
```

Find an empty file within the current directory:
```
find . -type f -empty
```

Find all .db files (ignoring text case) modified in the last 7 days by a user exampleuser:
```
find /home -user exampleuser -mtime 7 -iname ".db"
```

Find all the files that end with conf and have been modified in the last 7 days:
```
find / -name "*conf" -mtime 7
```
Filters exampleuser user’s home directory for files with names that end with the characters conf and have been modified in the previous 3 days:
```
find ~exampleuser/ -name "*conf" -mtime 3	
```

Searches for python files and then runs "future_state":
```
find . -type f -name '*.py' -exec grep 'future_state' '{}' +
```

Looks for rc.conf and runs the chmod o+r command to modify file permissions:
```
find . -name "rc.conf" -exec chmod o+r '{}' \;
```

Delete all .bak files:
```
find . -name "*.bak" -delete
```

Display the files older than 30 days:
```
find . -mtime +30 -print
```

Calculate LOCs:
```
find . -name '*.py' | xargs wc -l
```

List files oder than 300 days:
```
find * -mtime +300 -exec ls -l {} \;	
```
Remove all the files from /tmp owned by a.sokolsky:
```
find /tmp/* -user a.sokolsky -exec rm -fr {} \;
```

