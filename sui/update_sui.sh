#!/bin/bash
systemctl stop suid
rm -rf /var/sui/db/* /var/sui/genesis.blob
source $HOME/.cargo/env
cd $HOME/sui
git pull
cargo build --release -p sui-node
mv ~/sui/target/release/sui-node /usr/local/bin/
wget -O /var/sui/genesis.blob https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob
systemctl restart suid