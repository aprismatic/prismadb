# Prisma/DB

[Prisma/DB](http://prismadb.com/) (http://prismadb.com/) is a cryptographic security layer for relational database systems, that currently supports Microsoft SQL Server, MySQL, MariaDB, PostgreSQL and CockroachDB.
Started as a research project in [Nanyang Technological University](http://www.ntu.edu.sg/Pages/home.aspx) (Singapore), it is now a fast-developing product.

#### MySQL
![Build status](https://ci.appveyor.com/api/projects/status/rcr8urkhoefnue2i?svg=true)
![Versions](https://images.microbadger.com/badges/version/aprismatic/prismadb-proxy-mysql.svg)
[![](https://img.shields.io/docker/pulls/aprismatic/prismadb-proxy-mysql.svg)](https://hub.docker.com/r/aprismatic/prismadb-proxy-mysql)

#### SQL Server
![Build status](https://ci.appveyor.com/api/projects/status/6kkwwji6o60vm2sr?svg=true)
![Versions](https://images.microbadger.com/badges/version/aprismatic/prismadb-proxy-mssql.svg)
[![](https://img.shields.io/docker/pulls/aprismatic/prismadb-proxy-mssql.svg)](https://hub.docker.com/r/aprismatic/prismadb-proxy-mssql)

#### PostgreSQL
![Build status](https://ci.appveyor.com/api/projects/status/qeppg5rbfmh4qdri?svg=true)
![Versions](https://images.microbadger.com/badges/version/aprismatic/prismadb-proxy-postgres.svg)
[![](https://img.shields.io/docker/pulls/aprismatic/prismadb-proxy-postgres.svg)](https://hub.docker.com/r/aprismatic/prismadb-proxy-postgres)

## Try it out!
The easiest way to try out Prisma/DB is to use Docker containers.
This will also keep your computer clutter-free.

**Important for Windows users**: Enabling Hyper-V (required by Docker for Windows) will disable VirtualBox or any other virtualization manager.
You won't be able to start your virtual machines until you disable Hyper-V (or migrate your VMs to Hyper-V).

### 1. Installing Docker
Install Docker by following the instructions at https://docs.docker.com/install/.

On Windows, after the installation is finished, make sure that Docker is switched to Linux containers.
It could be done by right-clicking the Docker icon in the taskbar and choosing the respective menu item.

On Linux, Docker Compose may not be installed automatically with Docker,
you can follow the instructions at https://docs.docker.com/compose/install/ to install Compose.

### 2. Launching Prisma/DB Demo Suite

To launch the demo suite you will need to open your command line interface. On Windows, you may launch PowerShell; on Mac, you can launch Terminal app; if you are on Linux, you sure know what to do :)

**1)** Obtain the Docker Compose file:

Download/save the following YAML Docker Compose file to your machine:
[/sample-scripts/postgres/docker-compose/basic/linux/docker-compose.yml](https://github.com/aprismatic/PrismaDB/blob/master/sample-scripts/postgres/docker-compose/basic/linux/docker-compose.yml) [[Raw File](https://raw.githubusercontent.com/aprismatic/PrismaDB/master/sample-scripts/postgres/docker-compose/basic/linux/docker-compose.yml)]

This Docker Compose file will start a PostgreSQL server with Prisma/DB UDFs, as well as the Prisma/DB Proxy (trial mode) for PostgreSQL. Importing/exporting of encryption keys is disabled in the trial mode of Prisma/DB Proxy, but other than that, it is a fully featured build.

**2)** Run the containers in detached mode:

`> docker-compose up -d`

**3)** Launch Psql command line tool to connect to the database through the Prisma/DB Proxy:

`> docker exec -it prismadb_postgres_db psql -U postgres -h prismadb_postgres_proxy -p 4000 testdb`

Use password `Qwer!234` to authenticate as `postgres` user, and enter `\q` anytime to quit.

**4)** Use some of the following queries to try out the encrypted database:

```SQL
CREATE TABLE t1
(
	a INT ENCRYPTED FOR (MULTIPLICATION, ADDITION, RANGE),
	b INT ENCRYPTED FOR (MULTIPLICATION, ADDITION, RANGE),
	c INT,
	d VARCHAR(30) ENCRYPTED FOR (STORE, SEARCH),
	e VARCHAR(30)
);

-- Display column details
SHOW COLUMNS FROM t1;

INSERT INTO t1 (a, b, c, d, e) VALUES
( 1,  2,   3, 'Hello', 'Prisma/DB'),
(12,  0,   7, 'Test', 'data'),
( 0,  2, 123, 'This is encrypted', 'And this is not'),
(71, 67,  13, 'Last', 'row');

-- Arithmetic operations and search over encrypted values
SELECT a, b, a + b, b * a, (b * a) + b, c, d, e
FROM   t1
WHERE  b = 2;
```

**5)** Stop and remove containers:

`> docker-compose down`

---

Please note that Prisma/DB currently supports only a subset of the full SQL.
We are constantly working to support more.
If you encounter a problem with your queries, please head to the Issues section and let us know!

Connect to the database server directly (it's at `localhost:5432`) using any database management tool (HeidiSQL, Psql, etc.) or Psql directly from the PostgreSQL container:

`> docker exec -it prismadb_postgres_db psql -U postgres -h 127.0.0.1 -p 5432 testdb`

and you would be able to see the partially encrypted database as it is stored on the server, with the data in selected columns being encrypted.
