param(
    [string]$ContainerName = 'prismadb_mssql_db',
    [string]$Port = 1433,
    [string]$Password = 'Qwer!234'
)

Write-Host "Starting up Microsoft SQL Server Database server container '$ContainerName' on port $Port... "

& "$PSScriptRoot\kill-db.ps1" $ContainerName

& docker run -d `
    -p ${ListenPort}:1433 `
    -e SA_PASSWORD=${Password} `
    -e ACCEPT_EULA=Y `
    --name ${ContainerName} `
    aprismatic/mssql-server-windows-developer-fulltext

$ip = & "$PSScriptRoot\get-db-ip.ps1"

Write-Host
Write-Host -Foreground "green" "SQL Server is at $ip,$Port"
