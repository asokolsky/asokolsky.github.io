# Image Manipulation

You will need imagemagick:

```
sudo apt install imagemagick
```

## Convert Photos to PDF

```sh
convert *.jpg -auto-orient -quality 50 -units PixelsPerInch -density 72x72 \
    tt.pdf
```

## EXIF View/Delete

To view image details, EXIF including:

```sh
identify -verbose ../hardware/audio-zoom-p4.jpg
```

To strip EXIF:

```sh
convert in.jpg -auto-orient -strip out.jpg
```

Alternatively on can use [exiftool](../apps/cli-exiftool.html).
