param(
    [string]$ContainerName = 'prismadb_mysql_db'
)

Write-Host "Stopping & removing container named '${ContainerName}'..."
& docker rm --force $ContainerName 2>&1 | Out-Null
