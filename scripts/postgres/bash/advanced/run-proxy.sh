#!/bin/bash

ContainerName=prismadb_postgres_proxy
ServerAddress=prismadb_postgres_db
ServerPort=5432
Database=testdb
ListenPort=4000
AdminUserId=postgres
DatabaseSettings=/dbsettings.json

while getopts n:h:p:d:l:a:s: option; do
    case "${option}" in
    n) ContainerName=${OPTARG} ;;
    h) ServerAddress=${OPTARG} ;;
    p) ServerPort=${OPTARG} ;;
    d) Database=${OPTARG} ;;
    l) ListenPort=${OPTARG} ;;
    a) AdminUserId=${OPTARG} ;;
    s) DatabaseSettings=${OPTARG} ;;
    esac
done

echo "Starting up Prisma/DB PostgreSQL Proxy container '${ContainerName}' on port ${ListenPort}... "

./kill-proxy.sh ${ContainerName}

docker run -d \
    --restart always \
    --link=${ServerAddress} \
    -p ${ListenPort}:${ListenPort} \
    -v ${PWD}${DatabaseSettings}:${DatabaseSettings} \
    -e ListenPort=${ListenPort} \
    -e ServerAddress=${ServerAddress} \
    -e ServerPort=${ServerPort} \
    -e Database=${Database} \
    -e AdminUserId=${AdminUserId} \
    -e DatabaseSettings=${DatabaseSettings} \
    --name ${ContainerName} \
    aprismatic.azurecr.io/prismadb-proxy-postgres:alpine
