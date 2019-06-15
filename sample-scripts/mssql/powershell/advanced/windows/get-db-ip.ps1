param(
    [string]$ContainerName = 'prismadb_mssql_db'
)

& docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $ContainerName
