#!/bin/bash
echo -e "\n"
echo "######################################"
echo -e "\n"
echo " Welcome to ElasticSearch Installation "
echo -e "\n"
echo "######################################"
echo -e "\n"
echo "Please execute with root permissions."
echo -e "\n"
echo "######################################"
echo -e "\n"
echo ".deb package is downloading ..."
echo -e "\n"
echo "If your package already installed press Y else press K "
echo -e "\n"
read dinle
if [ $dinle == "K" ]; then
        wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.9.1-amd64.deb
        ls
        echo "Package Downlaoded."
        echo -e "\n"
        echo "######################################"
        echo -e "\n"

fi

echo "Installing ElasticSearch."
echo -e "\n"
sudo dpkg -i elasticsearch-7.9.1-amd64.deb
echo "ElasticSearch Successfully Installed."
echo -e "\n"
echo "######################################"
echo -e "\n"
echo "Installing Java ..."
echo -e "\n"
sudo apt install default-jre
echo "Java Successfully Installed."
echo -e "\n"
echo "/data and /log directories are creating to /elasticdb/elasticlogs for ElasticSearch Logs"
echo -e "\n"
mkdir /elasticdb
mkdir /elasticdb/elastic
mkdir /elasticdb/elastic/data
mkdir /elasticdb/elastic/log
echo "Directories created"
echo -e "\n"
echo "The directories permissions are setting (Giving permissions to 'elasticsearch' user)"
echo -e "\n"
chown -R elasticsearch:elasticsearch  /elasticdb
systemctl daemon-reload
echo "Permissions Set."
echo -e "\n"
echo "IP Address for ElasticSearch Config"
echo -e "\n"
read ip
echo "Cluster Name: "
echo -e "\n"
read clusterName
echo "Node Name: "
echo -e "\n"
echo -e "\n"
read nodeName
echo "IP Address: " $ip
echo "Cluster Name: " $clusterName
echo "Node Name: " $nodeName

echo "cluster.name: $clusterName
path.data: /elasticdb/elastic/data
path.logs: /elasticdb/elastic/log
network.host: $ip
node.name: $nodeName
xpack.security.transport.ssl.enabled: true
xpack.security.enabled: true
cluster.initial_master_nodes: [\"$ip\"]
discovery.zen.ping.unicast.hosts: [\"$ip\"]" > /etc/elasticsearch/elasticsearch.yml


echo -e "\n"
echo -e "Enter the file using the command below for the Memory Settings you want to adjust."
echo -e "sudo nano /etc/elasticsearch/jvm.options"
echo -e "Edit the 16 value in the Xms16g phrase in the file as you wish."
echo -e "To set the Memory Lock, enter the file using the command below."
echo -e "\n"

echo -e "nano /usr/lib/systemd/system/elasticsearch.service"
echo -e "Add the LimitMEMLOCK = infinity value below the value of LimitNOFILE = 65536."
echo -e "\n"
echo -e "Add TimeoutSec=900 This value below the [Service]"
echo -e "\n"

echo -e "Starting ElasticSearch..."
systemctl daemon-reload
service elasticsearch restart

echo -e "\n"
echo "Press Y if you want to setup X-Pack password."
read islem
if [ $islem == "Y" ]; then
		echo -e "\n"
        echo "X-Pack Plugini settings are being made."
        cd /usr/share/elasticsearch/bin
        ./elasticsearch-setup-passwords interactive
else
		echo -e "\n"
        echo "Installation completed. Do not forget to adjust the Memory Settings and xPack settings."
        echo -e "\n"
fi
echo -e "\n"
echo -e "\n"
echo -e "Installation Successfully Completed.\n\n"

