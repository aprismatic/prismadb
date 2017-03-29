param(
    [string]$ContainerName = 'PrismaDB_SQL_Server'
)

Write-Host "Starting up SQL Server 2016 container on port 1433... "

& "$PSScriptRoot\kill-PrismaDB-SQL-Server.ps1" $ContainerName

& docker run -d -p 1433:1433 -e sa_password=saPwd123 -e ACCEPT_EULA=Y --name $ContainerName bazzilic/prismadb-mssql-server-dev

if (!$?)
{
    Write-Host
    Write-Host -NoNewline -Foreground "red" "ERROR: "
    Write-Host "SQL Server failed to start. Exiting..."
    Exit 1
}

Write-Host

$sqlip = & "$PSScriptRoot\get-SQL-Server-IPAddr.ps1" $ContainerName
Write-Host -Foreground "green" "SQL Server is at ${sqlip}:1433"
