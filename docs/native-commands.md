# Native Commands

Native commands control the operation of the Prisma/DB proxy, and is only executable by the administrative user defined in the environment variables / command line option / settings file.

## EXPORT KEYS

The database encryption keys will be saved to the specified `file_uri`.

```
PRISMADB EXPORT KEYS [TO file_uri]
```

- `file_uri` is a string literal value. For more information, refer to [Language Structure - Literal Values](language-structure#literal-values)
- If the optional `[TO file_uri]` is omitted, it will be saved in the default directory and filename.

#### Examples

```
PRISMADB EXPORT KEYS;
PRISMADB EXPORT KEYS TO '/data/keys.json';
```

## UPDATE KEYS

The database encryption keys will be regenerated and all columns in the database will be re-encrypted using the new keys.

```
PRISMADB UPDATE KEYS [STATUS]
```

- This command executes asynchronously in the background for proxy containers.
- If the optional `[STATUS]` is appended to the command, Prisma/DB will return a result table with the current progress of the command.

#### Examples

```
PRISMADB UPDATE KEYS;
```

## ENCRYPT

The specified column will be encrypted with the new encryption schemes, and any required supporting columns will be added.

```
PRISMADB ENCRYPT column [FOR (encryption_type,...)] [STATUS]
```

- This command executes asynchronously in the background for proxy containers.
- If the optional `[STATUS]` is appended to the command, Prisma/DB will return a result table with the current progress of the command.
- For more information on `column`, refer to [Language Structure - Schema Object Names (MySQL)](language-structure#mysql_1) or [Language Structure - Schema Object Names (SQL Server)](language-structure#sql-server_1)
- For more information on `encryption_type`, refer to [Encryption Schemes](encryption-schemes)
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
- For more information on `column`, refer to [Language Structure - Schema Object Names (MySQL)](language-structure#mysql_1) or [Language Structure - Schema Object Names (SQL Server)](language-structure#sql-server_1)

#### Examples

```
PRISMADB DECRYPT Product.Price;
```

## SAVE OPETREE

The Order Preserving Encoding (OPE) tree will be saved in the database for restoration on proxy restarts.

```
PRISMADB SAVE OPETREE
```

- The OPE tree is saved in a new table named `PrismaDB_OpeTree`.
- Execution of the `REBALANCE OPETREE` command will perform this action as well.

#### Examples

```
PRISMADB SAVE OPETREE;
```

## REBALANCE OPETREE

The Order Preserving Encoding (OPE) tree will be re-balanced for performance, and saved in the database.

```
PRISMADB REBALANCE OPETREE [WITH VALUES (numeric_literal,...)] [STATUS]
```

- This command executes asynchronously in the background for proxy containers.
- If the optional `[STATUS]` is appended to the command, Prisma/DB will return a result table with the current progress of the command.
- If the optional `[WITH VALUES (numeric_literal,...)]` is defined, Prisma/DB will add those values to the OPE tree before rebalancing.
- For more information on `numeric_literal`, refer to [Language Structure - Literal Values (MySQL)](language-structure#mysql) or [Language Structure - Literal Values (SQL Server)](language-structure#sql-server)

#### Examples

```
PRISMADB REBALANCE OPETREE WITH VALUES (20, 50, 100);
```

## LOAD OPETREE

The Order Preserving Encoding (OPE) tree will be loaded from the database.

```
PRISMADB LOAD OPETREE
```

- The OPE tree is loaded from the table named `PrismaDB_OpeTree`.
- The OPE tree is also automatically loaded from the table named `PrismaDB_OpeTree` on the first query of every startup of the Prisma/DB proxy.

#### Examples

```
PRISMADB LOAD OPETREE;
```

## LOAD SCHEMA

The database schema will be loaded from the database.

```
PRISMADB LOAD SCHEMA
```

- The database schema is loaded from the table named `PrismaDB_Schema`.
- The database schema is automatically saved to the table named `PrismaDB_Schema` when a change is made to the schema.
- The database schema is also automatically loaded from the table named `PrismaDB_Schema` on the first query of every startup of the Prisma/DB proxy.

#### Examples

```
PRISMADB LOAD SCHEMA;
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

## REFRESH LICENSE

The license key will be read from the license key file and the license status will be updated.

```
PRISMADB REFRESH LICENSE
```

- Replace the existing license key file with an updated license before running this command.

#### Examples

```
PRISMADB REFRESH LICENSE;
```

## SET LICENSE KEY

The license will be updated with the specified key.

```
PRISMADB SET LICENSE KEY license_key;
```

- `license_key` is a string literal value. For more information, refer to [Language Structure - Literal Values](language-structure#literal-values)

#### Examples

```
PRISMADB SET LICENSE KEY 'cXdlcnR5dWlvcGxramhnZmRzYXp4Y3Zibm0=';
```

## CHECK LICENSE STATUS

The license status will be displayed as a table.

```
CHECK LICENSE STATUS
```

#### Examples

```
CHECK LICENSE STATUS;
```

## REGISTER USER (MySQL Only)

The specified user credentials will be stored in the proxy for authentication with both the client and server. This is required as credentials from MySQL clients are hashed.

```
PRISMADB REGISTER USER userid PASSWORD password
```

- `userid` and `password` are string literal values. For more information, refer to [Language Structure - Literal Values](language-structure#literal-values)

#### Examples

```
PRISMADB REGISTER USER 'root' PASSWORD 'qwerty123';
```
