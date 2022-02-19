# Convert Photos to PDF

You will need imagemagick:

```
sudo apt install imagemagick
```

Then:

```sh
convert *.jpg -auto-orient -quality 50 -units PixelsPerInch -density 72x72 \
    tt.pdf
```
