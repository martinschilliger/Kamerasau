# Kamerasau

Stream from Raspberry Camera Module to RTMP

# Install

SSH into your RaspberryPi, make shure git is installed and git pull in pi home directory:

```shell
$ git clone git@github.com:martinschilliger/Kamerasau.git
$ cd Kamerasau
$ sudo chmod +x stream.sh
$ sudo chmod +x update.sh

```

Create the service for update on startup and then continuously run

`/lib/systemd/system/kamerasauUpdate.service`

```shell
[Unit]
Description=Update Kamerasau
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/home/pi/Kamerasau/update.sh
Restart=no
RemainAfterExit=true

[Install]
WantedBy=multi-user.target
```

`/lib/systemd/system/kamerasau.service`

```shell
[Unit]
Description=Kamerasau
After=multi-user.target

[Service]
Type=simple
ExecStart=/home/pi/Kamerasau/jsmpeg.sh
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
```

Enable and start the services

```shell
$ sudo chmod 644 /lib/systemd/system/kamerasauUpdate.service
$ sudo chmod 644 /lib/systemd/system/kamerasau.service
$ sudo systemctl daemon-reload
$ sudo systemctl enable kamerasauUpdate.service
$ sudo systemctl enable kamerasau.service
$ sudo systemctl start kamerasauUpdate.service
$ sudo systemctl start kamerasau.service
```
