param(
    [string]$ContainerName = 'prismadb_mysql_db',
    [string]$Port = 3306,
    [string]$Password = 'Qwer!234'
)

Write-Host "Starting up MySQL Database server container '$ContainerName' on port $Port... "

& "$PSScriptRoot\kill-db.ps1" $ContainerName

& docker run -d `
    --restart unless-stopped `
    -p ${Port}:3306 `
    -e MYSQL_ROOT_PASSWORD=${Password} `
    --name ${ContainerName} `
    aprismatic/prismadb-mysql:latest
