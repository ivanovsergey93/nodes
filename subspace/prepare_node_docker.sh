#!/bin/bash
cd $HOME
wget https://raw.githubusercontent.com/ivanovsergey93/nodes/main/subspace/remove_old_node_nodes_guru.sh
chmod +x remove_old_node_nodes_guru.sh
./remove_old_node_nodes_guru.sh

mkdir subspace
cd subspace
mkdir farmer-data
mkdir node-data
chmod a+rw -R farmer-data
chmod a+rw -R node-data
wget https://raw.githubusercontent.com/ivanovsergey93/nodes/main/subspace/docker-compose.yml
touch .env
printf 'SUBSPACE_NODENAME="%s"\n' "$SUBSPACE_NODENAME" > .env
printf 'SUBSPACE_WALLET="%s"\n' "$SUBSPACE_WALLET" >> .env
printf 'SUBSPACE_PLOT="%s"\n' "$SUBSPACE_PLOT" >> .env

cd $HOME
wget https://raw.githubusercontent.com/ivanovsergey93/nodes/main/install_docker.sh
chmod +x install_docker.sh
./install_docker.sh

cd subspace
docker-compose up -d
