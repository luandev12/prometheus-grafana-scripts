#!/bin/bash

bash ./uninstall/prometheus_uninstall.sh
bash ./uninstall/node_uninstall.sh
bash ./uninstall/blackbox_uninstall.sh
bash ./uninstall/alertmanager_uninstall.sh
bash ./uninstall/grafana_uninstall.sh
bash ./uninstall/loki_uninstall.sh
bash ./uninstall/promtail_uninstall.sh
bash ./uninstall/pushgateway_uninstall.sh

# Uninstall grafana
# ???
