Write-Host "Starting up SQL Server 2016 container on port 1433... "

& ".\kill-PrismaDB-SQL-Server.ps1"

& docker run -d -p 1433:1433 -e sa_password=saPwd123 -e ACCEPT_EULA=Y --name PrismaDB_SQL_Server microsoft/mssql-server-windows-developer

if (!$?)
{
    Write-Host
    Write-Host -NoNewline -Foreground "red" "ERROR: "
    Write-Host "SQL Server failed to start. Exiting..."
    Exit 1
}

Write-Host

$sqlip = & ".\get-SQL-Server-IPAddr.ps1"
Write-Host -Foreground "green" "SQL Server is at ${sqlip}:1433"

Write-Host
Write-Host
Write-Host "Installing Prisma/DB modules into database Test-DB-1..."


Write-Host "Stopping previous containers if any..."
& docker kill PrismaDB_SqlPackage 2>&1 | Out-Null
Write-Host "Removing containers named PrismaDB_SqlPackage to avoid naming conflicts..."
& docker rm PrismaDB_SqlPackage 2>&1 | Out-Null

Write-Host -NoNewline "Creating a new SqlPackage container... "
& docker create --name PrismaDB_SqlPackage --rm -t bazzilic/sqlpackage /a:Publish /tcs:"Data Source=$sqlip,1433;Persist Security Info=True;User ID=sa;Pooling=False;MultipleActiveResultSets=False;Connect Timeout=60;Encrypt=False;TrustServerCertificate=True;Password=saPwd123;Database=Test-DB-1" /sf:C:/Test-DB-1.dacpac

Write-Host "Pushing *.dacpac files to SqlPackage container..."
& docker cp Test-DB-1.dacpac PrismaDB_SqlPackage:C:/Test-DB-1.dacpac

Write-Host -NoNewline "Waiting for the SQL Server to start accepting connections.."
$success = $false
$attempts = 0
while ( $success -eq $false )
{
    if ($attempts -ge 9)
    {
        Write-Host
        Write-Host -NoNewline -Foreground "red" "ERROR: "
        Write-Host "Can't connect to SQL Server for too long. Exiting..."
        Exit 1
    }
    & docker run -it --rm bazzilic/sqlcmd -S $sqlip,1433 -U sa -P saPwd123 -Q "SELECT 1" 2>&1 | Out-Null
    $success = $?
    Start-Sleep -s 1
    Write-Host -NoNewline "."
    $attempts++
}
Write-Host

Write-Host "Starting the SqlPackage container..."
& docker start -a PrismaDB_SqlPackage

Write-Host
