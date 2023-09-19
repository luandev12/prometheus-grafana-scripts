#!/bin/bash

# Uninstall prometheus
sudo deluser loki

sudo rm -rf /etc/loki
sudo rm -rf /var/lib/loki

sudo rm /usr/local/bin/loki

sudo rm /etc/systemd/system/loki.service
sudo systemctl daemon-reload
