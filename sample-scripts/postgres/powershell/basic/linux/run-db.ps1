param(
    [string]$ContainerName = 'prismadb_postgres_db',
    [string]$Port = 5432,
    [string]$Password = 'Qwer!234'
)

Write-Host "Starting up PostgreSQL Database server container '$ContainerName' on port $Port... "

& "$PSScriptRoot\kill-db.ps1" $ContainerName

& docker run -d `
    -p ${Port}:5432 `
    -e POSTGRES_PASSWORD=${Password} `
    --name ${ContainerName} `
    aprismatic/prismadb-postgres:latest
