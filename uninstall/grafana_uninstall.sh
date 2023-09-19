#!/bin/bash

sudo systemctl stop grafana-server

sudo systemctl disable grafana-server

sudo apt-get remove grafana -y

sudo apt-get purge grafana -y

sudo apt-get autoremove
sudo apt-get clean
