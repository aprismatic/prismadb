param(
    [string]$ContainerName = 'prismadb_mssql_proxy'
)

& docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $ContainerName
