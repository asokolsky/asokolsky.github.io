# find cheat sheet

[find](https://www.linux.org/docs/man1/find.html) searched for files.


## Search Examples

Find a file called testfile.txt in current and sub-directories:
```console
find . -name testfile.txt
```

Find all .jpg files in the /home and sub-directories:
```console
find /home -name *.jpg
```

Find an empty file within the current directory:
```console
find . -type f -empty
```

Find all .db files (ignoring text case) modified in the last 7 days by a user
exampleuser:
```console
find /home -user exampleuser -mtime 7 -iname ".db"
```

Find all the files that end with conf and have been modified in the last 7 days:
```console
find / -name "*conf" -mtime 7
```
Filters exampleuser user’s home directory for files with names that end with the
characters conf and have been modified in the previous 3 days:
```console
find ~exampleuser/ -name "*conf" -mtime 3
```

## Find and Act

Searches for python files and then runs grep for "future_state":
```console
find . -type f -name '*.py' -exec grep 'future_state' '{}' +
```

List files oder than 300 days:
```console
find * -mtime +300 -exec ls -l {} \;
```

Looks for rc.conf and runs the chmod o+r command to modify file permissions:
```console
find . -name "rc.conf" -exec chmod o+r '{}' \;
```

Delete all .bak files:
```console
find . -name "*.bak" -delete
```

Display the files older than 30 days:
```console
find . -mtime +30 -print
```

Calculate LOCs:
```console
find . -name '*.py' | xargs wc -l
```

Remove all the files from /tmp owned by a.sokolsky:
```console
find /tmp/* -user a.sokolsky -exec rm -fr {} \;
```
