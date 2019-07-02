# Kamerasau

Stream from Raspberry Camera Module to RTMP

# Install

SSH into your RaspberryPi, make shure git is installed and git pull in pi home directory:

```shell
git clone git@github.com:martinschilliger/Kamerasau.git
```

Make shure to auto start the script with the code in `/etc/rc.local`:

```shell
# Kamerasau streaming
/home/pi/Kamerasau/stream.sh
```
