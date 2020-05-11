# Docker Images

## Proxy Images

#### MySQL Repository: [`aprismatic/prismadb-proxy-mysql`](https://hub.docker.com/r/aprismatic/prismadb-proxy-mysql)

#### SQL Server Repository: [`aprismatic/prismadb-proxy-mssql`](https://hub.docker.com/r/aprismatic/prismadb-proxy-mssql)

#### PostgreSQL Repository: [`aprismatic/prismadb-proxy-postgres`](https://hub.docker.com/r/aprismatic/prismadb-proxy-postgres)

| Tag                | Description                                            |
| ------------------ | ------------------------------------------------------ |
| `latest`           | Same as `alpine`                                       |
| `alpine`           | Latest Linux Alpine build                              |
| `win-1809`         | Latest Windows Server 1809 build                       |
| `x.x`              | Same as `x.x-alpine`                                   |
| `x.x-alpine`       | Latest `major.minor` version Linux Alpine build        |
| `x.x-win-1809`     | Latest `major.minor` version Windows Server 1809 build |
| `x.x.x.x`          | Same as `x.x.x.x-alpine`                               |
| `x.x.x.x-alpine`   | Exact version of Linux Alpine build                    |
| `x.x.x.x-win-1809` | Exact version of Windows Server 1809 build             |

### Community Edition

#### MySQL Repository: [`aprismatic/prismadb-proxy-mysql-ce`](https://hub.docker.com/r/aprismatic/prismadb-proxy-mysql-ce)

#### SQL Server Repository: [`aprismatic/prismadb-proxy-mssql-ce`](https://hub.docker.com/r/aprismatic/prismadb-proxy-mssql-ce)

#### PostgreSQL Repository: [`aprismatic/prismadb-proxy-postgres-ce`](https://hub.docker.com/r/aprismatic/prismadb-proxy-postgres-ce)

Community edition images are identical to the standard images, with the [`CommunityEd` enviroment variable](configuration-options) set to `true`. These set of images makes it easier to get started with the community edition without manually setting the enviroment variable. Community edition runs in a single thread, and does not support wildcard encryption.

## Supporting Images

### MySQL Server Images

#### Repository: [`aprismatic/prismadb-mysql`](https://hub.docker.com/r/aprismatic/prismadb-mysql)

| Tag      | Description                                                               |
| -------- | ------------------------------------------------------------------------- |
| `latest` | Same as `5.7`                                                             |
| `5.7`    | MySQL Community Server 5.7 with UDFs necessary for homomorphic operations |

### SQL Server Images

#### Repository: [`aprismatic/mssql-server-linux-fulltext`](https://hub.docker.com/r/aprismatic/mssql-server-linux-fulltext)

| Tag      | Description                                                                                         |
| -------- | --------------------------------------------------------------------------------------------------- |
| `latest` | SQL Server 2017 with full-text search installed necessary for `WILDCARD` encryption on Ubuntu 16.04 |

#### Repository: [`aprismatic/mssql-server-windows-developer-fulltext`](https://hub.docker.com/r/aprismatic/mssql-server-windows-developer-fulltext)

| Tag      | Description                                                                                                                       |
| -------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `latest` | SQL Server 2017 Developer Edition with full-text search installed necessary for `WILDCARD` encryption on Windows Server Core 2019 |

#### Repository: [`mcr.microsoft.com/mssql/server`](https://hub.docker.com/_/microsoft-mssql-server)

| Tag      | Description                                                                                                                                     |
| -------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| `latest` | Official image for Microsoft SQL Server on Linux for Docker Engine<br>Only use this if `WILDCARD` encryption will not be used in the deployment |

#### Repository: [`microsoft/mssql-server-windows-developer`](https://hub.docker.com/r/microsoft/mssql-server-windows-developer/)

| Tag      | Description                                                                                                                                                |
| -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `latest` | Official Microsoft SQL Server Developer Edition images for Windows Containers<br>Only use this if `WILDCARD` encryption will not be used in the deployment |

### PostgreSQL Server Images

#### Repository: [`aprismatic/prismadb-postgres`](https://hub.docker.com/r/aprismatic/prismadb-postgres)

| Tag      | Description                                                                   |
| -------- | ----------------------------------------------------------------------------- |
| `latest` | Same as `10`                                                                  |
| `10`     | PostgreSQL Server 10 with Prisma/DB UDFs necessary for homomorphic operations |
