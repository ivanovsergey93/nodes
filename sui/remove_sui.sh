#!/bin/bash

sudo systemctl stop suid
sudo systemctl disable suid
rm -rf ~/sui /var/sui/
rm /etc/systemd/system/suid.service
rm /usr/local/bin/sui-node
rm sui.sh