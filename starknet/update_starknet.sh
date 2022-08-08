#!/bin/bash
cd ~/pathfinder
git fetch
git checkout v0.3.0-alpha
cd py
python3 -m venv .venv
source .venv/bin/activate
PIP_REQUIRE_VIRTUALENV=true pip install --upgrade pip
PIP_REQUIRE_VIRTUALENV=true pip install -r requirements-dev.txt
cd ~/pathfinder

cargo build --release --bin pathfinder
mv ~/pathfinder/target/release/pathfinder /usr/local/bin/

source $HOME/.bash_profile

systemctl restart starknetd
pathfinder -V
