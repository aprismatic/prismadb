#!/bin/bash

ContainerName=prismadb_postgres_db
Port=5432
Password=Qwer!234

while getopts n:t:p: option; do
    case "${option}" in
    n) ContainerName=${OPTARG} ;;
    t) Port=${OPTARG} ;;
    p) Password=${OPTARG} ;;
    esac
done

echo "Starting up PostgreSQL Database server container '${ContainerName}' on port ${Port}... "

./kill-db.sh ${ContainerName}

docker run -d \
    -p ${ListenPort}:5432 \
    -e POSTGRES_PASSWORD=${Password} \
    --name ${ContainerName} \
    aprismatic/prismadb-postgres:latest
