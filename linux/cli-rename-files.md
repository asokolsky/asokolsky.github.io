# Bulk File Rename

[Good summary](https://ostechnix.com/how-to-rename-multiple-files-at-once-in-linux/).

What worked for me:

* install mmv using `sudo apt install mmv`;
* [mmv man page](https://www.systutorials.com/docs/linux/man/1-mmv/) has good
examples;
* use it

Problematic: `mmv -h` does not work

## Example use

Dry run:

```sh
mmv -n "S*E*" "s#1ep#2"
S02E01.avi -> s02ep01.avi
S02E01.en.srt -> s02ep01.en.srt
S02E01.ru.srt -> s02ep01.ru.srt
S02E02.avi -> s02ep02.avi
S02E02.en.srt -> s02ep02.en.srt
S02E02.ru.srt -> s02ep02.ru.srt
S02E03.avi -> s02ep03.avi
S02E03.en.srt -> s02ep03.en.srt
S02E03.ru.srt -> s02ep03.ru.srt
S02E04.avi -> s02ep04.avi
S02E04.en.srt -> s02ep04.en.srt
S02E04.ru.srt -> s02ep04.ru.srt
S02E05.avi -> s02ep05.avi
S02E05.en.srt -> s02ep05.en.srt
S02E05.ru.srt -> s02ep05.ru.srt
```

Do it:

```sh
mmv "S*E*" "s#1ep#2"
```
