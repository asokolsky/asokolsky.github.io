# exiftool

[exiftool](https://github.com/exiftool/exiftool) is pretty awesome!

## Installation

On Linux:

```sh
sudo apt install exiftool
```

On MacOS: <whatever>

## Use

Here are commands I found useful:

Test renaming image files by date:

```sh
exiftool -d '%Y-%m-%d' '-Testname<${DateTimeOriginal}.${FileSequence;$_=sprintf("%03d", $_ )}.%le' *.*
```

And then to actually rename the files:

```sh
exiftool -d '%Y-%m-%d' '-Filename<${DateTimeOriginal}.${FileSequence;$_=sprintf("%03d", $_ )}.%le' *.*
```

To strip EXIF metadata from the image:

```sh
exiftool -all= foo.jpg
```

Alternatively, to remove geographical coordinates embedded in the photo:

```sh
exiftool -geotag= foo.jpg
```
