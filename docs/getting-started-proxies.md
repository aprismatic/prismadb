# Getting Started (Proxies)

If you would just like the simplest way to get started to try Prisma/DB, head over to our [demo instructions](https://github.com/aprismatic/prismadb/blob/master/README.md)!

## 1. Setting Up

In any deployment, there will be 2 components, the actual database server, and the Prisma/DB proxy.

### 1.1 Database Server

Prisma/DB currently supports PostgreSQL, MySQL, MariaDB, CockroachDB and Microsoft SQL Server. If you already have a running installation of any of those databases, you will not need to do anything else for the database server component.

However, if you would like to use homomorphic encryption schemes such as `ADDITION` and `MULTIPLICATION`, the database server needs to have Prisma/DB's custom user-defined functions (UDF) installed (except for Microsoft SQL Server, as Prisma/DB can dynamically create those UDFs). The easiest way to get a database server running with Prisma/DB's UDFs is to use our [supporting Docker images](../docker-images#supporting-images). Sample scripts to get the database server up and running are available in our [code section](https://github.com/aprismatic/prismadb/tree/master/sample-scripts), for example, [this is a script for PostgreSQL](https://github.com/aprismatic/prismadb/blob/master/sample-scripts/postgres/bash/run-db.sh).

### 1.2 Prisma/DB Proxy

Depending on your database server, you would need to use the appropriate build of the Prisma/DB proxy. For example, if your database is MySQL, you will use the MySQL build, and if your database is CockroachDB, you will use the PostgreSQL build. For easy deployment, Prisma/DB proxies are packaged as Docker images, with the full list [here](../docker-images). If a license key is not applied, they will run in trial mode, with importing and exporting of encryption keys disabled.

Sample scripts to get the Prisma/DB proxy up and running are available in our [code section](https://github.com/aprismatic/prismadb/tree/master/sample-scripts), for example, [this is a script for PostgreSQL](https://github.com/aprismatic/prismadb/blob/master/sample-scripts/postgres/bash/run-proxy.sh). Full set of configuration options are available [here](../configuration-options) to customize the behaviour of the proxy.

#### 1.2.1 Loading your license key

If you have a license, there are 2 ways that you can load the license.

The first way is to use the physical key file before starting the proxy. First make sure that a volume is mapped to the `/data/` directory of the container, if you are using the default path for the license key file. Place the license key file in the mapped directory before starting the proxy. The proxy should load the license key, and the banner message in the logs will reflect the license status.

The second way is to use the [`LICENSE SET KEY`](../native-commands#license-set-key) command. This works if the proxy is already running and you want a fast and easy way to update the license.

## 2. First Start

You may now login to the Prisma/DB proxy with a [client](../supported-clients) of your choice using any credentials that matches those in the actual database server. Do note that certain actions (e.g. `PRISMADB...` commands) can only executed by the administrative user. The administrative user is the database's root user (e.g. `sa` for SQL Server) by default, but can be changed with the [configuration options](../configuration-options) in step 1.

### 2.1 If you are running the MySQL version of Prisma/DB Proxy

Due to how the MySQL protocol is designed, the Primsa/DB proxy is unable to obtain the user's password from the client during authentication. Therefore, on first start, you will need to tell the proxy what are the credentials that it will be authenticating with. To do this, login to the proxy using the following credentials: username=`init`, password=`init` as how you would a normal user, and perform the [`REGISTER USER`](../native-commands#register-user-mysql-only) command for your intended user. You can now logout, and log back in as the intended user. For security reasons, once a user has been registered, the `init/init` credentials is immediately disabled by the proxy.

## 3. Creating Tables

Now that you are logged in through the proxy, you may proceed to create your schema. Prisma/DB currently supports a subset of the SQL language of each database. Using our [`CREATE TABLE`](../data-definition-statements/#create-table) syntax, you can create tables similar to how you would usually, but with the inclusion of encryption options.

### 3.1 Choosing Encryption Schemes

Prisma/DB has multiple [encryption schemes](../encryption-schemes) available, all of which has different purposes, and have their respective pros and cons. For example, if you need to perform computation over numeric columns, you will need to encrypt those columns with `ADDITION` and `MULTIPLICATION`. If performance is your priority, and you do not require any other features, you should choose `STORE` (AES).

If you need to perform comparison operations on the columns such as `=`, `<`, `>=` on the columns, you will need `SEARCH` or `RANGE`. `SEARCH` is more secure, but generally slower when querying as it introduces false positive by design. `RANGE` is less secure, but it enables operations such as `>` and `<=`. `RANGE` is implemented with a binary tree, and would need to be re-balanced occasionally, which takes introduces quite a bit of downtime as it involves updating the entire database. For a quick overview of the encryption schemes, we have a [support matrix](../encryption-schemes#support-matrix) that shows the features enabled by each encryption scheme.

## 4. Querying

As Prisma/DB aims to be as transparent as possible, the data manipulation language (DML) ([`INSERT`](../data-manipulation-statements/#insert), [`SELECT`](../data-manipulation-statements/#select), [`UPDATE`](../data-manipulation-statements/#update) etc.) follows the target database server, and supported syntax is growing rapidly.

## 5. Maintenance

### 5.1 Exporting encryption keys

The [`PRISMADB KEYS EXPORT`](../native-commands#keys-export) command exports the encryption keys into a JSON file for safekeeping. If you are running the Prisma/DB proxy in a Docker container, you will then need to extract the file from the container using the `docker cp` Docker command. This JSON file will be needed the next time the Prisma/DB proxy is started up.

### 5.2 Performance

To improve performance when performing searches and comparison operations, it is recommended to [create indexes](../data-definition-statements/#create-index) on those columns.

Only use the `WILDCARD` encryption scheme when absolutely necessary. It uses full-text search in the backend, and comes with significant performance degradation.

### 5.3 Order preserving encoding tree

If the `RANGE` encryption scheme is used anywhere in the schema, an Order Preserving Encoding (OPE) binary tree will be utilized. This tree has a maximum height of 63 nodes, and once that height is reached, you will be unable to insert any more rows/values into the database. Therefore, a [`PRISMADB OPETREE REBUILD`](../native-commands#opetree-rebuild) command needs to be performed from time to time.

If you are inserting a lot of consecutively increasing/decreasing values into a column with `RANGE` encryption, you may reach the maximum tree height very easily. In such scenarios, you may execute a [`PRISMADB OPETREE INSERT VALUES(...)`](../native-commands#opetree-insert) command to seed the OPE tree first before inserting the data.

Rebalancing of the OPE tree is time consuming, and will introduce downtime as the entire database is updated. Therefore, the command should be scheduled during maintenance periods.

### 5.4 Changing encryption schemes

The [`PRISMADB ENCRYPT`](../native-commands#encrypt) and [`DECRYPT`](../native-commands#decrypt) commands encrypts and decrypts a column respectively. If you want to change the encryption of a column, currently the only way is to perform an `ENCRYPT`, followed by a `DECRYPT` command. This can be a time consuming process, depending on number of records. and will introduce downtime for the affected column. Therefore, this command should be scheduled during maintenance periods.

### 5.5 Changing encryption keys

To change the encryption keys, you will need to perform a [`PRISMADB KEYS UPDATE`](../native-commands#keys-update) command. Prisma/DB will generate a new set of keys, and re-encrypt all of the columns in the database. This is a very time consuming process, and will introduce downtime as the entire database is updated. Therefore, this command should be scheduled during maintenance periods. You will need to [export the keys](../#51-exporting-encryption-keys) after the update keys command is completed to export the new set of encryption keys for safekeeping.

### 5.6 Running multiple instances of Prisma/DB proxy

Prisma/DB has partial support for running multiple instances of the proxy. The main considerations are sharing of the database schema, and the OPE tree.

The database schema is stored in a table named `PrismaDB_Schema`. It is automatically saved when a change is made to the schema, and automatically loaded on the first query of every startup of the Prisma/DB proxy. However, while the proxies are running, and a change to the schema is made, a [`PRISMADB SCHEMA LOAD`](../native-commands#schema-load) command would need to be executed on all other proxies to update the proxies' knowledge of the schema.

Currently, the OPE tree cannot sync between multiple instances, therefore, if multiple instances is a must, `RANGE` encryption should not be used, or there may be unexpected behavior.

### 5.7 Updating license

If your current license has expired, you will be unable to to perform queries. To update the license, simply replace the current license key file in the mapped `/data/` directory, and run a [`PRISMADB LICENSE REFRESH`](../native-commands#license-refresh) command to update your license.

### 5.8 Shutting down

If a shutdown is planned, it is recommended to save the OPE tree with the [`PRISMADB OPETREE SAVE`](../native-commands#opetree-save) command, as the OPE tree resides in the memory during normal operation. This command will save the OPE tree to the database for persistent storage, and when the proxy is started up again, it will load the tree from the database automatically.

## 6. Subsequent Starts

On subsequent start ups, the encryption keys will need to be imported into the proxy so that data can be encrypted and decrypted correctly. This can be done by setting the [configuration option](../configuration-options) for the settings file path. For example, [this is a script for PostgreSQL](https://github.com/aprismatic/prismadb/blob/master/sample-scripts/postgres/bash/run-proxy.sh). All other settings such as the database schema and OPE tree, will be loaded from the database automatically on the first query.
