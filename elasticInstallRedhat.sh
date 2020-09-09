#!/bin/bash
echo -n "# RED HAT Elastic Search Installation."
echo -n "\n"

echo -n "## Java Installation ##"
echo -n "\n\n"
sudo rpm --install jre-8u261-linux-x64.rpm
echo -n "## ElasticSearch Installation ##"
echo -n "\n\n"
sudo rpm --install elasticsearch-7.6.1-x86_64.rpm
echo "/data and /log directories are creating to /opt/elasticlogs for ElasticSearch Logs"
echo -e "\n"
mkdir /opt/elastic
mkdir /opt/elastic/data
mkdir /opt/elastic/log
echo "Directories created"
echo -e "\n"
echo "The directories permissions are setting (Giving permissions to 'elasticsearch' user)"
echo -e "\n"
chown -R elasticsearch:elasticsearch /opt/elastic
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
path.data: /opt/elastic/data
path.logs: /opt/elastic/log
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
echo "Starting ElasticSearch..."
systemctl daemon-reload
service elasticsearch restart

echo -e "\n"
echo "Press Y if you are complete all processes."
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
