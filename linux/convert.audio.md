# Audio Format Conversion


## Cut flac into tracks on cue

[Source](https://wiki.archlinux.org/title/CUE_Splitting).

Install [cuetools](https://github.com/svend/cuetools) and shntool:

```sh
$ sudo apt install cuetools shntool
```

Use:

```sh
$ shnsplit -f file.cue -t %n-%t -o flac file.flac
```

## flac -> m4a lossless

Convert all [flac](https://en.wikipedia.org/wiki/FLAC) files in the directory to
[alac](https://en.wikipedia.org/wiki/Apple_Lossless_Audio_Codec)
[m4a](https://en.wikipedia.org/wiki/MPEG-4_Part_14#Filename_extensions) -
vegetable is good for you.

```sh
for fn in *.flac; do ffmpeg -i $fn -c:v copy -c:a alac "`basename $fn .flac`.m4a"; done
```
