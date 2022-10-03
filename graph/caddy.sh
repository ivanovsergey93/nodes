function your_domain {
  if [ ! $your_domain ]; then
  echo -e "Enter indexer domain name"
  line
  read your_domain
  fi
}

your_domain
line

sudo tee <<EOF >/dev/null $HOME/Caddyfile
https://$your_domain {
    reverse_proxy localhost:8000
}

wss://$your_domain {
    reverse_proxy localhost:8001
}

https://$your_domain/prometheus/* {
    reverse_proxy localhost:29090
}
EOF

wget https://github.com/caddyserver/caddy/releases/download/v2.4.6/caddy_2.4.6_linux_amd64.tar.gz
tar -vxf caddy_2.4.6_linux_amd64.tar.gz
sudo mv caddy /usr/bin/
rm -f caddy_2.4.6_linux_amd64.tar.gz

sudo tee <<EOF >/dev/null /etc/systemd/system/caddy.service
[Unit]
Description=Caddy
Documentation=https://caddyserver.com/docs/
After=network.target

[Service]
User=root
ExecStart=/usr/bin/caddy run --config /root/Caddyfile
ExecReload=/usr/bin/caddy reload --config /root/Caddyfile
TimeoutStopSec=5s
LimitNOFILE=1048576
LimitNPROC=512
PrivateTmp=true
ProtectSystem=full
AmbientCapabilities=CAP_NET_BIND_SERVICE

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl start caddy
sudo systemctl enable caddy