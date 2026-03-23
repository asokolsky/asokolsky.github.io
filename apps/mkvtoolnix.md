# MKVToolNix on Linux Mint

[mkvtoolnix](https://mkvtoolnix.download/).  See also [mkvtool](mkvtool.html).

## Install

Identify the code-name of Ubuntu I am running:

```
> cat /etc/os-release|grep -i ubuntu
ID_LIKE="ubuntu debian"
UBUNTU_CODENAME=noble
```

The follow the [recommendations for ubuntu](https://mkvtoolnix.download/downloads.html#ubuntu):

```sh
sudo wget -O /etc/apt/keyrings/gpg-pub-moritzbunkus.gpg https://mkvtoolnix.download/gpg-pub-moritzbunkus.gpg
```
Edit the file:
```
sudo emacs /etc/apt/sources.list.d/mkvtoolnix.download.list
```

```
deb [arch=amd64 signed-by=/etc/apt/keyrings/gpg-pub-moritzbunkus.gpg] https://mkvtoolnix.download/ubuntu/ noble main
deb-src [arch=amd64 signed-by=/etc/apt/keyrings/gpg-pub-moritzbunkus.gpg] https://mkvtoolnix.download/ubuntu/ noble main
```

Finally:
```sh
sudo apt install mkvtoolnix mkvtoolnix-gui
```

## CLI

### mkvmerge

[man page](https://mkvtoolnix.download/doc/mkvmerge.html).


List tracks:
```sh
mkvmerge S01E01.mkv -J|jq .tracks
```

List IDs of the English audio tracks:

```sh
mkvmerge S01E01.mkv -J|jq -r '.tracks|map(select(.type=="audio" and .properties.language=="eng"))|.[].id'
```

Strip all non-English soundtracks
```bash
#!/usr/bin/env bash
# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail
# Turn on traces, useful while debugging but commented out by default
#set -o xtrace

#
# The file to strip non-english audio tracks
#
#FILE_PATH="/path/to/my_document.pdf"
FILE_PATH="${1}"
#echo "Path: $FILE_PATH"
DIRNAME=$(dirname "$FILE_PATH")
FILE_WITH_EXT=$(basename "$FILE_PATH")
BASE_NAME="${FILE_WITH_EXT%.*}"
#echo "BASE_NAME: $BASE_NAME"
EXTENSION="${FILE_WITH_EXT##*.}"
#echo "EXTENSION: $EXTENSION"
OUT_FILE="${DIRNAME}/${BASE_NAME}.1.${EXTENSION}"
#echo "OUT_FILE: $OUT_FILE"

if [[ -e "$OUT_FILE" ]]; then
    echo "Error: $OUT_FILE already exists."
    exit 1
fi

ENGLISH_AUDIO_TRACKS=`mkvmerge $FILE_PATH -J|jq -r '.tracks|map(select(.type=="audio" and .properties.language=="eng"))|.[].id'|paste -s -d ','`
echo "ENGLISH_AUDIO_TRACKS: $ENGLISH_AUDIO_TRACKS"

# --subtitle-tracks
mkvmerge --output $OUT_FILE --audio-tracks $ENGLISH_AUDIO_TRACKS $FILE_PATH
```
