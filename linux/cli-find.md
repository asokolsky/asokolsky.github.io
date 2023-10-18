# find cheat sheet

[find](https://www.linux.org/docs/man1/find.html) searches for files.


## Use Examples

Find a file called testfile.txt in current and sub-directories:
```sh
find . -name testfile.txt
```

Find all `.jpg` files in the `/home` and sub-directories:
```sh
find /home -name "*.jpg"
```
Note the use of quotes to prevent shell handling the wildcards.


Find an empty file within the current directory:
```sh
find . -type f -empty
```

Find all `.db` files (ignoring text case) modified in the last 7 days by a user
`exampleuser`:

```sh
find /home -user exampleuser -mtime 7 -iname ".db"
```

Find all the files that end with `conf` and have been modified in the last 7
days:
```sh
find / -name "*conf" -mtime 7
```
Filters `exampleuser` home directory for files with names that end with the
characters `conf` and have been modified in the previous 3 days:
```sh
find ~exampleuser/ -name "*conf" -mtime 3
```

## Find and Print

Display the files older than 30 days:
```sh
find . -mtime +30 -print
```

## Find and Delete

Delete all .bak files:
```sh
find . -name "*.bak" -delete
```
Delete empty directories:
```sh
find releases/ -type d -empty -delete
```

Remove all the files from /tmp owned by a.sokolsky:
```sh
find /tmp/* -user jdoe -exec rm -fr {} \;
```

## Find and Execute A Command on It

Searches for python files and then runs grep for "future_state":
```sh
find . -type f -name '*.py' -exec grep 'future_state' '{}' +
```

List files oder than 300 days:
```sh
find * -mtime +300 -exec ls -l {} \;
```

Looks for rc.conf and runs the chmod o+r command to modify file permissions:
```sh
find . -name "rc.conf" -exec chmod o+r '{}' \;
```

## Find and Act Using `xargs`

`find -exec`
[may not](https://www.everythingcli.org/find-exec-vs-find-xargs/) be
[enough](https://danielmiessler.com/blog/linux-xargs-vs-exec/).

[xargs](https://man7.org/linux/man-pages/man1/xargs.1.html) takes the results of
a command (one per line) and calls another command N times, one per line,
injecting the line value as an argument.
[Using xargs](https://shapeshed.com/unix-xargs/).

Calculate [LOC](https://en.wikipedia.org/wiki/Source_lines_of_code)s:
```sh
find . -name '*.py' | xargs wc -l
```
