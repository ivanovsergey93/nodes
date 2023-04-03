sudo apt update
sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential git make ncdu -y
sudo apt install screen 

rpcs=("https://rpc-blockspacerace.pops.one/"
"https://rpc-1.celestia.nodes.guru/"
"https://rpc-2.celestia.nodes.guru/"
"https://celestia-testnet.rpc.kjnodes.com/"
"https://celestia.rpc.waynewayner.de/"
"https://rpc-blockspacerace.mzonder.com/"
"https://rpc-t.celestia.nodestake.top/"
"https://rpc-blockspacerace.ryabina.io/"
"https://celest-archive.rpc.theamsolutions.info/"
"https://blockspacerace-rpc.chainode.tech/"
"https://rpc-blockspacerace.suntzu.pro/"
"https://public.celestia.w3hitchhiker.com/"
"https://rpc.celestia.stakewith.us/"
"https://celestia-rpc.validatrium.club/"
"https://celrace-rpc.easy2stake.com/"
"http://rpc.celestia.blockscope.net/"
"https://rpc-celestia-testnet-blockspacerace.keplr.app/"
"http://celestiarpc.bloclick.com/"
"https://celestia-testnet-rpc.swiss-staking.ch/"
"https://rpc-blockspacerace.moonli.me/"
"http://rpc-celestia.gpvalidator.com/"
"https://rpc-celestia.activenodes.io/"
"https://rpc-testnet.celestia.forbole.com/")

array_length=${#rpcs[@]}
random_index=$((RANDOM % array_length))
RPC=${rpcs[$random_index]}
echo "Chose rpc: $RPC"

GO_VER="1.19.1"
cd $HOME
wget "https://golang.org/dl/go$GO_VER.linux-amd64.tar.gz"
sudo tar -C /usr/local -xzf "go$GO_VER.linux-amd64.tar.gz"
rm "go$GO_VER.linux-amd64.tar.gz"

echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile
source $HOME/.bash_profile

cd $HOME
rm -rf celestia-node
git clone https://github.com/celestiaorg/celestia-node.git
cd celestia-node/
git checkout tags/v0.8.0
make build -j8
make install
make cel-key 

HOST=$(curl ifconfig.me)

echo $HOST >> /root/celestia_info.txt

celestia light init --p2p.network blockspacerace >> /root/celestia_info.txt #write down output
cat /root/celestia_info.txt

sudo tee <<EOF >/dev/null /root/celestia-node/run.sh
celestia light start --core.ip $RPC --gateway --gateway.addr $HOST --gateway.port 26659 --p2p.network blockspacerace --metrics.tls=false --metrics --metrics.endpoint otel.celestia.tools:4318
EOF

chmod +x /root/celestia-node/run.sh

sudo tee <<EOF >/dev/null /etc/systemd/system/celestia.service
[Unit]
Description=Celestia service
After=network.target
StartLimitIntervalSec=0
[Service]
Type=simple
Restart=always
RestartSec=1
User=root
ExecStart=/bin/bash /root/celestia-node/run.sh

[Install]
WantedBy=multi-user.target
EOF


systemctl enable celestia
systemctl start celestia

sleep 60

AUTH_TOKEN=$(celestia light auth admin --p2p.network blockspacerace)

curl -X POST \
     -H "Authorization: Bearer $AUTH_TOKEN" \
     -H 'Content-Type: application/json' \
     -d '{"jsonrpc":"2.0","id":0,"method":"p2p.Info","params":[]}' \
     http://localhost:26658 >> /root/celestia_info.txt

cat /root/celestia_info.txt
