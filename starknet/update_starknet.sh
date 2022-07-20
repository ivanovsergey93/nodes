#!/bin/bash
cd ~/pathfinder
git fetch
git checkout v0.2.6-alpha
cd py
source .venv/bin/activate
PIP_REQUIRE_VIRTUALENV=true pip install --upgrade pip
PIP_REQUIRE_VIRTUALENV=true pip install -r requirements-dev.txt
cd ~/pathfinder

cargo build --release --bin pathfinder
mv ~/pathfinder/target/release/pathfinder /usr/local/bin/

systemctl restart starknetd
pathfinder -V