#!/bin/bash

# Make pushgateway user
sudo adduser --no-create-home --disabled-login --shell /bin/false --gecos "Pushgateway Monitoring User" pushgateway

# Make directories and dummy files necessary for pushgateway
sudo mkdir /etc/pushgateway
sudo mkdir /var/lib/pushgateway

# Assign ownership of the files above to pushgateway user
sudo chown -R pushgateway:pushgateway /etc/pushgateway
sudo chown pushgateway:pushgateway /var/lib/pushgateway

# Download pushgateway and copy utilities to where they should be in the filesystem
VERSION=$(curl https://raw.githubusercontent.com/prometheus/pushgateway/master/VERSION)
wget https://github.com/prometheus/pushgateway/releases/download/v${VERSION}/pushgateway-${VERSION}.linux-amd64.tar.gz
tar xvzf pushgateway-${VERSION}.linux-amd64.tar.gz

sudo cp pushgateway-${VERSION}.linux-amd64/pushgateway /usr/local/bin/
sudo cp pushgateway-${VERSION}.linux-amd64/promtool /usr/local/bin/
sudo cp -r pushgateway-${VERSION}.linux-amd64/consoles /etc/pushgateway
sudo cp -r pushgateway-${VERSION}.linux-amd64/console_libraries /etc/pushgateway

# Assign the ownership of the tools above to pushgateway user
sudo chown -R pushgateway:pushgateway /etc/pushgateway/consoles
sudo chown -R pushgateway:pushgateway /etc/pushgateway/console_libraries
sudo chown pushgateway:pushgateway /usr/local/bin/pushgateway
sudo chown pushgateway:pushgateway /usr/local/bin/promtool

# Populate configuration files
cat ./pushgateway/pushgateway.service | sudo tee /etc/systemd/system/pushgateway.service

# systemd
sudo systemctl daemon-reload
sudo systemctl enable pushgateway
sudo systemctl start pushgateway

# Installation cleanup
rm pushgateway-${VERSION}.linux-amd64.tar.gz
rm -rf pushgateway-${VERSION}.linux-amd64
