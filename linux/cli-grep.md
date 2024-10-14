# grep

[man page](https://man7.org/linux/man-pages/man1/grep.1.html)

Of note:

* `-v`, `--invert-match` - Invert the sense of matching, to select
non-matching lines.

## Examples:

```
> sensors|grep RPM|grep -v ':                     0'
fan1:                   934 RPM  (min =    0 RPM)
fan2:                   533 RPM  (min =    0 RPM)
```
