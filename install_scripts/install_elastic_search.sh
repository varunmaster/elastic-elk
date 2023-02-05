#!/bin/bash

# TODO
# configure elastic with the name and edit the config files
# do a dry run on new VM with current script and start from step 3 from below link
# https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-elasticsearch-on-centos-7


#define basic global variables
red="\033[0;31m"
yellow="\033[1;33m"
NC="\033[0m"

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
    # $4 --> data path
    # 's/[^node.name:[[:space:]]]*/something/'
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
    installElasticSearch
}

while getopts h flag; do
	case "${flag}" in
		h | help)
			displayHelp
			exit 0
			;;
		# e)
		# 	if [ ${OPTARG} != "PROD" ] && [ ${OPTARG} != "DEV" ]; then
		# 		echo -e "${red}the -e flag must be either PROD or DEV exclusively (case sensitive)${NC}"
		# 		displayHelp
		# 		exit 1
		# 	fi
		# 	doInstallation ${OPTARG}
		# 	;;
		*)
			displayHelp
			exit 2
			;;
		\?)
			displayHelp
			exit 2
			;;
	esac
done
