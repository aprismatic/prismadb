param(
    [string]$ContainerName = 'prismadb_mssql_proxy'
)

Write-Host "Stopping & removing container named '${ContainerName}'..."
& docker rm --force $ContainerName 2>&1 | Out-Null
