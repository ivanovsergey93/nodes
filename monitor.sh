#!/bin/bash
cd $HOME
if [ ! $MONITOR_OWNER ]; then
    read -p "Введите свой ник, например телеграмм(без @): " MONITOR_OWNER
    echo 'export OWNER='$MONITOR_OWNER >> $HOME/.profile
    . ~/.profile
fi
echo 'Владелец: ' $MONITOR_OWNER
sleep 1
if [ ! $MONITOR_HOSTNAME ]; then
    read -p "Введите название своего сервера: " MONITOR_HOSTNAME
    echo 'export HOSTNAME='$MONITOR_HOSTNAME >> $HOME/.profile
    . ~/.profile
fi
echo 'Название вашего сервера: ' $MONITOR_HOSTNAME
sleep 1


sudo systemctl stop prometheus && systemctl disable prometheus

sudo mkdir /etc/prometheus

sudo apt install wget -y
mkdir ~/vmutils
wget https://github.com/VictoriaMetrics/VictoriaMetrics/releases/download/v1.63.0/vmutils-amd64-v1.63.0.tar.gz
tar xvf vmutils-amd64-v1.63.0.tar.gz -C ~/vmutils
rm -rf vmutils-amd64-v1.63.0.tar.gz

sudo tee <<EOF >/dev/null /etc/prometheus/prometheus.yml
global:
  scrape_interval: 30s
  evaluation_interval: 30s
  external_labels:
    owner: '$MONITOR_OWNER'
    hostname: '$MONITOR_HOSTNAME'
scrape_configs:
  - job_name: "node_exporter"
    scrape_interval: 30s
    static_configs:
      - targets: ["localhost:9100"]
    relabel_configs:
      - source_labels: [__address__]
        regex: '.*'
        target_label: instance
        replacement: '$MONITOR_HOSTNAME'
EOF

sudo tee <<EOF >/dev/null /etc/systemd/system/vmagent.service
[Unit]
  Description=vmagent Monitoring
  Wants=network-online.target
  After=network-online.target
[Service]
  User=$USER
  Type=simple
  ExecStart=$HOME/vmutils/vmagent-prod \
  -promscrape.config=/etc/prometheus/prometheus.yml \
  -remoteWrite.url=http://doubletop:doubletop@vm.razumv.tech:8080/api/v1/write
  ExecReload=/bin/kill -HUP $MAINPID
[Install]
  WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload && sudo systemctl enable vmagent && sudo systemctl restart vmagent

wget https://github.com/prometheus/node_exporter/releases/download/v1.1.2/node_exporter-1.1.2.linux-amd64.tar.gz
tar xvf node_exporter-1.1.2.linux-amd64.tar.gz
sudo cp node_exporter-1.1.2.linux-amd64/node_exporter /usr/local/bin
rm -rf node_exporter-1.1.2.linux-amd64*

sudo tee <<EOF >/dev/null /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target
[Service]
User=$USER
Type=simple
ExecStart=/usr/local/bin/node_exporter --web.listen-address=":9100"
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload && sudo systemctl enable node_exporter && sudo systemctl restart node_exporter

echo "Monitoring Installed"