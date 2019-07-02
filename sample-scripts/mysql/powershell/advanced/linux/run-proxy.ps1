param(
    [string]$ContainerName = 'prismadb_mysql_proxy',
    [string]$ServerAddress = 'prismadb_mysql_db',
    [string]$ServerPort = 3306,
    [string]$Database = 'testdb',
    [string]$ListenPort = 4000,
    [string]$AdminUserId='root',
    [string]$KeyfilePath='/keys.json'
)

Write-Host "Starting up Prisma/DB MySQL Proxy container '$ContainerName' on port $ListenPort... "

& "$PSScriptRoot\kill-proxy.ps1" $ContainerName

& docker run -d `
    --restart always `
    --link=${ServerAddress} `
    -p ${ListenPort}:${ListenPort} `
    -v ${PSScriptRoot}${KeyfilePath}:${KeyfilePath} \
    -e ListenPort=${ListenPort} `
    -e ServerAddress=${ServerAddress} `
    -e ServerPort=${ServerPort} `
    -e Database=${Database} `
    -e AdminUserId=${AdminUserId} `
    -e KeyfilePath=${KeyfilePath} `
    --name ${ContainerName} `
    aprismatic.azurecr.io/prismadb-proxy-mysql:alpine