# grep (global regular expression print)

[grep man page](https://linuxcommand.org/lc3_man_pages/grep1.html)

## Tokenize input

This will print one word per line:

```sh
grep -oE '\w+'
```

* `-o`, `--only-matching` - prints only the matched (non-empty) parts of the
matching line, with each such part on a separate output line.
* `-E`, `--extended-regexp`  - interpret PATTERN as extended regular
expressions.
* `\w+` - matches [word character](https://www.gnu.org/software/findutils/manual/html_node/find_html/grep-regular-expression-syntax.html)

## Exclusions

Filter out words in `exclude-words` file from `stdin`.

```sh
grep -vwFf exclude-words
```

* `-v`, `--invert-match` - invert the sense of matching, to select non-matching
lines.
* `-w`, `--word-regexp` - select only those lines containing matches that form
whole words. The test is that the matching substring must either be at the
beginning of the line, or preceded by a non-word constituent character.
Similarly, it must be either at the end of the line  or followed by a non-word
constituent character.
* `-F`, `--fixed-strings` - interpret PATTERN as fixed strings, not regular
expressions.
* `-f FILE`, `--file=FILE` - obtain patterns from FILE, one per line. The empty
file contains zero patterns, and therefore matches nothing.
