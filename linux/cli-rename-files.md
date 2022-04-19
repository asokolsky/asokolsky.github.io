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
S02E06.avi -> s02ep06.avi
S02E06.en.srt -> s02ep06.en.srt
S02E06.ru.srt -> s02ep06.ru.srt
S02E07.avi -> s02ep07.avi
S02E07.en.srt -> s02ep07.en.srt
S02E07.ru.srt -> s02ep07.ru.srt
S02E08.avi -> s02ep08.avi
S02E08.en.srt -> s02ep08.en.srt
S02E08.ru.srt -> s02ep08.ru.srt
S03E01.avi -> s03ep01.avi
S03E01.en.srt -> s03ep01.en.srt
S03E02.avi -> s03ep02.avi
S03E02.en.srt -> s03ep02.en.srt
S03E03.avi -> s03ep03.avi
S03E03.en.srt -> s03ep03.en.srt
S03E04.avi -> s03ep04.avi
S03E04.en.srt -> s03ep04.en.srt
S03E05.avi -> s03ep05.avi
S03E05.en.srt -> s03ep05.en.srt
S03E06.avi -> s03ep06.avi
S03E06.en.srt -> s03ep06.en.srt
S03E07.avi -> s03ep07.avi
S03E07.en.srt -> s03ep07.en.srt
S03E08.avi -> s03ep08.avi
S03E08.en.srt -> s03ep08.en.srt
```

Do it:

```sh
mmv "S*E*" "s#1ep#2"
```