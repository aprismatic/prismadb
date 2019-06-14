param(
    [string]$ContainerName = 'prismadb_postgres_proxy',
    [string]$ServerAddress = 'prismadb_postgres_db',
    [string]$ServerPort = 5432,
    [string]$Database = 'testdb',
    [string]$ListenPort = 4000
)

Write-Host "Starting up Prisma/DB PostgreSQL Proxy container '$ContainerName' on port $ListenPort... "

& "$PSScriptRoot\kill-proxy.ps1" $ContainerName

& docker run -d `
    --link=${ServerAddress} `
    -p ${ListenPort}:${ListenPort} `
    -e ListenPort=${ListenPort} `
    -e ServerAddress=${ServerAddress} `
    -e ServerPort=${ServerPort} `
    -e Database=${Database} `
    --name ${ContainerName} `
    aprismatic/prismadb-proxy-postgres-trial:alpine