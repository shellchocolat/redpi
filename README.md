# redpi
red team tools to install into a rpi

## install

```
sudo ./setup.sh
```

## autossh

In order to have a remote connexion to the raspberry:
```bash
ssh-keygen -t rsa -b 4096
ssh-copy-id ~/.ssh/id_rsa.pub user@domain -> to copy keys to the remote server
ssh user@domain -> to verify that we do not need password anymore to connect
```

Then create a service that will autossh to your domain at boot time:
```bash
sudo vim /etc/systemd/system/autossh.service

[Unit]
Description="une description du service"
Wants=network-online.target ssh.target
After=network-online.target ssh.target

[Service]
#Type=simple
User=pi
Environment="AUTOSSH_GATETIME 0"
ExecStart=/usr/bin/autossh -N -R 2222:localhost:22 user@domain -p 22 -i ~/.ssh/id_rsa
Restart=always
RestartSec=60

[Install]
WantedBy=multi-user.target
```

You need to reload the services list:

```bash
sudo systemctl daemon-reload
sudo systemctl enable autossh.service
sudo reboot
```

Then you could connect to your domain, then:
```bash
ssh pi@localhost -p 2222
```
