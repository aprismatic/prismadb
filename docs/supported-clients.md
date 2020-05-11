# Supported Clients

## MySQL

| Client              | URL                                                   | Supported |
| ------------------- | ----------------------------------------------------- | --------- |
| MySQL CLI           | <<https://dev.mysql.com/doc/refman/8.0/en/mysql.html> | Yes       |
| MySQL Shell         | <https://dev.mysql.com/downloads/shell/>              | Yes       |
| HeidiSQL            | <https://www.heidisql.com/>                           | Yes       |
| pymysql             | <https://pymysql.readthedocs.io/en/latest/>           | Yes       |
| .NET MySqlConnector | <https://www.nuget.org/packages/MySqlConnector/>      | Yes\*     |
| .NET MySql.Data     | <https://www.nuget.org/packages/MySql.Data/>          | Yes\*     |
| MySQL Workbench     | <https://dev.mysql.com/downloads/workbench/>          | No        |

## SQL Server

| Client                       | URL                                                                                    | Supported |
| ---------------------------- | -------------------------------------------------------------------------------------- | --------- |
| sqlcmd                       | <https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility>                            | Yes       |
| pymssql                      | <http://pymssql.org/en/stable/>                                                        | Yes       |
| .NET System.Data.SqlClient   | <https://www.nuget.org/packages/System.Data.SqlClient/>                                | Yes\*     |
| SQL Server Management Studio | <https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms> | No        |
| HeidiSQL                     | <https://www.heidisql.com/>                                                            | No        |

## PostgreSQL

| Client      | URL                                                     | Supported |
| ----------- | ------------------------------------------------------- | --------- |
| Psql        | <https://www.postgresql.org/docs/current/app-psql.html> | Yes       |
| .NET Npgsql | <https://www.npgsql.org/>                               | Yes\*     |
| HeidiSQL    | <https://www.heidisql.com/>                             | Partial   |

> \* Prepared statements are not supported. Therefore, for some clients (especially .NET clients), you may need to set `SqlCommand.CommandType` to `CommandType.Text`.
