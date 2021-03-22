#!/bin/sh

SCRIPT_DIR=`dirname "$0"`

echo "Starting iReceptor Gateway Turnkey.."
sudo docker-compose --file ${SCRIPT_DIR}/docker-compose.yml --project-name turnkey-gateway up -d
echo "Done"
echo
