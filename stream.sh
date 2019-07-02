#!/bin/sh

source ./kamerasau.conf

echo "Starting Stream to $RTMP_URL"

raspivid -o - -t 0 --rotation 180 --vstab -w $WIDTH -h $HEIGHT -fps $FPS -b $BITRATE -g $KEYFRAME | \
	ffmpeg \
  -re -f h264 -i - -vcodec copy \
  -an \
  -g $KEYFRAME -strict experimental \
  -tune zerolatency \
  -preset $QUAL -flags +global_header \
  -maxrate 1.5M -bufsize 3M \
  -loglevel $LOGLEVEL \
	-f flv $RTMP_URL/$STREAM_KEY

echo "Finished streaming"

exit 0
