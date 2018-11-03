# Prisma/DB
[Prisma/DB](http://prismadb.com/) (http://prismadb.com/) is a cryptographic security layer for relational database systems, that currently supports Microsoft SQL Server, MySQL, and MariaDB; support for Oracle and PostgreSQL is planned.
Started as a research project in [Nanyang Technological University](http://www.ntu.edu.sg/Pages/home.aspx) (Singapore), it is now a fast-developing product.

## Try it out!
The easiest way to try out Prisma/DB is to use Docker containers.
This will also keep your computer clutter-free.

**Important for Windows users**: Enabling Hyper-V (required by Docker for Windows) will disable VirtualBox or any other virtualization manager.
You won't be able to start your virtual machines until you disable Hyper-V (or migrate your VMs to Hyper-V).

### 1. Installing Docker for Windows
Install Docker by following the instructions at https://www.docker.com/.

On Windows, you can download the latest installer [from here](https://download.docker.com/win/stable/InstallDocker.msi).
Alternatively, you can install it using [Chocolatey](https://chocolatey.org/): `choco install docker-for-windows`.

After the installation is finished, make sure that Docker is switched to Linux containers.
On Windows, it could be done by right-clicking the Docker icon in the taskbar and choosing the respective menu item.

### 2. Launching Prisma/DB Demo Suite

To launch the demo suite you will need to open your command line interface. On Windows, you may launch PowerShell; on Mac, you can launch Terminal app; if you are on Linux, you sure know what to do :)

**1)** Pull the latest image of MySQL with Prisma/DB libraries:

`> docker pull bazzilic/prismadb-mysql`

And launch it, setting the root password to `toor`:

`> docker run -d --rm -p 3306:3306 --name prismadb-db -e MYSQL_ROOT_PASSWORD=toor bazzilic/prismadb-mysql`

Note, that it takes about 30 seconds before the db server starts accepting connections.

**2)** Download the latest image of Prisma/DB Proxy

Download from `http://aoa.cczy.my/prismadb/prismadb-proxy-mysql-5d193957ed57.tar`

Load the image,

`> docker load /path/to/prismadb-proxy-mysql-5d193957ed57.tar`

And launch it as well, linking it to the database container.
`> docker run --rm -d --name prismadb-proxy -p 4000:4000 --link=prismadb-db -e ListenPort=4000 -e ServerAddress=prismadb-db -e ServerPort=3306 -e Database=testdb 155.69.149.158:5000/prismadb-proxy-mysql`

**3)** Obtain MySQL client to connect to the database through the Prisma/DB Proxy

We recommend HeidiSQL, available at `https://www.heidisql.com/download.php`

The MySQL CLI, Shell, or Workbench is currently not supported.

**4)** Register the MySQL user into the proxy

To be able to connect to the server, the proxy needs to know the credentials of the users, as passwords obtained from the client are hashed.

Connect to the proxy using the following parameters:

```
Server:   localhost
Port:     4000
Username: init
Password: init
```

Register the user:

```SQL
PRISMADB REGISTER USER 'root' PASS 'toor';
```

And logout of the session.

**5)** Try out the encrypted database

Log back into the proxy using the following parameters:

```
Server:   localhost
Port:     4000
Username: root
Password: toor
```

Now you can use some of the following queries to try out the encrypted database:

```SQL
CREATE TABLE t1
(
	a INT ENCRYPTED FOR (INTEGER_MULTIPLICATION, INTEGER_ADDITION, SEARCH),
	b INT ENCRYPTED FOR (INTEGER_MULTIPLICATION, INTEGER_ADDITION, SEARCH),
	c INT,
	d VARCHAR(30) ENCRYPTED FOR (STORE, SEARCH),
	e VARCHAR(30)
);

INSERT INTO t1 (a, b, c, d, e) VALUES
( 1,  2,   3, 'Hello', 'Prisma/DB'),
(12,  0,   7, 'Test', 'data'),
( 0,  2, 123, 'This is encrypted', 'And this is not'),
(71, 67,  13, 'Last', 'row');

-- Arithmetic operations and search over encrypted values
SELECT a, b, a + b AS `SUM`, b * a AS `MUL`, (b * a) + b AS `EXPR`
FROM   t1
WHERE  b = 2;
```

Please note that Prisma/DB currently supports only a subset of the full SQL.
We are constantly working to support more.
If you encounter a problem with your queries, please head to the Issues section and let us know!

Connect to the database server directly (it's at `localhost:3306`) using any database management tool (HeidiSQL, MySQL Workbench, etc.) and you would be able to see the partially encrypted database as it is stored on the server, with the data in selected columns being encrypted.
