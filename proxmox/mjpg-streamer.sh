#!/bin/sh
#
# relies on docker
#
VIDEO_DEVICE=/dev/video1
docker run --device ${VIDEO_DEVICE}  -e "ENV_CAMERA=${VIDEO_DEVICE}" \
       -e "ENV_FPS=30" -e "ENV_RESOLUTION=1920x1080" \
       -e "ENV_LOCATION=./www" -p 8080:8080 \
       --name mjpg-streamer badsmoke/mjpg-streamer &
