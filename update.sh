#!/bin/sh

cd /home/pi/Kamerasau

git pull --rebase --autostash

sudo chmod +x stream.sh
sudo chmod +x update.sh
