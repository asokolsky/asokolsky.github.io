# Audio Format Conversion

## WavPack

Convert [WavPack](https://wiki.multimedia.cx/index.php/WavPack) to
[flac](https://en.wikipedia.org/wiki/FLAC).

```sh
$ ffmpeg -i audiofile.wv audiofile.flac
```

## Cut a flac into tracks on cue

[Source](https://wiki.archlinux.org/title/CUE_Splitting).

Install [cuetools](https://github.com/svend/cuetools) and `shntool`:

```sh
$ sudo apt install cuetools shntool
```


[shntool man
page](https://manpages.debian.org/testing/shntool/shnsplit.1.en.html)

To split flac:

```sh
$ shnsplit -f file.cue -t %n-%t -o flac file.flac
```

## flac -> m4a lossless

Convert all [flac](https://en.wikipedia.org/wiki/FLAC) files in the directory to
[alac](https://en.wikipedia.org/wiki/Apple_Lossless_Audio_Codec)
[m4a](https://en.wikipedia.org/wiki/MPEG-4_Part_14#Filename_extensions) -
vegetable is good for you.

```sh
for fn in *.flac; \
    do ffmpeg -i $fn -c:v copy -c:a alac "`basename $fn .flac`.m4a"; done
```

## Merge MP# Files

```sh
sudo apt install mp3wrap
```
Then, e.g.:

```
> ls -la 0000[2-7].mp3
-rw-rw-r-- 1 alex alex 6010297 Mar 31 10:39 00002.mp3
-rw-rw-r-- 1 alex alex 6300734 Mar 31 10:39 00003.mp3
-rw-rw-r-- 1 alex alex 6065677 Mar 31 10:39 00004.mp3
-rw-rw-r-- 1 alex alex 6829497 Mar 31 10:39 00005.mp3
-rw-rw-r-- 1 alex alex 6829453 Mar 31 10:39 00006.mp3
-rw-rw-r-- 1 alex alex 5850383 Mar 31 10:39 00007.mp3
```


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
