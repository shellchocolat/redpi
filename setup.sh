#!/bin/bash

read -p "[*] PI [1] or KALI [2]: " answer_os
if [ "$answer_os" != "1" ] || [ "$answer_os" != "2" ]; then
	echo "[-] please choose a value"
	exit 1
fi

add-apt-repository ppa:certbot/certbot

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
apt-get install -y netdiscover
apt-get install -y nmap  
apt-get install -y docker.io
apt-get install -y eog
apt-get install -y feh
atp-get install -y kpcli
apt-get install -y python-bluez 
apt-get install -y python-requests
apt-get install -y python-urllib3
apt-get install -y ppp 
apt-get install -y xprobe2 
apt-get install -y sg3-utils 
apt-get install -y flameshot
apt-get install -y fonts-powerline
apt-get install -y netdiscover 
apt-get install -y macchanger 
apt-get install -y unzip
apt-get install -y xserver-xorg-input-synaptics
apt-get install -y vim
apt-get install -y autossh
apt-get install -y swaks
apt-get install -y kpcli
apt-get install -y openssh-client
apt-get install -y onesixtyone 
apt-get install -y bridge-utils 
apt-get install -y sqlite3 libsqlite3-dev
apt-get install -y ettercap-text-only 
apt-get install -y ike-scan 
apt-ge	install -y proxychains
apt-get install -y zsh
apt-get install -y ranger
apt-get install -y edb-debugger
apt-get install -y postgresql
apt-get install -y iodine
apt-get install -y ptunnel
apt-get install -y python-certbot-apache

pip install crackmapexec
pip install python-nmap 
pip install optparse-pretty 
pip install netaddr 
pip install prettytable 
pip install ipaddress

cd .. # go out of the redpi directory

mkdir Tools
cd Tools
wget https://raw.githubusercontent.com/sleventyeleven/linuxprivchecker/master/linuxprivchecker.py
wget https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh
git clone https://github.com/lanjelot/patator.git
git clone https://github.com/smicallef/spiderfoot.git
git clone https://github.com/ztgrace/changeme.git
git clone https://github.com/ANSSI-FR/polichombr.git
git clone https://github.com/Proxmark/proxmark3.git
git clone https://github.com/sensepost/ruler.git
git clone https://github.com/SabyasachiRana/WebMap.git
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
python setup.py install
cd .. 

# install warberry
read -p "[*] do yo want to install warrberry? [y/N] " answer_warberry
if [ "$answer_warberry" == "y" ] || [ "$answer_warberry" == "Y" ]; then
	git clone https://github.com/secgroundzero/warberry.git
	cd warberry
	bash setup.sh
	cd ..
fi

cd .. 

# vim configuration
echo "set number" >> /etc/vim/vimrc
echo "set tabstop=4" >> /etc/vim/vimrc
echo "colorscheme delek" >> /etc/vim/vimrc

# install metasploit
if [ "$answer_os" == "1" ]; then
	read -p "[*] do you want to install metasploit? [y/N] " answer_metasploit
	if [ "$answer_metasploit" == "y" ] || [ "$answer_metasploit" == "Y" ]; then
		curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall
	fi
fi

# setup access point on the pi
if [ "$answer_os" == "1" ]; then
	read -p "[*] do you want to setup an access point? [y/N] " answer_access_point
	if [ "$answer_access_point" == "y" ] || [ "$answer_access_point" == "Y" ]; then
		apt-get install -y dnsmasq
		apt-get install -y hostapd
		# configuring a static ip
		echo "interface wlan0" >> /etc/dhcpd.conf
		echo "static ip_address=192.168.4.1/24" >> /etc/dhcpd.conf
		echo "nohook wpa_supplicant" >> /etc/dhcpd.conf
		systemctl restart dhcpcd
		# configuring the dhcp server (dnsmasq)
		mv /etc/dnsmasq.conf /etc/dnsmasq.conf.bak
		touch /etc/dnsmasq.conf
		echo "interface=wlan0" >> /etc/dnsmasq.conf
		echo "dhcp-range=192.168.4.2,192.168.4.20,255.255.255.0,24h" >> /etc/dnsmasq.conf
		systemctl reload dnsmasq
		# configuring the access point host software (hostapd)
		touch /etc/hostapd/hostapd.conf
		read -p "[*] access point name (ssid): " ssid
		read -p "[*] wpa_passphrase (>8 chars): " passphrase
		echo "interface=wlan0" >> /etc/hostapd/hostapd.conf
		echo "driver=nl80211" >> /etc/hostapd/hostapd.conf
		echo "ssid=$ssid" >> /etc/hostapd/hostapd.conf
		echo "hw_mode=g" >> /etc/hostapd/hostapd.conf
		echo "channel=7" >> /etc/hostapd/hostapd.conf
		echo "wmm_enabled=0" >> /etc/hostapd/hostapd.conf
		echo "macaddr_acl=0" >> /etc/hostapd/hostapd.conf
		echo "auth_algs=1" >> /etc/hostapd/hostapd.conf
		echo "ignore_broadcast_ssid=0" >> /etc/hostapd/hostapd.conf
		echo "wpa=2" >> /etc/hostapd/hostapd.conf
		echo "wpa_passphrase=$passphrase" >> /etc/hostapd/hostapd.conf
		echo "wpa_key_mgmt=WPA-PSK" >> /etc/hostapd/hostapd.conf
		echo "wpa_pairwise=TKIP" >> /etc/hostapd/hostapd.conf
		echo "rsn_pairwise=CCMP" >> /etc/hostapd/hostapd.conf
		
		echo 'DAEMON_CONF="/etc/hostapd/hostapd.conf"' >> /etc/default/hostapd
	
		systemctl unmask hostapd
		systemctl enable hostapd
		systemctl start hostapd
	fi
fi


# install node js on kali
if [ "$answer_os" == "2" ]; then
	read -p "[*] do you want to install nodejs (npm and so on..) VERRRRRRY LOOOOOONG? [y/N] " answer_nodejs
	if [ "$answer_nodejs" == "y" ] || [ "$answer_nodejs" == "Y" ]; then
		apt-get -y install python g++ make checkinstall fakeroot
		mkdir temp
		cd temp
		wget -N http://nodejs.org/dist/node-latest.tar.gz
		tar xzvf node-latest.tar.gz && cd node-v*
		./configure
		fakeroot checkinstall -y --install=no --pkgversion $(echo $(pwd) | sed -n -re's/.+node-v(.+)$/\1/p') make -j$(($(nproc)+1)) install
		dpkg -i node_*
	fi	
fi

# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
