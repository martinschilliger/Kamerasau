#!/bin/sh

. /home/pi/Kamerasau/kamerasau.conf

echo "Starting Stream to $RTMP_URL"

ffmpeg \
  -f v4l2 \
    -framerate $FPS -video_size 640x480 -i /dev/video0 \
  -f mpegts \
    -codec:v mpeg1video -s 640x480 -b:v $VBR -bf 0 \
  -tune zerolatency \
  -loglevel $LOGLEVEL \
  $WEBSOCKETS_URL/$SECRET

echo "Finished streaming"
