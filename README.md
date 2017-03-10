# Prisma/DB
[Prisma/DB](http://prismadb.com/) (http://prismadb.com/) is a cryptographic security layer for relational database systems. Started as a research project in [Nanyang Technological University](http://www.ntu.edu.sg/Pages/home.aspx) (Singapore), it is now on the way to becoming a usable product.

## Try it out!
The easiest way to try out Prisma/DB is to use Docker for Windows to set up the database server without cluttering your machine.

### 1. Docker Prerequisites
Docker for Windows installer will do it for you, but you can enable the prerequisites manually. **Important**: enabling Hyper-V will disable VirtualBox or any other virtualization manager, you won't be able to start your virtual machines until you disable Hyper-V (or migrate your VMs to Hyper-V).

Docker for Windows, requires `Microsoft-Hyper-V` and `Containers` features of Windows to be enabled. Using Powershell:

```Powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
Enable-WindowsOptionalFeature -Online -FeatureName Containers -All
```

Or, using [Chocolatey](https://chocolatey.org/):

`choco install --source=windowsfeatures Microsoft-Hyper-V Containers`

Either way, commands must be executed from an elevated shell (run as Administrator). Reboot the system for these features to finish installation.

### 2. Installing Docker for Windows
If you don't already have Docker for Windows, download [the latest version here](https://download.docker.com/win/stable/InstallDocker.msi) and install it. Alternatively, you can install it using Chocolatey: `choco install docker-for-windows`.

After the installation is finished, switch Docker for Windows to Windows containers. It could be done by right-clicking the Docker icon in the taskbar and choosing the according menu item. From the command line it could be done with this command:

`$env:ProgramFiles\Docker\Docker\DockerCli.exe -SwitchDaemon`

Execute `docker version` to see if the Server is set to Windows, not Linux.

### 3. Launching Prisma/DB

All docker images in this demo are built on top of `microsoft/windowsservercore`, so the first launch might take some time due to the size of base image that needs to be downloaded (~4-5 GB). However, docker is smart and only needs to pull the base image once.

1. Download the latest release of Prisma/DB and unpack it.
2. From command prompt run the script `launch.ps1` and wait until you see the SQLCMD prompt:
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

INSERT INTO TT (TT.a, TT.b, TT.c, TT.d, TT.e) VALUES
( 1,  2,   3, 'Hello', 'Prisma/DB'),
(12,  0,   7, 'Test', 'data'),
( 0, 90, 123, 'This is encrypted', 'And this is not'),
(71, 67,  13, 'Last', 'row')

-- Arithmetic operations over encrypted values
SELECT TT.a, TT.b, TT.a + TT.b AS [SUM], TT.b * TT.a AS [MUL], (TT.b * TT.a) + TT.b AS [EXPR]
FROM   TT
```

Connect to the database server directly (find IP address by calling the `get-SQL-Server-IPAddr.ps1` script, the port is 1433) using any database management tool (SSMS, dbeaver) and ensure that the database is indeed encrypted.
