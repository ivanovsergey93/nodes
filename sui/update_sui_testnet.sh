systemctl stop suid
systemctl disable suid 
rm -rf /usr/local/bin/sui
rm -rf /usr/local/bin/sui-node


sudo tee <<EOF >/dev/null /etc/systemd/system/sui.service
[Unit]
  Description=SUI Node
  After=network-online.target
[Service]
  User=$USER
  ExecStart=/usr/bin/sui-node --config-path $HOME/.sui/fullnode.yaml
  Restart=on-failure
  RestartSec=3
  LimitNOFILE=65535
[Install]
  WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable sui &>/dev/null
sudo systemctl restart sui
