param(
    [string]$ContainerName = 'prismadb_mssql_proxy',
    [string]$ServerAddress = 'prismadb_mssql_db',
    [string]$ServerPort = 1433,
    [string]$Database = 'testdb',
    [string]$ListenPort = 4000,
    [string]$AdminUserId='sa'
)

Write-Host "Starting up Prisma/DB Microsoft SQL Server Proxy container '$ContainerName' on port $ListenPort... "

& "$PSScriptRoot\kill-proxy.ps1" $ContainerName

& docker run -d `
    --restart unless-stopped `
    --link=${ServerAddress} `
    -p ${ListenPort}:${ListenPort} `
    -v ./data/:/data/ `
    -e ListenPort=${ListenPort} `
    -e DataSource=${ServerAddress},${ServerPort} `
    -e InitialCatalog=${Database} `
    -e AdminUserId=${AdminUserId} `
    --name ${ContainerName} `
    aprismatic/prismadb-proxy-mssql:alpine