Write-Host
Write-Host "`t=== Launching Prisma/DB infrastructure ==="
Write-Host

& ".\prepare-SQL-Server.ps1"

Write-Host
Write-Host "Starting Prisma/DB Proxy..."
Write-Host

$sqlip = & ".\get-SQL-Server-IPAddr.ps1"
$ProxyCLI = "Proxy\PrismaDB.Proxy.CLI.exe -l 1434 -a $sqlip -s 1433 -d Test-DB-1 -u sa -p saPwd123"

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

iex "cmd /c start $ProxyCLI"

Write-Host
Write-Host
Write-Host "Starting SQLCMD..."

Write-Host "Checking, which virtual network SQL Server is on..."
$network = & docker inspect --format='{{range $net, $conf := .NetworkSettings.Networks}}{{$net}}{{end}}' PrismaDB_SQL_Server

Write-Host "Finding gateway address for the network `"$network`"..."
$gateway = & docker network inspect --format '{{range $r := .IPAM.Config}}{{$r.Gateway}}{{end}}' $network

& docker run -it --rm bazzilic/sqlcmd -S "$gateway,1434" -U sa -P saPwd123
