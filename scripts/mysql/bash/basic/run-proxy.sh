#!/bin/bash

ContainerName=prismadb_mysql_proxy
ServerAddress=127.0.0.1
ServerPort=3306
Database=testdb
ListenPort=4000

while getopts n:h:p:d:l:a:s: option; do
    case "${option}" in
    n) ContainerName=${OPTARG} ;;
    h) ServerAddress=${OPTARG} ;;
    p) ServerPort=${OPTARG} ;;
    d) Database=${OPTARG} ;;
    l) ListenPort=${OPTARG} ;;
    esac
done

echo "Starting up Prisma/DB MySQL Proxy container '${ContainerName}' on port ${ListenPort}... "

./kill-proxy.sh ${ContainerName}

docker run -d \
    -p ${ListenPort}:${ListenPort} \
    -e ListenPort=${ListenPort} \
    -e ServerAddress=${ServerAddress} \
    -e ServerPort=${ServerPort} \
    -e Database=${Database} \
    --name ${ContainerName} \
    aprismatic.azurecr.io/prismadb-proxy-mysql:alpine
