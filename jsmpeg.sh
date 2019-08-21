#!/bin/sh

# Loading configuration file
. /home/pi/Kamerasau/kamerasau.conf

echo "Apply configuration options"

if [ -n "$STARTUP_COMMANDS" ]; then
  $STARTUP_COMMANDS
fi

echo "Starting Stream to $WEBSOCKETS_URL"

ffmpeg \
  -f v4l2 \
    -hwaccel auto -framerate $FPS -thread_queue_size 4096 -video_size ${WIDTH}x${HEIGHT} -i /dev/video0 \
  -f mpegts \
    -codec:v mpeg1video -s ${WIDTH}x${HEIGHT} -b:v $VBR -bf 0 -flags2 +fast \
  -loglevel $LOGLEVEL \
  $WEBSOCKETS_URL/$SECRET

echo "Ending Stream"
exit 0;
