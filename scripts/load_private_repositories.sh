#!/bin/sh

SCRIPT_DIR=`dirname "$0"`

# Notes:
# docker-compose --rm: delete container afterwards 
# "ireceptor-gateway" is the Docker service name, as defined in docker-compose.yml 
# sh -c '...' is the command executed inside the container
sudo -E docker-compose --file ${SCRIPT_DIR}/docker-compose.yml --project-name turnkey-gateway run --rm \
			ireceptor-gateway \
				sh -c 'php artisan db:seed --class=RestServicePrivateSeeder'

# refresh cached repertoires (for form widgets and charts)
echo
echo "Refreshing cached repertoires.."
sudo docker-compose --file ${SCRIPT_DIR}/docker-compose.yml --project-name turnkey-gateway exec -T ireceptor-gateway \
		sh -c 'php artisan sample:cache'
echo
echo "Done"
echo