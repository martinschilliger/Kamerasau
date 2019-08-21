#!/bin/sh

cd /home/pi/Kamerasau

git pull --rebase --autostash

# apply execution rights
sudo chmod +x jsmpeg.sh
sudo chmod +x update.sh
