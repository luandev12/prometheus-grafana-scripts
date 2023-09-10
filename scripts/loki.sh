#!/bin/bash

# Make prometheus user
sudo adduser --no-create-home --disabled-login --shell /bin/false --gecos "Loki Logs User" loki

# Make directories and dummy files necessary for prometheus
sudo mkdir /etc/loki
sudo mkdir /var/lib/loki
sudo touch /etc/loki/config-loki.yml

# Download prometheus and copy utilities to where they should be in the filesystem
VERSION=2.9.0
wget https://github.com/grafana/loki/releases/download/v${VERSION}/loki-linux-amd64.zip
unzip loki-linux-amd64.zip
chmod a+x "loki-linux-amd64"

sudo cp loki-linux-amd64 /usr/local/bin/loki

# Assign the ownership of the tools above to loki user
sudo chown loki:loki /usr/local/bin/loki

# Populate configuration files
cat ./loki/config-loki.yml | sudo tee /etc/loki/config-loki.yml
cat ./loki/loki.service | sudo tee /etc/systemd/system/loki.service

# systemd
sudo systemctl daemon-reload
sudo systemctl enable loki
sudo systemctl start loki

rm loki-linux-amd64.zip
rm -rf loki-linux-amd64
