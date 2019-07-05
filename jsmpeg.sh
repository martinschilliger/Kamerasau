#!/bin/sh

. /home/pi/Kamerasau/kamerasau.conf

echo "Starting Stream to $RTMP_URL"

ffmpeg \
  -f v4l2 \
    -framerate $FPS -video_size ${WIDTH}x${HEIGHT} -i /dev/video0 \
  -f mpegts \
     -vf "vflip,hflip" -codec:v mpeg1video -s ${WIDTH}x${HEIGHT} -b:v $VBR -bf 0 \
  -loglevel $LOGLEVEL \
  $WEBSOCKETS_URL/$SECRET

echo "Ending Stream"
exit 0;