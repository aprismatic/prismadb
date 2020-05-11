# Changelog

## [0.4.4] - 2020-04-14

### Added

- Unicode support for MySQL

### Changed

- Changed versioning schema

## [0.4.0.129] - 2019-11-14

### Added

- Option to run proxy in community edition mode.

## [0.4.0.127] - 2019-10-28

### Changed

- Fix loading of license key file.

## [0.4.0.126] - 2019-10-28

### Added

- `PRISMADB CHECK LICENSE STATUS` command.
- `PRISMADB SET LICENSE KEY` command.

### Changed

- `PRISMADB EXPORT KEYS` command's keyfile path is now optional.

## [0.4.0.123] - 2019-10-19

### Added

- Licensing module to proxies. The proxies are no longer separated into trial and full builds, all builds are now published on Docker Hub, and a license key is required to unlock full features.

### Changed

- Product versions are now synchronized between database products.

## Old Changelog Format

### 07-10-2019

| Database   | Version   |
| ---------- | --------- |
| MySQL      | 0.3.5.91  |
| SQL Server | 0.3.5.115 |
| PostgreSQL | 0.3.5.50  |

- [Added] Support for parameterized queries for SQL Server.
- [Added] Partial support for parameterized queries for PostgreSQL.

### 24-08-2019

| Database   | Version   |
| ---------- | --------- |
| MySQL      | 0.3.5.89  |
| SQL Server | 0.3.5.113 |
| PostgreSQL | 0.3.5.48  |

- [Changed] More descriptive error messages for Prisma/DB commands.
- [Fixed] UTF8 handling for MySQL proxy.
- [Fixed] `IN` condition for plaintext `WHERE` columns.
- [Added] `STDEV` function shorthand for standard deviation.

### 12-07-2019

| Database   | Version   |
| ---------- | --------- |
| MySQL      | 0.3.5.86  |
| SQL Server | 0.3.5.111 |
| PostgreSQL | 0.3.5.45  |

- [Added] `PRISMADB BYPASS` command to execute queries directly at the database.

### 03-07-2019

| Database   | Version   |
| ---------- | --------- |
| MySQL      | 0.3.5.84  |
| SQL Server | 0.3.5.109 |
| PostgreSQL | 0.3.5.44  |

- [Fixed] Schema column order stored in database is now maintained after `ENCRYPT` and `DECRYPT` commands.

### 02-07-2019

| Database   | Version   |
| ---------- | --------- |
| MySQL      | 0.3.5.83  |
| SQL Server | 0.3.5.108 |
| PostgreSQL | 0.3.5.43  |

- [Changed] `PRISMADB EXPORT SETTINGS` command is now `PRISMADB EXPORT KEYS`, as it is more representative of what the command achieves. Consequently, the `DatabaseSettings` environment variable is now `KeyfilePath`.
- [Fixed] Prisma/DB schema database store not updated after checking actual schema in database.

### 02-07-2019

| Database   | Version   |
| ---------- | --------- |
| MySQL      | 0.3.5.82  |
| SQL Server | 0.3.5.107 |
| PostgreSQL | 0.3.5.42  |

- [Added] Saving and loading of schema to/from database.
  <br/>https://github.com/bazzilic/PrismaDB-INTERNAL-DEV/issues/93
- [Fixed] Improved error messages.
  <br/>https://github.com/aprismatic/prismadb/issues/14
  <br/>https://github.com/aprismatic/prismadb/issues/21
  <br/>https://github.com/aprismatic/prismadb/issues/26

### 25-06-2019

| Database   | Version   |
| ---------- | --------- |
| MySQL      | 0.3.4.80  |
| SQL Server | 0.3.4.105 |
| PostgreSQL | 0.3.4.40  |

- [Added] Configurable logging targets (console & file) with verbosity filters for proxies.
  <br/>https://github.com/bazzilic/PrismaDB-INTERNAL-DEV/issues/72
- [Removed] Debug Docker images are not built anymore.

### 22-06-2019

| Database   | Version   |
| ---------- | --------- |
| MySQL      | 0.3.3.75  |
| SQL Server | 0.3.3.102 |
| PostgreSQL | 0.3.3.37  |

- [Fixed] Error message for duplicate column name in `CREATE TABLE`.
  <br/>https://github.com/aprismatic/prismadb/issues/4
- [Fixed] `ALTER COLUMN` error message.
  <br/>https://github.com/aprismatic/prismadb/issues/7

### 20-06-2019

| Database   | Version   |
| ---------- | --------- |
| MySQL      | 0.3.3.74  |
| SQL Server | 0.3.3.101 |
| PostgreSQL | 0.3.3.36  |

- [Added] Support for `PRIMARY KEY`.
  <br/>https://github.com/bazzilic/PrismaDB-INTERNAL-DEV/issues/91
- [Added] Support for `CREATE INDEX`.
  <br/>https://github.com/bazzilic/PrismaDB-INTERNAL-DEV/issues/100
- [Fixed] Proper parsing/construction of escape characters for MySQL.
  <br/>https://github.com/bazzilic/PrismaDB-INTERNAL-DEV/issues/101

### 13-06-2019

| Database   | Version   |
| ---------- | --------- |
| MySQL      | 0.3.3.73  |
| SQL Server | 0.3.3.100 |
| PostgreSQL | 0.3.3.35  |

- [Added] Trial builds for user testing.

### 06-06-2019

| Database   | Version  |
| ---------- | -------- |
| MySQL      | 0.3.3.70 |
| SQL Server | 0.3.3.95 |
| PostgreSQL | 0.3.3.32 |

- [Added] Deterministic searching using `Range` for `UPDATE` and `DELETE` queries.
  <br/>https://github.com/bazzilic/PrismaDB-INTERNAL-DEV/issues/99

### 05-06-2019

| Database   | Version  |
| ---------- | -------- |
| MySQL      | 0.3.3.69 |
| SQL Server | 0.3.3.94 |
| PostgreSQL | 0.3.3.31 |

- [Added] Deterministic searching using `Range` when available, resulting in exponentially faster `SELECT`s, with speed increases anywhere from 2x to 200x for compatible queries.
  <br/>https://github.com/bazzilic/PrismaDB-INTERNAL-DEV/issues/5
- [Added] Multi-threaded encryption updates, resulting in speed increases of `UPDATE KEYS`, `ENCRYPT`, etc. commands up to 20x.

### 31-05-2019

| Database   | Version  |
| ---------- | -------- |
| MySQL      | 0.3.3.64 |
| SQL Server | 0.3.3.92 |
| PostgreSQL | 0.3.3.28 |

- [Added] New Order Preserving Encoding (OPE) for `RANGE` encryption.
  <br/>https://github.com/bazzilic/PrismaDB-INTERNAL-DEV/issues/95
- [Removed] Removed existing range fingerprint scheme for `RANGE` encryption.
- [Changed] Full support for `MIN()` and `MAX()`.

### 19-05-2019

| Database   | Version  |
| ---------- | -------- |
| MySQL      | 0.3.2.59 |
| SQL Server | 0.3.2.85 |
| PostgreSQL | 0.3.2.23 |

- [Changed] All returned data in result tables are either in `decimal` for floating point values and `long` for integer values.
  <br/>https://github.com/bazzilic/PrismaDB-INTERNAL-DEV/issues/78
- [Changed] Size of Docker images have been shrunk by about 80MB.

### 16-05-2019

| Database   | Version  |
| ---------- | -------- |
| MySQL      | 0.3.1.58 |
| SQL Server | 0.3.1.84 |
| PostgreSQL | 0.3.1.22 |

- [Fixed] NULL exception when performing complex computations over multiple threads.

### 15-05-2019

| Database   | Version  |
| ---------- | -------- |
| MySQL      | 0.3.1.57 |
| SQL Server | 0.3.1.83 |
| PostgreSQL | 0.3.1.21 |

- [Fixed] Overflow issue when returning result after a large number of homomorphic computations.
  <br/>https://github.com/bazzilic/PrismaDB-INTERNAL-DEV/issues/88

### 12-05-2019

| Database   | Version  |
| ---------- | -------- |
| MySQL      | 0.3.1.56 |
| SQL Server | 0.3.1.82 |
| PostgreSQL | 0.3.1.20 |

- [Changed] More descriptive error messages for `LINREG()`.

### 09-05-2019

| Database   | Version  |
| ---------- | -------- |
| MySQL      | 0.3.1.55 |
| SQL Server | 0.3.1.81 |
| PostgreSQL | 0.3.1.19 |

- [Added] Multiple table support for `LINREG()`.
- [Changed] Internal structure of `FROM`.
  <br/>https://github.com/bazzilic/PrismaDB-INTERNAL-DEV/issues/84

### 07-05-2019

| Database   | Version  |
| ---------- | -------- |
| MySQL      | 0.3.1.54 |
| SQL Server | 0.3.1.80 |
| PostgreSQL | 0.3.1.18 |

- [Fixed] Fixed support for `NULL`s in intermediate queries.

### 03-05-2019

| Database   | Version  |
| ---------- | -------- |
| MySQL      | 0.3.1.53 |
| SQL Server | 0.3.1.79 |
| PostgreSQL | 0.3.1.17 |

- [Changed] Faster TCP connectivity with clients, especially MySQL and PostgreSQL.
  <br/>https://github.com/bazzilic/PrismaDB-INTERNAL-DEV/issues/87

### 30-04-2019

| Database   | Version  |
| ---------- | -------- |
| MySQL      | 0.3.1.52 |
| SQL Server | 0.3.1.78 |
| PostgreSQL | 0.3.1.16 |

- [Changed] Increased precision for `LINREG()`.

### 30-04-2019

| Database   | Version  |
| ---------- | -------- |
| MySQL      | 0.3.1.51 |
| SQL Server | 0.3.1.77 |
| PostgreSQL | 0.3.1.15 |

- [Added] Initial support for `MIN()`, `MAX()` and `LINREG()`.
  <br/>https://github.com/bazzilic/PrismaDB-INTERNAL-DEV/issues/76

### 16-04-2019

| Database   | Version  |
| ---------- | -------- |
| PostgreSQL | 0.3.1.13 |

- [Added] `-CockroachMode` flag to enable CockroachDB compatibility mode for connecting to a CockroachDB server.

### 15-04-2019

| Database   | Version  |
| ---------- | -------- |
| MySQL      | 0.3.1.49 |
| SQL Server | 0.3.1.75 |
| PostgreSQL | 0.3.1.12 |

- [Added] Decimal datatype support.
  <br/>https://github.com/bazzilic/PrismaDB-INTERNAL-DEV/issues/79
- [Added] Preliminary CockroachDB support.
  <br/>https://github.com/bazzilic/PrismaDB-INTERNAL-DEV/issues/73
- [Fixed] AST `Eval()` always cast to int for comparison.
  <br/>https://github.com/bazzilic/PrismaDB-INTERNAL-DEV/issues/86
- [Fixed] Paillier encryption with denominator that is too large.
  <br/>https://github.com/bazzilic/PrismaDB-INTERNAL-DEV/issues/88
