# Configuration Options

The Prisma/DB proxies can be started with the configuration either set in command-line, a JSON file or as environment variables.

If an configuration option is present in multiple locations, they will be loaded in the following order, with the next location overwriting the previous configuration set:

1. JSON file
1. Environment variables
1. Command-line

For the JSON settings file, it should be named as `settings.json` and placed in the root folder of the proxy application folder.

## MySQL

| CLI Option | JSON/Env Variable | Description                                                                   | Required | Default             |
| ---------- | ----------------- | ----------------------------------------------------------------------------- | -------- | ------------------- |
| `-s`       | `ServerAddress`   | Network address of the MySQL server.                                          | Yes      |
| `-t`       | `ServerPort`      | TCP port, on which the MySQL listens.                                         | No       | `3306`              |
| `-d`       | `Database`        | Name of the database to use.                                                  | No       |
| `-u`       | `UserId`          | Username to authenticate the session with the database server.                | No       | `root`              |
| `-p`       | `Password`        | Password that matches the username.                                           | No       |
| `-l`       | `ListenPort`      | Local port, on which the proxy will listen.                                   | No       | `3306`              |
| `-a`       | `ListenAddress`   | Local IP address, on which the proxy will listen.                             | No       | `0.0.0.0`           |
| `-cv`      | `ConsoleVerbose`  | Verbosity of console logging.                                                 | No       | `15`                |
| `-fv`      | `LogFileVerbose`  | Verbosity of file logging.                                                    | No       | `0`                 |
| `-sc`      | `SslCertPath`     | Path to X.509 certificate in PKCS #12 format to enable SSL (\*.pfx).          | No       |
| `-ce`      | `CommunityEd`     | Run proxy in community edition mode.                                          | No       | `false`             |
| `-lk`      | `LicenseKeyPath`  | Path to the license key to enable importing and exporting of encryption keys. | No       | `/data/license.key` |
| `-kf`      | `KeyfilePath`     | Path to the JSON file with Prisma/DB encryption keys.                         | No       | `/data/keys.json`   |
| `-au`      | `AdminUserId`     | Username to authenticate the session with Prisma/DB administrative rights.    | No       | `root`              |

## SQL Server

| CLI Option | JSON/Env Variable | Description                                                                   | Required | Default             |
| ---------- | ----------------- | ----------------------------------------------------------------------------- | -------- | ------------------- |
| `-s`       | `DataSource`      | Network address (with port / instance) of the SQL Server.                     | Yes      |
| `-d`       | `InitialCatalog`  | Name of the database to use.                                                  | Yes      |
| `-l`       | `ListenPort`      | Local port, on which the proxy will listen.                                   | No       | `1433`              |
| `-a`       | `ListenAddress`   | Local IP address, on which the proxy will listen.                             | No       | `0.0.0.0`           |
| `-n`       | `ServerName`      | Name of proxy server to display to clients.                                   | No       | `Prisma/DB Proxy`   |
| `-cv`      | `ConsoleVerbose`  | Verbosity of console logging.                                                 | No       | `15`                |
| `-fv`      | `LogFileVerbose`  | Verbosity of file logging.                                                    | No       | `0`                 |
| `-ce`      | `CommunityEd`     | Run proxy in community edition mode.                                          | No       | `false`             |
| `-lk`      | `LicenseKeyPath`  | Path to the license key to enable importing and exporting of encryption keys. | No       | `/data/license.key` |
| `-kf`      | `KeyfilePath`     | Path to the JSON file with Prisma/DB encryption keys.                         | No       | `/data/keys.json`   |
| `-au`      | `AdminUserId`     | Username to authenticate the session with Prisma/DB administrative rights.    | No       | `sa`                |

## PostgreSQL

| CLI Option | JSON/Env Variable | Description                                                                    | Required | Default             |
| ---------- | ----------------- | ------------------------------------------------------------------------------ | -------- | ------------------- |
| `-s`       | `ServerAddress`   | Network address of the PostgreSQL server.                                      | Yes      |
| `-t`       | `ServerPort`      | TCP port, on which the PostgreSQL listens.                                     | No       | `5432`              |
| `-d`       | `Database`        | Name of the database to use.                                                   | No       |
| `-l`       | `ListenPort`      | Local port, on which the proxy will listen.                                    | No       | `5432`              |
| `-a`       | `ListenAddress`   | Local IP address, on which the proxy will listen.                              | No       | `0.0.0.0`           |
| `-cv`      | `ConsoleVerbose`  | Verbosity of console logging.                                                  | No       | `15`                |
| `-fv`      | `LogFileVerbose`  | Verbosity of file logging.                                                     | No       | `0`                 |
| `-sc`      | `SslCertPath`     | Path to X.509 certificate in PKCS #12 format to enable SSL (\*.pfx).           | No       |
| `-ce`      | `CommunityEd`     | Run proxy in community edition mode.                                           | No       | `false`             |
| `-lk`      | `LicenseKeyPath`  | Path to the license key to enable importing and exporting of encryption keys.  | No       | `/data/license.key` |
| `-kf`      | `KeyfilePath`     | Path to the JSON file with Prisma/DB encryption keys.                          | No       | `/data/keys.json`   |
| `-au`      | `AdminUserId`     | Username to authenticate the session with Prisma/DB administrative rights.     | No       | `postgres`          |
| `-cc`      | `CockroachMode`   | Enables CockroachDB compatibility mode for connecting to a CockroachDB server. | No       | `false`             |

## Logging

### Verbosity Values

The parameters for console & log file verbosity are bitwise OR operations of the listed values below.
For example, to log `SERVER_ERROR` and `SERVER_DEBUG` to a file, the resulting parameter value is `18`.
To not log anything to the ouput, set the value to `0`.

| Message Types    | Value  |
| ---------------- | ------ |
| `SERVER_FATAL`   | `1`    |
| `SERVER_ERROR`   | `2`    |
| `SERVER_WARN`    | `4`    |
| `SERVER_INFO`    | `8`    |
| `SERVER_DEBUG`   | `16`   |
| `SERVER_TRACE`   | `32`   |
| `QUERY_ERROR`    | `64`   |
| `QUERY_RECEIVED` | `128`  |
| `QUERY_PARSED`   | `256`  |
| `QUERY_EXECUTED` | `512`  |
| `QUERY_RESPONSE` | `1024` |

### Log File Behaviour

If logging to file is enabled, logs will be stored in the `/logs/` folder, relative to the location of the Prisma/DB executable. The logs rotate every day, and logs for the past 30 days are kept. The current active log is saved as `log.txt`, while history logs have the date appended to the filename. There is currently no option to change the behaviour of file logging.
