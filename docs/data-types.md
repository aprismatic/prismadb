# Data Types

## MySQL

| Data Type           | Description                                                                                                                       |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `INT`               | 4 bytes signed integer.                                                                                                           |
| `TINYINT`           | 1 byte signed integer.                                                                                                            |
| `SMALLINT`          | 2 bytes signed integer.                                                                                                           |
| `BIGINT`            | 8 bytes signed integer.                                                                                                           |
| `FLOAT`             | 4 bytes floating-point numeric value.                                                                                             |
| `DOUBLE`            | 8 bytes floating-point numeric value.                                                                                             |
| `DECIMAL`           | Exact precision numeric value.                                                                                                    |
| `CHAR[(length)]`    | Fixed length string with optional length described in parenthesis. If length is not defined, it defaults to a length of 1.        |
| `VARCHAR(length)`   | Variable length string with compulsory maximum length described in parenthesis.                                                   |
| `TEXT`              | Non-indexed / unsearchable variable length string.                                                                                |
| `BINARY[(length)]`  | Fixed length binary string with optional length described in parenthesis. If length is not defined, it defaults to a length of 1. |
| `VARBINARY(length)` | Variable length binary string with compulsory maximum length described in parenthesis.                                            |
| `DATE`              | Date value in `'YYYY-MM-DD'` format.                                                                                              |
| `DATETIME`          | Date and time values in `'YYYY-MM-DD HH:MM:SS'` format.                                                                           |
| `TIMESTAMP`         | Date and time values in `'YYYY-MM-DD HH:MM:SS'` format in UTC.                                                                    |
| `ENUM(value,...)`   | String object with a corresponding numeric index.                                                                                 |
| `BLOB`              | Non-indexed / unsearchable variable length binary data.                                                                           |

## SQL Server

| Data Type             | Description                                                                                                                                  |
| --------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `INT`                 | 4 bytes signed integer.                                                                                                                      |
| `TINYINT`             | 1 byte unsigned integer.                                                                                                                     |
| `SMALLINT`            | 2 bytes signed integer.                                                                                                                      |
| `BIGINT`              | 8 bytes signed integer.                                                                                                                      |
| `FLOAT`               | 8 bytes floating-point numeric value.                                                                                                        |
| `DECIMAL`             | Exact precision numeric value.                                                                                                               |
| `CHAR[(length)]`      | Fixed length string with optional length described in parenthesis. If length is not defined, it defaults to a length of 1.                   |
| `VARCHAR[(length)]`   | Variable length string with optional length described in parenthesis. If length is not defined, it defaults to a length of 1.                |
| `NCHAR[(length)]`     | Fixed length Unicode string with optional length described in parenthesis. If length is not defined, it defaults to a length of 1.           |
| `NVARCHAR[(length)]`  | Variable length Unicode string with optional length described in parenthesis. If length is not defined, it defaults to a length of 1.        |
| `TEXT`                | Non-indexed / unsearchable variable length string.                                                                                           |
| `BINARY[(length)]`    | Fixed length binary string with optional length described in parenthesis. If length is not defined, it defaults to a length of 1.            |
| `VARBINARY[(length)]` | Variable length binary string with optional maximum length described in parenthesis. If length is not defined, it defaults to a length of 1. |
| `UNIQUEIDENTIFIER`    | GUID value.                                                                                                                                  |
| `DATE`                | Date value in `'YYYY-MM-DD'` format.                                                                                                         |
| `DATETIME`            | Date and time values in `'YYYY-MM-DD HH:MM:SS'` format.                                                                                      |

- `length` values for SQL Server datatypes can also be defined as `MAX`.

## PostgreSQL

| Data Type                     | Description                                                                                      |
| ----------------------------- | ------------------------------------------------------------------------------------------------ |
| `INT4` / `INT` / `INTEGER`    | 4 bytes signed integer.                                                                          |
| `INT2` / `SMALLINT`           | 2 bytes signed integer.                                                                          |
| `INT8` / `BIGINT`             | 8 bytes signed integer.                                                                          |
| `SERIAL`                      | 4 bytes signed auto-incrementing integer.                                                        |
| `FLOAT4` / `REAL`             | 4 bytes floating-point numeric value.                                                            |
| `FLOAT8` / `DOUBLE PRECISION` | 8 bytes floating-point numeric value.                                                            |
| `DECIMAL`                     | Exact precision numeric value.                                                                   |
| `CHAR[(length)]`              | Fixed length string with optional length described in parenthesis.                               |
| `VARCHAR[(length)]`           | Variable length string with optional length described in parenthesis.                            |
| `TEXT[(length)]`              | Non-indexed / unsearchable variable length string with optional length described in parenthesis. |
| `BYTEA`                       | Variable length binary string.                                                                   |
| `DATE`                        | Date value in `'YYYY-MM-DD'` format.                                                             |
| `TIMESTAMP`                   | Date and time values in `'YYYY-MM-DD HH:MM:SS'` format.                                          |
