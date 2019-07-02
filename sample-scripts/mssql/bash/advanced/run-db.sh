#!/bin/bash

ContainerName=prismadb_mssql_db
Port=1433
Password=Qwer!234

while getopts n:t:p: option; do
    case "${option}" in
    n) ContainerName=${OPTARG} ;;
    t) Port=${OPTARG} ;;
    p) Password=${OPTARG} ;;
    esac
done

echo "Starting up Microsoft SQL Server Database server container '${ContainerName}' on port ${Port}... "

./kill-db.sh ${ContainerName}

docker run -d \
    --restart always \
    -p ${Port}:1433 \
    -e SA_PASSWORD=${Password} \
    -e ACCEPT_EULA=Y \
    --name ${ContainerName} \
    aprismatic/mssql-server-linux-fulltext:latest
