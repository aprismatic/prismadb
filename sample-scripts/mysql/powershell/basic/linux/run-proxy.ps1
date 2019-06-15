param(
    [string]$ContainerName = 'prismadb_mysql_proxy',
    [string]$ServerAddress = 'prismadb_mysql_db',
    [string]$ServerPort = 3306,
    [string]$Database = 'testdb',
    [string]$ListenPort = 4000
)

Write-Host "Starting up Prisma/DB MySQL Proxy container '$ContainerName' on port $ListenPort... "

& "$PSScriptRoot\kill-proxy.ps1" $ContainerName

& docker run -d `
    --link=${ServerAddress} `
    -p ${ListenPort}:${ListenPort} `
    -e ListenPort=${ListenPort} `
    -e ServerAddress=${ServerAddress} `
    -e ServerPort=${ServerPort} `
    -e Database=${Database} `
    --name ${ContainerName} `
    aprismatic/prismadb-proxy-mysql-trial:alpine