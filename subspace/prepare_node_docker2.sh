#!/bin/bash
cd $HOME

source ~/.bash_profile


mkdir subspace
cd subspace
mkdir farmer-data
mkdir node-data
chmod a+rw -R farmer-data
chmod a+rw -R node-data
wget -O docker-compose.yml https://raw.githubusercontent.com/ivanovsergey93/nodes/main/subspace/docker-compose.yml

docker-compose up -d
