param(
    [string]$ContainerName = 'prismadb_mysql_proxy',
    [string]$ServerAddress = 'prismadb_mysql_db',
    [string]$ServerPort = 3306,
    [string]$Database = 'testdb',
    [string]$ListenPort = 4000,
    [string]$AdminUserId='root'
)

Write-Host "Starting up Prisma/DB MySQL Proxy container '$ContainerName' on port $ListenPort... "

& "$PSScriptRoot\kill-proxy.ps1" $ContainerName

& docker run -d `
    --restart unless-stopped `
    --link=${ServerAddress} `
    -p ${ListenPort}:${ListenPort} `
    -v ./data/:/data/ `
    -e ListenPort=${ListenPort} `
    -e ServerAddress=${ServerAddress} `
    -e ServerPort=${ServerPort} `
    -e Database=${Database} `
    -e AdminUserId=${AdminUserId} `
    --name ${ContainerName} `
    aprismatic/prismadb-proxy-mysql:alpine