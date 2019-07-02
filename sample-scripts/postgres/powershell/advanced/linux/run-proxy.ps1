param(
    [string]$ContainerName = 'prismadb_postgres_proxy',
    [string]$ServerAddress = 'prismadb_postgres_db',
    [string]$ServerPort = 5432,
    [string]$Database = 'testdb',
    [string]$ListenPort = 4000,
    [string]$AdminUserId='root',
    [string]$KeyfilePath='/keys.json'
)

Write-Host "Starting up Prisma/DB PostgreSQL Proxy container '$ContainerName' on port $ListenPort... "

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
    aprismatic.azurecr.io/prismadb-proxy-postgres:alpine