#!/bin/bash

ContainerName=prismadb_mysql_proxy
ServerAddress=prismadb_mysql_db
ServerPort=3306
Database=testdb
ListenPort=4000
AdminUserId=root
KeyfilePath=/keys.json

while getopts n:h:p:d:l:a:s: option; do
    case "${option}" in
    n) ContainerName=${OPTARG} ;;
    h) ServerAddress=${OPTARG} ;;
    p) ServerPort=${OPTARG} ;;
    d) Database=${OPTARG} ;;
    l) ListenPort=${OPTARG} ;;
    a) AdminUserId=${OPTARG} ;;
    k) KeyfilePath=${OPTARG} ;;
    esac
done

echo "Starting up Prisma/DB MySQL Proxy container '${ContainerName}' on port ${ListenPort}... "

./kill-proxy.sh ${ContainerName}

docker run -d \
    --restart always \
    --link=${ServerAddress} \
    -p ${ListenPort}:${ListenPort} \
    -v ${PWD}${KeyfilePath}:${KeyfilePath} \
    -e ListenPort=${ListenPort} \
    -e ServerAddress=${ServerAddress} \
    -e ServerPort=${ServerPort} \
    -e Database=${Database} \
    -e AdminUserId=${AdminUserId} \
    -e KeyfilePath=${KeyfilePath} \
    --name ${ContainerName} \
    aprismatic.azurecr.io/prismadb-proxy-mysql:alpine
