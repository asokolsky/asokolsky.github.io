# Audio Format Conversion

## flac -> m4a lossless

Convert all [flac](https://en.wikipedia.org/wiki/FLAC) files in the directory to
[alac](https://en.wikipedia.org/wiki/Apple_Lossless_Audio_Codec)
[m4a](https://en.wikipedia.org/wiki/MPEG-4_Part_14#Filename_extensions) -
vegetable is good for you.

```
for fn in *.flac; do ffmpeg -i $fn -c:v copy -c:a alac "`basename $fn .flac`.m4a"; done
```
