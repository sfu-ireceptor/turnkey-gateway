# Troubleshooting


## Listing the Docker containers
You can use docker-compose:
```
sudo docker-compose --file scripts/docker-compose.yml --project-name turnkey-gateway ps
```
which will return the state of the services defined in docker-compose.yml:
```
               Name                              Command                  State                   Ports             
--------------------------------------------------------------------------------------------------------------------
turnkey-gateway_ireceptor-gateway_1   docker-php-entrypoint apac ...   Up             0.0.0.0:80->80/tcp            
turnkey-gateway_ireceptor-mongodb_1   docker-entrypoint.sh mongod      Up             27017/tcp                     
turnkey-gateway_ireceptor-mysql_1     /entrypoint.sh mysqld            Up (healthy)   3306/tcp, 33060/tcp, 33061/tcp
```

or directly Docker:
```
sudo docker ps
```
which will return the list of Docker containers **currently running**:
```
CONTAINER ID        IMAGE                      COMMAND                  CREATED             STATUS                 PORTS                       NAMES
926789c45052        ireceptor/gateway:docker   "docker-php-entrypoi…"   2 hours ago         Up 2 hours             0.0.0.0:80->80/tcp          turnkey-gateway_ireceptor-gateway_1
76912d6b681f        mongo:4                    "docker-entrypoint.s…"   6 days ago          Up 2 hours             27017/tcp                   turnkey-gateway_ireceptor-mongodb_1
2db737299d95        mysql/mysql-server         "/entrypoint.sh mysq…"   6 days ago          Up 2 hours (healthy)   3306/tcp, 33060-33061/tcp   turnkey-gateway_ireceptor-mysql_1
```

## Logging into the Docker containers

### Web application (gateway)
```
sudo docker-compose --file scripts/docker-compose.yml --project-name turnkey-gateway exec ireceptor-gateway bash
```

### MySQL
```
sudo docker-compose --file scripts/docker-compose.yml --project-name turnkey-gateway exec ireceptor-mysql bash
```

### MongoDB
```
sudo docker-compose --file scripts/docker-compose.yml --project-name turnkey-gateway exec ireceptor-mongodb bash
```


## Logs

### MongoDB
```
sudo docker-compose --file scripts/docker-compose.yml --project-name turnkey-gateway logs ireceptor-mongodb
```

### MySQL
```
sudo docker-compose --file scripts/docker-compose.yml --project-name turnkey-gateway logs ireceptor-mysql
```

### gateway

Log into the gateway container and look in `storage/logs/laravel.log`:

```
sudo docker-compose --file scripts/docker-compose.yml --project-name turnkey-gateway exec ireceptor-gateway bash

cat storage/logs/laravel.log
```
