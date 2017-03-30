# Prisma/DB
[Prisma/DB](http://prismadb.com/) (http://prismadb.com/) is a cryptographic security layer for relational database systems.
Started as a research project in [Nanyang Technological University](http://www.ntu.edu.sg/Pages/home.aspx) (Singapore), it is now on the way to becoming a usable product.

## Try it out!
The easiest way to try out Prisma/DB is to use Docker for Windows to set up the database server without cluttering your machine.

**Important**: Enabling Hyper-V (required by Docker) will disable VirtualBox or any other virtualization manager.
You won't be able to start your virtual machines until you disable Hyper-V (or migrate your VMs to Hyper-V).

### 1. Installing Docker for Windows
If you don't already have Docker for Windows, download [the latest version here](https://download.docker.com/win/stable/InstallDocker.msi) and install it.
Alternatively, you can install it using [Chocolatey](https://chocolatey.org/): `choco install docker-for-windows`.

After the installation is finished, switch Docker to Windows containers.
It could be done by right-clicking the Docker icon in the taskbar and choosing the respective menu item.
From the command line it could be done with this command:

`$env:ProgramFiles\Docker\Docker\DockerCli.exe -SwitchDaemon`

Execute `docker version` to see if the Server is set to Windows, not Linux.

### 2. Launching Prisma/DB

All Docker images in this demo are built on top of `microsoft/windowsservercore`, so the first launch might take some time due to the size of base image that needs to be downloaded (~4-5 GB).
However, Docker is smart and only needs to pull the base image once.

1. [Download the latest release](https://github.com/PrismaDB/PrismaDB/releases) of Prisma/DB and unpack it.

2. From command prompt run the script `launch.ps1`.

3. On a typical Windows 10 install, you will be prompted to allow new application to access network. Make sure to allow it to access public networks:  
![](https://raw.githubusercontent.com/PrismaDB/PrismaDB/master/img/firewall.png)

4. Wait until you see the SQLCMD prompt:  
![](https://raw.githubusercontent.com/PrismaDB/PrismaDB/master/img/sqlcmd.gif)
 * If you are having troubles running the script, make sure that your Powershell execution policy is set to `RemoteSigned` (see this instruction: https://superuser.com/a/106363)

3. Use some of the following queries to try out the encrypted database:

```SQL
CREATE TABLE TT
(
	a INT ENCRYPTED FOR (INTEGER_MULTIPLICATION, INTEGER_ADDITION, SEARCH),
	b INT ENCRYPTED FOR (INTEGER_MULTIPLICATION, INTEGER_ADDITION, SEARCH),
	c INT,
	d VARCHAR(100) ENCRYPTED FOR (TEXT, SEARCH),
	e VARCHAR(100)
)
GO

INSERT INTO TT (TT.a, TT.b, TT.c, TT.d, TT.e) VALUES
( 1,  2,   3, 'Hello', 'Prisma/DB'),
(12,  0,   7, 'Test', 'data'),
( 0,  2, 123, 'This is encrypted', 'And this is not'),
(71, 67,  13, 'Last', 'row')
GO

-- Arithmetic operations over encrypted values
SELECT TT.a, TT.b, TT.a + TT.b AS [SUM], TT.b * TT.a AS [MUL], (TT.b * TT.a) + TT.b AS [EXPR]
FROM   TT
WHERE  TT.b = 2
GO
```

Connect to the database server directly (find IP address by calling the `get-SQL-Server-IPAddr.ps1` script, the port is 1433) using any database management tool (SSMS, HeidiSQL, dbeaver) and ensure that the database is indeed encrypted.
