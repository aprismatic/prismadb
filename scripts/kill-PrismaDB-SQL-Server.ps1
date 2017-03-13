param(
    [string]$ContainerName = 'PrismaDB_SQL_Server'
)

Write-Host "Stopping Prisma/DB SQL Server containers if any..."
& docker kill $ContainerName 2>&1 | Out-Null
Write-Host "Removing containers named '$ContainerName'..."
& docker rm $ContainerName 2>&1 | Out-Null
