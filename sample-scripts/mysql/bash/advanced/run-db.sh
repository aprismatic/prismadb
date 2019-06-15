#!/bin/bash

ContainerName=prismadb_mysql_db
Port=3306
Password=Qwer!234

while getopts n:t:p: option; do
    case "${option}" in
    n) ContainerName=${OPTARG} ;;
    t) Port=${OPTARG} ;;
    p) Password=${OPTARG} ;;
    esac
done

echo "Starting up MySQL Database server container '${ContainerName}' on port ${Port}... "

./kill-db.sh ${ContainerName}

docker run -d \
    --restart always \
    -p ${ListenPort}:3306 \
    -e MYSQL_ROOT_PASSWORD=${Password} \
    --name ${ContainerName} \
    aprismatic/prismadb-mysql:latest
