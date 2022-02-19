# Using exiftool

[exiftool](https://github.com/exiftool/exiftool) is pretty awesome!

Here are commands I found useful:

Test renaming image files by date:

```console
exiftool -d '%Y-%m-%d' '-Testname<${DateTimeOriginal}.${FileSequence;$_=sprintf("%03d", $_ )}.%le' *.*
```

And then to actually rename the files:

```console
exiftool -d '%Y-%m-%d' '-Filename<${DateTimeOriginal}.${FileSequence;$_=sprintf("%03d", $_ )}.%le' *.*
```
