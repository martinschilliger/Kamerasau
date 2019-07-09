# Kamerasau

Stream from Raspberry Camera Module to RTMP

# Install

SSH into your RaspberryPi, make shure git is installed and git pull in pi home directory:

```console
pi@kamerasau1:~ $ git clone git@github.com:martinschilliger/Kamerasau.git
pi@kamerasau1:~ $ cd Kamerasau/
pi@kamerasau1:~/Kamerasau $ sudo chmod +x stream.sh
pi@kamerasau1:~/Kamerasau $ sudo chmod +x update.sh

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

```console
pi@kamerasau1:~ $ sudo chmod 644 /lib/systemd/system/kamerasauUpdate.service
pi@kamerasau1:~ $ sudo chmod 644 /lib/systemd/system/kamerasau.service
pi@kamerasau1:~ $ sudo systemctl daemon-reload
pi@kamerasau1:~ $ sudo systemctl enable kamerasauUpdate.service
pi@kamerasau1:~ $ sudo systemctl enable kamerasau.service
pi@kamerasau1:~ $ sudo systemctl start kamerasauUpdate.service
pi@kamerasau1:~ $ sudo systemctl start kamerasau.service
```
