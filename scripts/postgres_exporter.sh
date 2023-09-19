#!/bin/bash

# Make postgres user
sudo adduser --no-create-home --disabled-login --shell /bin/false --gecos "Postgresql Logs User" postgres

# Make directories and dummy files necessary for postgres
sudo mkdir /etc/postgres_exporter
sudo mkdir /var/lib/postgres_exporter
sudo touch /etc/postgres_exporter/postgres_exporter.env

# Assign ownership of the files above to postgres user
sudo chown -R postgres:postgres /etc/postgres_exporter

# Download postgres exporter and copy utilities to where they should be in the filesystem
VERSION=0.13.2
NAME=postgres_exporter
wget https://github.com/prometheus-community/${NAME}/releases/download/v${VERSION}/${NAME}-${VERSION}.linux-amd64.tar.gz
tar xvzf ${NAME}-${VERSION}.linux-amd64.tar.gz

sudo cp ${NAME}-${VERSION}.linux-amd64/postgres_exporter /usr/local/bin/${NAME}

sudo chown postgres:postgres /usr/local/bin/${NAME}

# Populate configuration files
cat ./exporters/postgres/postgres_exporter.env | sudo tee /etc/postgres_exporter/postgres_exporter.env
cat ./exporters/postgres/postgres_exporter.service | sudo tee /etc/systemd/system/prometheus.service

# systemd
sudo systemctl daemon-reload
sudo systemctl enable ${NAME}
sudo systemctl start ${NAME}
sudo systemctl restart ${NAME}

# Installation cleanup
rm ${NAME}-${VERSION}.linux-amd64.tar.gz
rm -rf ${NAME}-${VERSION}.linux-amd64