#!/bin/bash

# Uninstall prometheus
sudo deluser promtail

sudo rm -rf /etc/promtail
sudo rm -rf /var/lib/promtail

sudo rm /usr/local/bin/promtail

sudo rm /etc/systemd/system/promtail.service
sudo systemctl daemon-reload
