#!/bin/bash

bash <(curl -s https://raw.githubusercontent.com/ivanovsergey93/nodes/main/install_docker.sh)

mkdir -p $HOME/graph-indexer
wget -O $HOME/graph-indexer/docker-compose.yml https://raw.githubusercontent.com/ivanovsergey93/nodes/main/graph/docker-compose.yml
wget -O $HOME/graph-indexer/prometheus.yml https://raw.githubusercontent.com/ivanovsergey93/nodes/main/graph/prometheus.yml

cd $HOME/graph-indexer/
docker-compose up -d