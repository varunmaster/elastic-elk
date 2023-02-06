#!/bin/bash

#define basic global variables
red="\033[0;31m"
yellow="\033[1;33m"
NC="\033[0m"
node=""
cluster=""

function displayHelp() {
    echo "${red}\n\t*******************************************************************
    \t* This script will update the system and install Elastic Search   *
    \t* This script must be run with sudo privileges or as root         *
    \t* Example:                                                        *
    \t*\t $> sudo sh install_elastic_search.sh                     *
    \t*******************************************************************
    ${NC}"
}

function configureElastic() {
    # $1 --> name of the node
    # $2 --> name of the cluster
    # $3 --> role of the node 
    #       Master --> responsible for the cluster’s health and stability
    #       data --> nodes that will store the data
    #       Ingest --> allows a node to accept and process data streams
    # $4 --> data path
    #   default location --> /var/lib/elasticsearch 
    echo "${yellow}-->updating the config file${NC}"
    echo "${yellow}-->updating the node name to ${1}"
    sed -i "s/node.name:[[:space:]].*/node.name: ${1}" /etc/elasticsearch/elasticsearch.yml
    echo "${yellow}-->updating the cluster name to ${2}"
    sed -i "s/cluster.name:[[:space:]].*/cluster.name: ${2}" /etc/elasticsearch/elasticsearch.yml
    #echo "${yellow}-->updating the role of the node to ${3}"
    #sed -i "s/node.roles:[[:space:]].*/node.roles: \[ ${3} \]" /etc/elasticsearch/elasticsearch.yml
    #echo "${yellow}-->updating the data path to ${4}"
    #sed -i "s/path.data:[[:space:]].*/node.name: ${4}" /etc/elasticsearch/elasticsearch.
    echo "${red}-->updating the JVM options${NC}"
    sed -i "s/Xms.*/Xms8g/" /etc/elasticsearch/jvm.options
    sed -i "s/Xmx.*/Xmx8g/" /etc/elasticsearch/jvm.options
}

function installElasticSearch() {
    echo "${yellow}-->starting download of elastic and dependencies${NC}"
    echo "${yellow}-->installing java${NC}"
    yum install java -y 
    echo "${yellow}-->getting elastic search${NC}"
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.6.0-x86_64.rpm
    echo "${yellow}-->installing elastic seach${NC}"
    rpm -ivh elasticsearch-8.6.0-x86_64.rpm
    echo "${yellow}-->enabling elastic${NC}"
    systemctl enable elasticsearch.service
    configureElastic "elastic-band" "elasticity"
}

function updateSystem() {
    echo "${yellow}-->will be performing an update of all the installed packets${NC}"
    yum update -y
    echo "${yellow}-->finshed updating packages...checking if wget is installed or not${NC}"
    if rpm -q wget; then
        echo "${yellow}-->wget is installed already${NC}"
    else
        echo "${yellow}-->wget is not installed...installing now${NC}"
        yum install wget -y
    fi
    installElasticSearch $1 $2
}

while getopts hn:c: flag; do
	case "${flag}" in
		h | help)
			displayHelp
			exit 0
			;;
		*)
			updateSystem
            exit 0
			;;
	esac
done
