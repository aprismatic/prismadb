Write-Host "Stopping Prisma/DB SQL Server containers if any..."
& docker kill PrismaDB_SQL_Server 2>&1 | Out-Null
Write-Host "Removing containers named PrismaDB_SQL_Server..."
& docker rm PrismaDB_SQL_Server 2>&1 | Out-Null
