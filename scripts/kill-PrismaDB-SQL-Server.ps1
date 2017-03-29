param(
    [string]$ContainerName = 'PrismaDB_SQL_Server'
)

Write-Host "Removing Prisma/DB SQL Server containers if any..."
& docker rm --force $ContainerName 2>&1 | Out-Null
