#!/bin/bash
cd $HOME

source ~/.bash_profile

mkdir subspace
cd subspace
mkdir farmer-data
mkdir node-data
chmod a+rw -R farmer-data
chmod a+rw -R node-data
wget https://raw.githubusercontent.com/ivanovsergey93/nodes/main/subspace/docker-compose.yml


cd $HOME
wget https://raw.githubusercontent.com/ivanovsergey93/nodes/main/install_docker.sh
chmod +x install_docker.sh
./install_docker.sh

cd subspace
docker-compose up -d

sleep 30
docker-compose logs -t --tail 15 node
docker-compose logs -t --tail 15 farmer