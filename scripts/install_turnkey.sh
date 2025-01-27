#!/bin/bash

SCRIPT_DIR=`dirname "$0"`
SCRIPT_DIR_FULL="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# install Docker
echo "Installing Docker.."
if [ -x "$(command -v docker)" ]; then
	echo "Already installed."
  else
	sudo ${SCRIPT_DIR}/install_docker.sh > /dev/null
	echo "Done"
fi
echo

# install Docker Compose
echo "Installing Docker Compose.."
if [ -x "$(command -v docker-compose)" ]; then
	echo "Already installed."
  else
	sudo curl -L https://github.com/docker/compose/releases/download/1.28.5/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose > /dev/null 2>&1
	sudo chmod +x /usr/local/bin/docker-compose
	echo "Done"
fi
echo

# download Docker images from Docker Hub
echo "Downloading Docker images from Docker Hub.."
sudo docker-compose --file ${SCRIPT_DIR}/docker-compose.yml --project-name turnkey-gateway pull
echo "Done"
echo

# start containers
echo "Starting iReceptor Gateway.."
sudo docker-compose --file ${SCRIPT_DIR}/docker-compose.yml --project-name turnkey-gateway up -d
echo "Done"
echo

# wait for mySQL to start accepting queries
echo "Waiting for database to be ready.. (this will take about 30 sec)"
while STATUS=$(sudo docker inspect --format='{{.State.Health.Status}}' $(sudo docker-compose --file ${SCRIPT_DIR}/docker-compose.yml --project-name turnkey-gateway ps -q ireceptor-mysql)); [ $STATUS != "healthy" ]; do
	printf .
	sleep 1
done
echo "Done"
echo

# create database tables
echo "Creating database tables.."
sudo docker-compose --file ${SCRIPT_DIR}/docker-compose.yml --project-name turnkey-gateway exec -T ireceptor-gateway \
		sh -c 'php artisan migrate'
echo "Done"
echo

# run MySQL database seeders
echo "Seeding MySQL database.."
sudo docker-compose --file ${SCRIPT_DIR}/docker-compose.yml --project-name turnkey-gateway exec -T ireceptor-gateway \
		sh -c 'php artisan db:seed --class=RestServiceGroupSeeder && php artisan db:seed --class=RestServicePublicSeeder && php artisan db:seed --class=FieldNameSeeder && php artisan db:seed --class=UserSeeder'
echo "Done"
echo

# run MongoDB database seeders
echo "Seeding MongoDB database.."
sudo docker-compose --file ${SCRIPT_DIR}/docker-compose.yml --project-name turnkey-gateway exec -T ireceptor-mongodb sh -c 'mongorestore --archive' < ${SCRIPT_DIR}/../data/sequence_counts.archive
echo "Done"
echo

# cache repertoires for form widgets and charts
echo "Caching repertoires.."
sudo docker-compose --file ${SCRIPT_DIR}/docker-compose.yml --project-name turnkey-gateway exec -T ireceptor-gateway \
		sh -c 'php artisan sample:cache'
echo
echo "Done"
echo

# confirm successful installation
echo "Congratulations, your iReceptor Gateway Turnkey is up and running."
echo "For more information, go to https://github.com/sfu-ireceptor/turnkey-gateway"
