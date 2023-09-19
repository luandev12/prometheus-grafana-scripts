
#!/bin/bash

# Make prometheus user
sudo adduser --no-create-home --disabled-login --shell /bin/false --gecos "Loki Logs User" nginx

# Make directories and dummy files necessary for prometheus
sudo touch /etc/nginx/sites-enabled/luandev.conf

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install nginx

# Assign the ownership of the tools above to promtail user
sudo chown nginx:nginx /etc/nginx/sites-enabled

cat ./nginx-reverse-proxy/luandev.conf | sudo tee /etc/nginx/sites-enabled/luandev.conf

sudo service nginx restart