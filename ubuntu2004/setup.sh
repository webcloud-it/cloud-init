#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# docker
cat > /etc/docker/daemon.json <<"EOF"
{
	"log-driver": "json-file",
	"log-opts": {
		"max-size": "5m",
		"max-file": "1"
	}
}

EOF
bash <(curl -Ss -L https://releases.rancher.com/install-docker/20.10.sh)

# date and time
apt update
apt install -yq --no-install-recommends ntp
timedatectl set-timezone Europe/Rome
timedatectl set-ntp false
service ntp restart

# dns
apt update
apt install -yq --no-install-recommends resolvconf
echo nameserver 1.1.1.1 > /etc/resolvconf/resolv.conf.d/head
echo nameserver 8.8.8.8 >> /etc/resolvconf/resolv.conf.d/head
resolvconf -u

# misc
echo 'set background=dark' >> /root/.vimrc
rm /etc/apt/apt.conf.d/20auto-upgrades
