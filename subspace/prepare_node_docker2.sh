#!/bin/bash
cd $HOME

source ~/.bash_profile

systemctl stop starknetd
rm -rf ~/pathfinder/py/goerli.sqlite
rm -rf ~/pathfinder/py/goerli.sqlite-wal
rm -rf ~/pathfinder/py/goerli.sqlite-shm

mkdir subspace
cd subspace
mkdir farmer-data
mkdir node-data
chmod a+rw -R farmer-data
chmod a+rw -R node-data
wget -O docker-compose.yml https://raw.githubusercontent.com/ivanovsergey93/nodes/main/subspace/docker-compose.yml

docker-compose up -d

sleep 30
docker-compose logs -t --tail 15 node
docker-compose logs -t --tail 15 farmer