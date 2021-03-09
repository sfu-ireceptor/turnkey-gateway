#!/bin/bash

SCRIPT_DIR=`dirname "$0"`
SCRIPT_DIR_FULL="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# install Docker
echo "Installing Docker.."
if [ -x "$(command -v docker)" ]; then
	echo "Already installed."
  else
	sudo ${SCRIPT_DIR}/install_docker.sh > /dev/null 2>&1
	echo "Done"
fi
echo

# install Docker Compose
echo "Installing Docker Compose.."
if [ -x "$(command -v docker-compose)" ]; then
	echo "Already installed."
  else
	sudo curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose > /dev/null 2>&1
	sudo chmod +x /usr/local/bin/docker-compose
	echo "Done"
fi
echo

# download Docker images from Docker Hub
echo "Downloading Docker images from Docker Hub.."
sudo docker-compose --file ${SCRIPT_DIR}/docker-compose.yml --project-name turnkey-gateway pull
echo "Done"
echo

# # configure MySQL
# echo "Configuring  MySQL.."
# # sudo docker-compose --file ${SCRIPT_DIR}/docker-compose.yml --project-name turnkey-gateway pull
# # docker run -t --name=mysql2 -d mysql/mysql-server
# docker run -t --name=mysql2 -d mysql/mysql-server bash

# sudo docker-compose --file ${SCRIPT_DIR}/docker-compose.yml --project-name turnkey-service run ireceptor-mysql bash
# echo "Done"
# echo

# start turnkey
${SCRIPT_DIR}/start_turnkey.sh
echo

# confirm successful installation
echo "Congratulations, your iReceptor Gateway Turnkey is up and running."
echo "For more information, go to https://github.com/sfu-ireceptor/turnkey-gateway"