param(
    [string]$ContainerName = 'PrismaDB_SQL_Server'
)

& docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $ContainerName
