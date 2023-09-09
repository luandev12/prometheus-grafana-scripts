#!/bin/bash
 
os=$(lsb_release -d | awk -F ":" '{print$2}')
echo "Your operating system -$os"
#== Collect server ip address ==#
IP_ADDRESS=$(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}')
sudo apt-get install -y software-properties-common wget
#==	add grafana repo	==#
sudo apt-get install -y gnupg2 curl
curl https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo add-apt-repository -y "deb https://packages.grafana.com/oss/deb stable main"
sudo apt-get -y install grafana

#==	update	==#
sudo apt-get update
#==	install garafana package	==#
sudo apt-get -y install grafana-enterprise
#==	reload	==#
sudo systemctl daemon-reload
#==	start service	==#
sudo systemctl start grafana-server
#==	enable service	==#
sudo systemctl enable grafana-server.service

echo "Grafana installation done!"
#==	show access url	==#
echo	"########============================================########"
echo	"######## Access URL    : http://$IP_ADDRESS:3000/  ########"
echo	"######## User Name     : admin                      ########"
echo	"######## Password      : admin                      ########"
echo	"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo	"######## Note: Must be change password after login  ########"
echo	"########============================================########"
