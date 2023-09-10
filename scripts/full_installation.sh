#!/bin/bash

# Ubuntu 16.04

# Prometheus installation. It's a lousy script though.

# Example:
# chmod +x full_installation.sh
# sudo pwd
# ./full_installation.sh

./prometheus.sh
./node_exporter.sh
./blackbox.sh
./pushgateway.sh
./alertmanager.sh
./grafana.sh
./loki.sh
./promtail.sh

echo "Installation complete."
echo "Visit port 3000 to view grafana dashboards."
