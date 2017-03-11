Write-Host
Write-Host "`t=== Launching Prisma/DB infrastructure ==="
Write-Host

& ".\prepare-SQL-Server.ps1"

Write-Host
Write-Host "Starting Prisma/DB Proxy..."
Write-Host

$sqlip = & ".\get-SQL-Server-IPAddr.ps1"
$ProxyCLI = "Proxy\PrismaDB.Proxy.CLI.exe -l 1434 -a $sqlip -s 1433 -d Test-DB-1 -u sa -p saPwd123"

iex "cmd /c start $ProxyCLI"

Write-Host
Write-Host
Write-Host "Starting SQLCMD..."

Write-Host "Checking, which virtual network SQL Server is on..."
$network = & docker inspect --format='{{range $net, $conf := .NetworkSettings.Networks}}{{$net}}{{end}}' PrismaDB_SQL_Server

Write-Host "Finding gateway address for the network `"$network`"..."
$gateway = & docker network inspect --format '{{range $r := .IPAM.Config}}{{$r.Gateway}}{{end}}' $network

& docker run -it --rm bazzilic/sqlcmd -S "$gateway,1434" -U sa -P saPwd123
