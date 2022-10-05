#!/bin/bash

#nano /etc/needrestart/needrestart.conf $nrconf{restart} = 'l'; 
sed -i "s/#\$nrconf{kernelhints} = -1;/\$nrconf{kernelhints} = -1;/g" /etc/needrestart/needrestart.conf
sed -i "s/#\$nrconf{restart} = 'i';/\$nrconf{restart} = 'a';/g" /etc/needrestart/needrestart.conf

bash <(curl -s https://raw.githubusercontent.com/DOUBLE-TOP/tools/main/docker.sh)

mkdir -p $HOME/graph-indexer
wget -O $HOME/graph-indexer/docker-compose.yml https://raw.githubusercontent.com/ivanovsergey93/nodes/main/graph/docker-compose.yml
wget -O $HOME/graph-indexer/prometheus.yml https://raw.githubusercontent.com/ivanovsergey93/nodes/main/graph/prometheus.yml

cd $HOME/graph-indexer/
docker-compose up -d

wget -O caddy.sh https://raw.githubusercontent.com/DOUBLE-TOP/guides/main/graph/caddy.sh && chmod +x caddy.sh && ./caddy.sh

curl ifconfig.me
wget -O launch_indexer.sh https://raw.githubusercontent.com/ivanovsergey93/nodes/main/graph/launch_indexer.sh && chmod +x launch_indexer.sh && ./launch_indexer.sh