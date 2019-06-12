Write-Host
Write-Host "`t=== Launching Prisma/DB infrastructure ==="
Write-Host

& ".\prepare-SQL-Server.ps1"

Write-Host
Write-Host "Starting Prisma/DB Proxy..."
Write-Host

$sqlip = & ".\get-SQL-Server-IPAddr.ps1"
$ProxyCLI = "Proxy\PrismaDB.Proxy.CLI.exe -l 1434 -a $sqlip -s 1433 -u sa -p saPwd123"

$sqlcmd = "docker run -it --rm bazzilic/sqlcmd"
$LocalSqlcmd = $false
if (Get-Command "sqlcmd" -errorAction SilentlyContinue)
{
    Write-Host -NoNewline -Foreground "green" "[!]"
    Write-Host " Found local SQLCMD on Path"
    $sqlcmd = "sqlcmd"
    $LocalSqlcmd = $true
}

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
    iex "$sqlcmd -S $sqlip,1433 -U sa -P saPwd123 -Q `"SELECT 1`"" 2>&1 | Out-Null
    $success = $?

    if ($LocalSqlcmd) { Start-Sleep -s 20 }
    else { Start-Sleep -s 1 }

    Write-Host -NoNewline "."
    $attempts++
}
Write-Host

iex "cmd /c start $ProxyCLI"

Write-Host
Write-Host
Write-Host "Starting SQLCMD..."

$gateway = 'localhost'
if ($LocalSqlcmd) {
    "Launching SQLCMD..."
    Start-Sleep -s 5
}
else {
    "Checking the virtual network settings..."
    $gateway = & docker inspect --format='{{range .NetworkSettings.Networks}}{{.Gateway}}{{end}}' PrismaDB_SQL_Server
    "Launching SQLCMD container..."
}

iex "$sqlcmd -S `"$gateway,1434`" -U sa -P saPwd123"
