# Sample Docker Scripts

## MySQL Server with Prisma/DB Proxy on Linux (Linux Bash)

```Shell
docker run -d -p 3306:3306 \
    -e MYSQL_ROOT_PASSWORD=toor \
    --name PrismaDB_MySQL \
    aprismatic/prismadb-mysql

docker run -d -p 4000:4000 \
    --link=PrismaDB_MySQL \
    -e ListenPort=4000 \
    -e ServerAddress=PrismaDB_MySQL \
    -e ServerPort=3306 \
    -e Database=testdb \
    --name PrismaDB_Proxy \
    aprismatic.azurecr.io/prismadb-proxy-mysql:alpine
```

## SQL Server with Prisma/DB Proxy on Windows (PowerShell)

```PowerShell
docker run -d -p 1433:1433 `
    -e SA_PASSWORD=saPwd123 `
    -e ACCEPT_EULA=Y `
    --name PrismaDB_SQL_Server `
    aprismatic/mssql-server-windows-developer-fulltext

$svrip = docker inspect `
            --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' `
            PrismaDB_SQL_Server

docker run -d -p 4000:4000 `
    --link=PrismaDB_SQL_Server `
    -e ListenPort=4000 `
    -e DataSource=${svrip},1433 `
    -e InitialCatalog=testdb `
    --name PrismaDB_SQL_Server_Proxy `
    aprismatic.azurecr.io/prismadb-proxy-mssql:win-1809

$proxyip = docker inspect `
            --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' `
            PrismaDB_SQL_Server_Proxy

Write-Host -Foreground "green" "SQL Server Proxy is at $proxyip,4000"
```

More scripts are available here: https://github.com/aprismatic/prismadb/tree/master/sample-scripts
