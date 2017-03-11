& docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' PrismaDB_SQL_Server
