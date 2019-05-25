#!/bin/bash

apt-get update
apt-get -y upgrade
apt-get install -y git
apt-get install -y python-pip 
apt-get install -y python3-pip 
apt-get install -y libssl-dev libffi-dev python-dev build-essential
apt-get install -y nbtscan 
apt-get install -y dnsutils
apt-get install -y python-scapy
apt-get install -y wireshark-common 
apt-get install -y tcpdump 
apt-get install -y nmap  
apt-get install -y python-bluez 
apt-get install -y python-requests
apt-get install -y python-urllib3
apt-get install -y ppp 
apt-get install -y xprobe2 
apt-get install -y sg3-utils 
apt-get install -y netdiscover 
apt-get install -y macchanger 
apt-get install -y unzip
apt-get install -y vim
apt-get install -y autossh
apt-get install -y swaks
apt-get install -y openssh-client
apt-get install -y onesixtyone 
apt-get install -y bridge-utils 
apt-get install -y sqlite3 libsqlite3-dev
apt-get install -y ettercap-text-only 
apt-get install -y ike-scan 
apt-ge	install -y proxychains
apt-get install -y zsh
apt-get install -r ranger

wget http://seclists.org/nmap-dev/2016/q2/att-201/clamav-exec.nse -O /usr/share/nmap/scripts/clamav-exec.nse

pip install crackmapexec
pip install python-nmap 
pip install optparse-pretty 
pip install netaddr 
pip install prettytable 
pip install ipaddress

mkdir Tools
cd Tools
git clone https://github.com/SpiderLabs/Responder.git
git clone https://github.com/portcullislabs/enum4linux.git
git clone https://github.com/samratashok/nishang.git
git clone https://github.com/PowerShellMafia/PowerSploit.git
git clone https://github.com/EmpireProject/Empire.git
cd Empire/setup
bash install.sh
cd ../..
git clone https://github.com/byt3bl33d3r/DeathStar.git
cd DeathStar
pip3 install -r requirements.txt
cd ..
git clone https://github.com/AlessandroZ/LaZagne.git
cd LaZagne
pip install -r requirements.txt
wget https://github.com/AlessandroZ/LaZagne/releases/download/v2.4.2/lazagne.exe
cd ..
wget https://raw.githubusercontent.com/besimorhino/powercat/master/powercat.ps1
git clone https://github.com/klsecservices/rpivot.git
cd rpivot
wget https://github.com/klsecservices/rpivot/releases/download/v1.0/client.exe
cd ..
git clone https://github.com/sense-of-security/ADRecon.git
git clone https://github.com/pentestmonkey/windows-privesc-check.git
git clone https://github.com/darkoperator/dnsrecon.git
git clone https://github.com/dafthack/MailSniper.git
git clone https://github.com/SecureAuthCorp/impacket.git
cd impacket
sudo python setup.py install
cd ..

cd ..

echo "set number" >> /etc/vim/vimrc
echo "set tabstop=4" >> /etc/vim/vimrc
echo "colorscheme delek" >> /etc/vim/vimrc

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
