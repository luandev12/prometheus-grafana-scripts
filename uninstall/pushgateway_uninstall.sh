#!/bin/bash

# Uninstall prometheus
sudo deluser pushgateway

sudo rm -rf /etc/pushgateway
sudo rm -rf /var/lib/pushgateway

sudo rm /usr/local/bin/pushgateway

sudo rm /etc/systemd/system/pushgateway.service
sudo systemctl daemon-reload
