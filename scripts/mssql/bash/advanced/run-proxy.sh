#!/bin/bash

ContainerName=prismadb_mssql_proxy
ServerAddress=prismadb_mysql_db
ServerPort=1433
InitialCatalog=testdb
ListenPort=4000
AdminUserId=sa
DatabaseSettings=/dbsettings.json

while getopts n:h:p:d:l:a:s: option; do
    case "${option}" in
    n) ContainerName=${OPTARG} ;;
    h) ServerAddress=${OPTARG} ;;
    p) ServerPort=${OPTARG} ;;
    d) InitialCatalog=${OPTARG} ;;
    l) ListenPort=${OPTARG} ;;
    a) AdminUserId=${OPTARG} ;;
    s) DatabaseSettings=${OPTARG} ;;
    esac
done

echo "Starting up Prisma/DB Microsoft SQL Server Proxy container '${ContainerName}' on port ${ListenPort}... "

./kill-proxy.sh ${ContainerName}

docker run -d \
    --restart always \
    --link=${ServerAddress} \
    -p ${ListenPort}:${ListenPort} \
    -v ${PWD}${DatabaseSettings}:${DatabaseSettings} \
    -e ListenPort=${ListenPort} \
    -e DataSource=${ServerAddress},${ServerPort} \
    -e InitialCatalog=${InitialCatalog} \
    -e AdminUserId=${AdminUserId} \
    -e DatabaseSettings=${DatabaseSettings} \
    --name ${ContainerName} \
    aprismatic.azurecr.io/prismadb-proxy-mssql:alpine
