param(
    [string]$ContainerName = 'prismadb_mssql_proxy',
    [string]$ServerAddress = 'prismadb_mssql_db',
    [string]$ServerPort = 1433,
    [string]$Database = 'testdb',
    [string]$ListenPort = 4000,
    [string]$AdminUserId='sa',
    [string]$KeyfilePath='/keys.json'
)

Write-Host "Starting up Prisma/DB Microsoft SQL Server Proxy container '$ContainerName' on port $ListenPort... "

& "$PSScriptRoot\kill-proxy.ps1" $ContainerName

& docker run -d `
    --restart always `
    --link=${ServerAddress} `
    -p ${ListenPort}:${ListenPort} `
    -v ${PSScriptRoot}${KeyfilePath}:${KeyfilePath} `
    -e ListenPort=${ListenPort} `
    -e DataSource=${ServerAddress},${ServerPort} `
    -e InitialCatalog=${Database} `
    -e AdminUserId=${AdminUserId} `
    -e KeyfilePath=${KeyfilePath} `
    --name ${ContainerName} `
    aprismatic.azurecr.io/prismadb-proxy-mssql:alpine