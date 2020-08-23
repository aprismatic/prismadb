# Native Commands

Native commands control the operation of the Prisma/DB proxy, and is only executable by the administrative user defined in the environment variables / command line option / settings file.

## KEYS EXPORT

The database encryption keys will be saved to the specified `file_uri`.

```
PRISMADB KEYS EXPORT [TO file_uri]
```

- `file_uri` is a string literal value. For more information, refer to [Language Structure - Literal Values](../language-structure#literal-values)
- If the optional `[TO file_uri]` is omitted, it will be saved in the default directory and filename.

#### Examples

```
PRISMADB KEYS EXPORT;
PRISMADB KEYS EXPORT TO '/data/keys.json';
```

## KEYS UPDATE

The database encryption keys will be regenerated and all columns in the database will be re-encrypted using the new keys.

```
PRISMADB KEYS UPDATE [STATUS]
```

- This command executes asynchronously in the background for proxy containers.
- If the optional `[STATUS]` is appended to the command, Prisma/DB will return a result table with the current progress of the command.

#### Examples

```
PRISMADB KEYS UPDATE;
```

## ENCRYPT

The specified column will be encrypted with the new encryption schemes, and any required supporting columns will be added.

```
PRISMADB ENCRYPT column [FOR (encryption_type,...)] [STATUS]
```

- This command executes asynchronously in the background for proxy containers.
- If the optional `[STATUS]` is appended to the command, Prisma/DB will return a result table with the current progress of the command.
- For more information on `column`, refer to [Language Structure - Schema Object Names (MySQL)](../language-structure#mysql_1) or [Language Structure - Schema Object Names (SQL Server)](../language-structure#sql-server_1)
- For more information on `encryption_type`, refer to [Encryption Schemes](../encryption-schemes)
- If the optional `[FOR (encryption_type,...)]` is omitted, the column will be encrypted with `STORE` by default.

#### Examples

```
PRISMADB ENCRYPT Product.Price;
PRISMADB ENCRYPT Product.Price FOR (SEARCH, ADDITION);
```

## DECRYPT

The specified column will be decrypted and any supporting columns will be removed.

```
PRISMADB DECRYPT column [STATUS]
```

- This command executes asynchronously in the background for proxy containers.
- If the optional `[STATUS]` is appended to the command, Prisma/DB will return a result table with the current progress of the command.
- For more information on `column`, refer to [Language Structure - Schema Object Names (MySQL)](../language-structure#mysql_1) or [Language Structure - Schema Object Names (SQL Server)](../language-structure#sql-server_1)

#### Examples

```
PRISMADB DECRYPT Product.Price;
```

## OPETREE SAVE

The Order Preserving Encoding (OPE) tree will be saved in the database for restoration on proxy restarts.

```
PRISMADB OPETREE SAVE
```

- The OPE tree is saved in a new table named `PrismaDB_OpeTree`.
- Execution of the `OPETREE REBUILD` and `OPETREE INSERT` commands will perform this action as well.

#### Examples

```
PRISMADB OPETREE SAVE;
```

## OPETREE INSERT

Provided values will be inserted into the Order Preserving Encoding (OPE) tree in a most balanced way, and saved in the database.

```
PRISMADB OPETREE INSERT VALUES (numeric_literal,...)]
```

- For more information on `numeric_literal`, refer to [Language Structure - Literal Values](../language-structure#literal-values)

#### Examples

```
PRISMADB OPETREE INSERT VALUES (20, 50, 100);
```

## OPETREE REBALANCE

The Order Preserving Encoding (OPE) tree will be re-balanced incrementally. Re-balancing incrementally is used if the OPE tree has exceeded the maximum height after `OPETREE INSERT`, or as a regular maintenance procedure to prevent exceeding the maximum height during normal operation. Re-balancing can be stopped anytime, with support for stopping after *n* number of minutes, hours, or iterations.

```
PRISMADB OPETREE REBALANCE [STATUS | stop_parameter]

stop_parameter:
    STOP [AFTER numeric_literal ITERATIONS | HOURS | MINUTES]
```

- This command executes asynchronously in the background for proxy containers.
- If the optional `STOP [AFTER numeric_literal ITERATIONS]` is appended to the command, Prisma/DB will start re-balancing the OPE tree, and automatically stop after the defined number of iterations.
- If the optional `STOP [AFTER numeric_literal HOURS]` is appended to the command, Prisma/DB will start re-balancing the OPE tree, and automatically stop after the defined number of hours.
- If the optional `STOP [AFTER numeric_literal MINUTES]` is appended to the command, Prisma/DB will start re-balancing the OPE tree, and automatically stop after the defined number of minutes.
- If the optional `STOP` is appended to the command, Prisma/DB will stop an active re-balancing after the current iteration.
- If the optional `[STATUS]` is appended to the command, Prisma/DB will return a result table with the current progress of the command.

#### Examples

```
PRISMADB OPETREE REBALANCE;
```
```
PRISMADB OPETREE REBALANCE STOP AFTER 3 ITERATIONS;
```
```
PRISMADB OPETREE REBALANCE STOP AFTER 1 HOURS;
```
```
PRISMADB OPETREE REBALANCE STOP AFTER 120 MINUTES;
```
```
PRISMADB OPETREE REBALANCE STOP;
```
```
PRISMADB OPETREE REBALANCE STATUS;
```

## OPETREE REBUILD

The Order Preserving Encoding (OPE) tree will be rebuild entirely from all the `RANGE` encoding enabled data stored in the database. This is used if the OPE tree stored in the database is out-of-sync with the data.

```
PRISMADB OPETREE REBUILD [STATUS]
```

- This command executes asynchronously in the background for proxy containers.
- If the optional `[STATUS]` is appended to the command, Prisma/DB will return a result table with the current progress of the command.

#### Examples

```
PRISMADB OPETREE REBUILD;
```

## OPETREE LOAD

The Order Preserving Encoding (OPE) tree will be loaded from the database.

```
PRISMADB OPETREE LOAD
```

- The OPE tree is loaded from the table named `PrismaDB_OpeTree`.
- The OPE tree is also automatically loaded from the table named `PrismaDB_OpeTree` on the first query of every startup of the Prisma/DB proxy.

#### Examples

```
PRISMADB OPETREE LOAD;
```

## SCHEMA LOAD

The database schema will be loaded from the database.

```
PRISMADB SCHEMA LOAD
```

- The database schema is loaded from the table named `PrismaDB_Schema`.
- The database schema is automatically saved to the table named `PrismaDB_Schema` when a change is made to the schema.
- The database schema is also automatically loaded from the table named `PrismaDB_Schema` on the first query of every startup of the Prisma/DB proxy.

#### Examples

```
PRISMADB SCHEMA LOAD;
```

## BYPASS

The query following this command will bypass the transformative core encryption module and be executed directly at the database.

```
PRISMADB BYPASS query
```

- `query` is any data definition or data manipulation statements.

#### Examples

```
PRISMADB BYPASS SELECT * FROM Products;
```

## LICENSE REFRESH

The license key will be read from the license key file and the license status will be updated.

```
PRISMADB LICENSE REFRESH
```

- Replace the existing license key file with an updated license before running this command.

#### Examples

```
PRISMADB LICENSE REFRESH;
```

## LICENSE SET KEY

The license will be updated with the specified key.

```
PRISMADB LICENSE SET KEY license_key;
```

- `license_key` is a string literal value. For more information, refer to [Language Structure - Literal Values](../language-structure#literal-values)

#### Examples

```
PRISMADB LICENSE SET KEY 'cXdlcnR5dWlvcGxramhnZmRzYXp4Y3Zibm0=';
```

## LICENSE STATUS

The license status will be displayed as a table.

```
LICENSE STATUS
```

#### Examples

```
LICENSE STATUS;
```

## REGISTER USER (MySQL Only)

The specified user credentials will be stored in the proxy for authentication with both the client and server. This is required as credentials from MySQL clients are hashed.

```
PRISMADB REGISTER USER userid PASSWORD password
```

- `userid` and `password` are string literal values. For more information, refer to [Language Structure - Literal Values](../language-structure#literal-values)

#### Examples

```
PRISMADB REGISTER USER 'root' PASSWORD 'qwerty123';
```
