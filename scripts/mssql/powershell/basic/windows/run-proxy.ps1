param(
    [string]$ContainerName = 'prismadb_mssql_proxy',
    [string]$ServerAddress = 'prismadb_mssql_db',
    [string]$ServerPort = 1433,
    [string]$InitialCatalog = 'testdb',
    [string]$ListenPort = 4000
)

Write-Host "Starting up Prisma/DB Microsoft SQL Server Proxy container '$ContainerName' on port $ListenPort... "

& "$PSScriptRoot\kill-proxy.ps1" $ContainerName

$svrip = & "$PSScriptRoot\get-db-ip.ps1"

& docker run -d `
    --link=${ServerAddress} `
    -p ${ListenPort}:${ListenPort} `
    -e ListenPort=${ListenPort} `
    -e DataSource=${svrip},${ServerPort} `
    -e InitialCatalog=${InitialCatalog} `
    --name ${ContainerName} `
    aprismatic/prismadb-proxy-mssql-trial:win-1809

$ip = & "$PSScriptRoot\get-proxy-ip.ps1"

Write-Host
Write-Host -Foreground "green" "SQL Server Proxy is at $ip,$Port"