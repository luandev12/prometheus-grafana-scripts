#!/bin/bash

# Make prometheus user
sudo adduser --no-create-home --disabled-login --shell /bin/false --gecos "Loki Logs User" promtail

# Make directories and dummy files necessary for prometheus
sudo mkdir /etc/promtail
sudo mkdir /var/lib/promtail
sudo touch /etc/promtail/promtail-config.yml

# Download prometheus and copy utilities to where they should be in the filesystem
VERSION=2.9.0
wget https://github.com/grafana/loki/releases/download/v${VERSION}/promtail-linux-amd64.zip
unzip promtail-linux-amd64.zip
chmod a+x "promtail-linux-amd64"

sudo cp promtail-linux-amd64 /usr/local/bin/promtail

# Assign the ownership of the tools above to promtail user
sudo chown promtail:promtail /usr/local/bin/promtail

# Populate configuration files
cat ./promtail/promtail-config.yml | sudo tee /etc/promtail/promtail-config.yml
cat ./promtail/promtail.service | sudo tee /etc/systemd/system/promtail.service

# systemd
sudo systemctl daemon-reload
sudo systemctl enable promtail
sudo systemctl start promtail

rm promtail-linux-amd64.zip
rm -rf promtail-linux-amd64
