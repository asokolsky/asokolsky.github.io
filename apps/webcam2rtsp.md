# Making webcam a security cam

Goal: convert a regular USB webcam into an RTSP security cam using
[mediamtx](https://github.com/bluenviron/mediamtx).

Relevant:
[How to Stream Video From Webcam to Network Using FFmpeg](https://www.baeldung.com/linux/ffmpeg-webcam-stream-video)


Long term: add it to [frigate](https://frigate.video/) install.

## Identify inputs and the formats

See Prerequisites section from [ffmeg](ffmpeg.md).

## Start the RTSP server

Followed
[transform-your-webcam-into-an-ip-camera](https://medium.com/@timothydmoody/transform-your-webcam-into-an-ip-camera-for-frigate-8cf50fd749e9).

Start the RTSP server:

```
> docker run --rm -it --network=host bluenviron/mediamtx:latest-ffmpeg
Unable to find image 'bluenviron/mediamtx:latest-ffmpeg' locally
latest-ffmpeg: Pulling from bluenviron/mediamtx
c926b61bad3b: Pull complete
00052b0f299a: Pull complete
d5e9513f594e: Pull complete
Digest: sha256:16afc2c64d05681763beb1a3a54301045d1690545d39b198724030c95495a9b9
Status: Downloaded newer image for bluenviron/mediamtx:latest-ffmpeg
2023/12/26 20:01:31 INF MediaMTX v1.4.1
2023/12/26 20:01:31 INF configuration loaded from /mediamtx.yml
2023/12/26 20:01:31 INF [RTSP] listener opened on :8554 (TCP), :8000 (UDP/RTP), :8001 (UDP/RTCP)
2023/12/26 20:01:31 INF [RTMP] listener opened on :1935
2023/12/26 20:01:31 INF [HLS] listener opened on :8888
2023/12/26 20:01:31 INF [WebRTC] listener opened on :8889 (HTTP), :8189 (ICE/UDP)
2023/12/26 20:01:31 INF [SRT] listener opened on :8890 (UDP)
```

## Connect your webcam

Test your [ffmpeg command](ffmpeg.md) by recording audio and video into a file.
Then, instead of a file, forward the streams into the RTSP server:

```
ffmpeg \
  -f v4l2 -framerate 30 -video_size 1920x1080 -input_format mjpeg -i /dev/video4 \
  -c:v libx264 -pix_fmt yuv420p -preset faster -g 60 \
  -f rtsp -rtsp_transport tcp rtsp://192.168.11.178:8554/live
```

## Consume the stream

Make sure your vlc [has support for RTSP](vlc.md).  Then:

```sh
vlc rtsp://192.168.11.178:8554/live
```

## Combine Video Capture and RTSP Server

If all the above works, customize mediamtx config file to start video capture:

* Copy
[mediamtx.yml](https://github.com/bluenviron/mediamtx/blob/main/mediamtx.yml)
to `webcam2rtsp.yml` and [customize it](./webcam2rtsp.yml).
* Run it as:

```
docker run --rm -it --network=host --privileged \
  -v /run/udev:/run/udev:ro -v $PWD/webcam2rtsp.yml:/mediamtx.yml \
  bluenviron/mediamtx:latest-ffmpeg
```

## Challenge

Problem: high CPU consumption of compressor even when nobody consumes the
stream.

Would be nice to have multiple video streams from a camera:

* one low res to do analysis
* another high-res to save when event is triggered based on the analysis of the
first stream.
