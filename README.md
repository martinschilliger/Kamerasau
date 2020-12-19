# Kamerasau

Stream from Raspberry Camera Module to [JSMPEG](https://jsmpeg.com)

# Install

Prepare your RaspberrPi with the newest [Raspberry Pi OS Lite](https://www.raspberrypi.org/software/operating-systems/). Then SSH into your RaspberryPi, update, upgrade and make shure git, ffmpeg and the camera module is installed. Then `git clone` in pi home directory:

```console
pi@kamerasau1:~ $ git clone git@github.com:martinschilliger/Kamerasau.git
pi@kamerasau1:~ $ cd Kamerasau/
pi@kamerasau1:~/Kamerasau $ sudo chmod +x jsmpeg.sh
pi@kamerasau1:~/Kamerasau $ sudo chmod +x update.sh
```

# Configuration

Copy the configuration file and adjust settings to your need. The example is based on our setting with a RaspberryPi Zero W and a bad network connectivity. If you find optimizations we love to hear from you! 🤗

```console
pi@kamerasau1:~/Kamerasau $ cp example-config.txt kamerasau.conf
pi@kamerasau1:~/Kamerasau $ nano kamerasau.conf
```

# Autostart

Create the service to update the script on startup (simple `git pull` and set executions rights) and then continuously run it. Based on http://www.diegoacuna.me/how-to-run-a-script-as-a-service-in-raspberry-pi-raspbian-jessie/

`/lib/systemd/system/kamerasauUpdate.service`

```shell
[Unit]
Description=Update Kamerasau
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
User=pi
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
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=pi
ExecStart=/home/pi/Kamerasau/jsmpeg.sh
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
```

Enable and start the services. `systemd-networkd-wait-online.service` is used to wait for the network before starting to stream. 🤷🏻‍♂️

```console
pi@kamerasau1:~ $ sudo chmod 644 /lib/systemd/system/kamerasauUpdate.service
pi@kamerasau1:~ $ sudo chmod 644 /lib/systemd/system/kamerasau.service
pi@kamerasau1:~ $ sudo systemctl daemon-reload
pi@kamerasau1:~ $ sudo systemctl enable systemd-networkd-wait-online.service
pi@kamerasau1:~ $ sudo systemctl enable kamerasauUpdate.service
pi@kamerasau1:~ $ sudo systemctl enable kamerasau.service
pi@kamerasau1:~ $ sudo systemctl start kamerasauUpdate.service
pi@kamerasau1:~ $ sudo systemctl start kamerasau.service
```
