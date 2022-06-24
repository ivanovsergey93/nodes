#!/bin/bash
cd $HOME
apt update && apt install curl -y && apt purge docker docker-engine docker.io containerd docker-compose -y
rm /usr/bin/docker-compose /usr/local/bin/docker-compose
curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
systemctl restart docker
curl -SL https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose