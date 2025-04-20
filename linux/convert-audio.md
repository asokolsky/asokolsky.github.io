# Audio Format Conversion

## WavPack -> flac

Use [ffmpeg](/apps/ffmpeg.html) to convert [WavPack](https://wiki.multimedia.cx/index.php/WavPack) to [flac](https://en.wikipedia.org/wiki/FLAC):
```sh
ffmpeg -i audiofile.wv audiofile.flac
```

## Cut a flac into tracks on cue

From [CUE_Splitting](https://wiki.archlinux.org/title/CUE_Splitting).

1. Install [cuetools](https://github.com/svend/cuetools) and `shntool`, [man shntool](https://manpages.debian.org/testing/shntool/shnsplit.1.en.html):
```sh
sudo apt install cuetools shntool
```

2. To split flac:
```sh
shnsplit -f file.cue -t %n-%t -o flac file.flac
```

## flac -> m4a lossless

Convert all [flac](https://en.wikipedia.org/wiki/FLAC) files in the directory to [alac](https://en.wikipedia.org/wiki/Apple_Lossless_Audio_Codec) [m4a](https://en.wikipedia.org/wiki/MPEG-4_Part_14#Filename_extensions) -
vegetable is good for you.

```sh
for fn in *.flac; \
    do ffmpeg -i $fn -c:v copy -c:a alac "`basename $fn .flac`.m4a"; done
```

## Merge MP3 Files

0. Install `mp3wrap`:
```sh
sudo apt install mp3wrap
```

1. Verify the wildcard:
```
> ls -la 0000[2-7].mp3
-rw-rw-r-- 1 alex alex 6010297 Mar 31 10:39 00002.mp3
-rw-rw-r-- 1 alex alex 6300734 Mar 31 10:39 00003.mp3
-rw-rw-r-- 1 alex alex 6065677 Mar 31 10:39 00004.mp3
-rw-rw-r-- 1 alex alex 6829497 Mar 31 10:39 00005.mp3
-rw-rw-r-- 1 alex alex 6829453 Mar 31 10:39 00006.mp3
-rw-rw-r-- 1 alex alex 5850383 Mar 31 10:39 00007.mp3
```

2. Use the wildcard from the first step to pass the files to `mp3wrap`:
```
> mp3wrap chapter01.mp3 0000[2-7].mp3
Mp3Wrap Version 0.5 (2003/Jan/16). See README and COPYING for more!
Written and copyrights by Matteo Trotta - <matteo.trotta@lib.unimib.it>
THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!

  16 %	--> Wrapping 00002.mp3 ... OK
  33 %	--> Wrapping 00003.mp3 ... OK
  50 %	--> Wrapping 00004.mp3 ... OK
  66 %	--> Wrapping 00005.mp3 ... OK
  83 %	--> Wrapping 00006.mp3 ... OK
  100 %	--> Wrapping 00007.mp3 ... OK

  Calculating CRC, please wait... OK

chapter01_MP3WRAP.mp3 has been created successfully!
Use mp3splt to dewrap file; download at http://mp3splt.sourceforge.net!
```

## Merge MP3 Files using `ffmpeg`

Use [ffmpeg concat demuxer](https://trac.ffmpeg.org/wiki/Concatenate#demuxer).

Create `files.txt` using e.g.:
```sh
for f in *.mp3; do echo "file '$f'" >> files.txt; done
```

`files.txt`:
```
# this is a comment
file 'path/to/chapter1.mp3'
file 'path/to/chapter2.mp3'
file 'path/to/chapter3.mp3'
```
Concatenate the files:
```sh
ffmpeg -f concat -safe 0 -i files.txt -c copy -vn output.mp3
```

## mp3 -> m4b

1. Prepare `metadata.txt`:
```
;METADATA1
title=Book Name
artist=Book Author
composer=Book Narrator
publisher=Book Publisher
date=Book Date of Publication
[CHAPTER]
TIMEBASE=1/1000
START=0 # 0:00:00
END=60000 # 0:01:00
title=Intro
```

Repeat the `[CHAPTER]` block for each chapter, specifying the START and END times in milliseconds.

2. Convert MP3 into M4B:
```sh
ffmpeg -i "some.mp3" -i metadata.txt -map_metadata 1 -codec copy -f mp4 some.m4b
```

### Add Cover Art to m4b

1. Create a cover image (optional): If you want to include cover art, save it as `cover.jpg` in the same directory as your MP3s.
2. Add cover art using a tool like Kid3 or other tag editors.
