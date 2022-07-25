#!/bin/bash

source $HOME/.cargo/env
source $HOME/.profile
source $HOME/.bashrc
cp $HOME/sui/target/release/{sui,sui-node,sui-faucet} /usr/bin/
wget -qO $HOME/.sui/genesis.blob https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob
cp $HOME/sui/crates/sui-config/data/fullnode-template.yaml \
$HOME/.sui/fullnode.yaml
sed -i -e "s%db-path:.*%db-path: \"$HOME/.sui/db\"%; "\
"s%metrics-address:.*%metrics-address: \"0.0.0.0:9184\"%; "\
"s%json-rpc-address:.*%json-rpc-address: \"0.0.0.0:9000\"%; "\
"s%genesis-file-location:.*%genesis-file-location: \"$HOME/.sui/genesis.blob\"%; " $HOME/.sui/fullnode.yaml
echo "Билд закончен, переходим к инициализации ноды"
echo "-----------------------------------------------------------------------------"
sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF
sudo systemctl restart systemd-journald

sudo tee <<EOF >/dev/null /etc/systemd/system/sui.service
[Unit]
  Description=SUI Node
  After=network-online.target
[Service]
  User=$USER
  ExecStart=/usr/bin/sui-node --config-path /root/.sui/fullnode.yaml
  Restart=on-failure
  RestartSec=3
  LimitNOFILE=65535
[Install]
  WantedBy=multi-user.target
EOF

sudo systemctl enable sui &>/dev/null
sudo systemctl daemon-reload
sudo systemctl restart sui

echo "Fullnode sui успешно установлена"
echo "-----------------------------------------------------------------------------"