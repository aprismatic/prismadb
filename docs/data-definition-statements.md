# Data Definition Statements

## CREATE TABLE

### MySQL

```
CREATE TABLE table
    (create_definition,...)

create_definition:
    column column_definition

column_definition:
    data_type [encryption_option] [NOT NULL | NULL]
    [default_increment_option] [PRIMARY KEY]

encryption_option:
    ENCRYPTED [FOR (encryption_type,...)]

default_increment_option:
    DEFAULT default_value | AUTO_INCREMENT
```

- For more information on `table`, refer to [Language Structure - Schema Object Names (MySQL)](../language-structure#mysql_1)
- For more information on `column`, refer to [Language Structure - Schema Object Names (MySQL)](../language-structure#mysql_1)
- For more information on `data_type`, refer to [Data Types (MySQL)](../data-types#mysql)
- `default_value` can be `CURRENT_TIMESTAMP`, or literal values defined at [Language Structure - Literal Values (MySQL)](../language-structure#mysql)
- Encryption of columns with `default_value` is currently not supported.
- For more information on `encryption_type`, refer to [Encryption Schemes](../encryption-schemes)
- If the optional `[FOR (encryption_type,...)]` in `enc_option` is omitted, the column will be encrypted with `STORE` by default.
- Encryption of columns with primary key constraints are not supported.
- Encryption of auto incrementing columns are not supported.
- If an auto incrementing column is not defined, Prisma/DB will create an additional `PrismaDB_RowId` column which is not visible to the user for indexing purposes.

#### Examples

```
CREATE TABLE table1
(
    col1 INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    col2 INT ENCRYPTED FOR(MULTIPLICATION, ADDITION, SEARCH) NOT NULL,
    col3 INT NOT NULL,
    col4 VARCHAR(100) ENCRYPTED FOR(STORE, SEARCH),
    col5 VARCHAR(100) ENCRYPTED,
    col6 DATETIME ENCRYPTED DEFAULT CURRENT_TIMESTAMP,
    col7 ENUM('abc', 'def', 'ghi') ENCRYPTED FOR(STORE, SEARCH)
);
```

```
CREATE TABLE `table1`
(
    `col1` INT ENCRYPTED FOR(MULTIPLICATION, ADDITION, SEARCH),
    `col2` TEXT ENCRYPTED FOR(STORE),
    `col3` DOUBLE DEFAULT 0.0
);
```

---

### SQL Server

```
CREATE TABLE table
    (create_definition,...)

create_definition:
    column column_definition

column_definition:
    data_type [encryption_option] [NOT NULL | NULL]
    [default_increment_option] [PRIMARY KEY]

encryption_option:
    ENCRYPTED [FOR (encryption_type,...)]

default_increment_option:
    DEFAULT default_value | IDENTITY(1,1)
```

- For more information on `table`, refer to [Language Structure - Schema Object Names (SQL Server)](../language-structure#sql-server_1)
- For more information on `column`, refer to [Language Structure - Schema Object Names (SQL Server)](../language-structure#sql-server_1)
- For more information on `data_type`, refer to [Data Types (SQL Server)](../data-types#sql-server)
- For more information on `default_value`, refer to [Language Structure - Literal Values (SQL Server)](../language-structure#sql-server)
- Encryption of columns with `default_value` is currently not supported.
- For more information on `encryption_type`, refer to [Encryption Schemes](../encryption-schemes)
- If the optional `[FOR (encryption_type,...)]` in `enc_option` is omitted, the column will be encrypted with `STORE` by default.
- Currently, only `IDENTITY(1,1)` (seed of 1, increment by 1) incrementing property is supported. Future releases will support customizable seed and increment values.
- Encryption of columns with primary key constraints are not supported.
- Encryption of auto incrementing columns are not supported.
- If an auto incrementing column is not defined, Prisma/DB will create an additional `PrismaDB_RowId` column which is not visible to the user for indexing purposes.

#### Examples

```
CREATE TABLE Table1
(
    Col1 INT NOT NULL IDENTITY(1,1),
    Col2 INT ENCRYPTED FOR(MULTIPLICATION, ADDITION, SEARCH) NOT NULL,
    Col3 INT NOT NULL,
    Col4 VARCHAR(100) ENCRYPTED FOR(STORE, SEARCH),
    Col5 DATETIME ENCRYPTED
);
```

```
CREATE TABLE [Table1]
(
    [Col1] INT ENCRYPTED FOR(MULTIPLICATION, ADDITION, SEARCH),
    [Col2] TEXT ENCRYPTED FOR(STORE),
    [Col3] FLOAT DEFAULT 0.0
);
```

---

### PostgreSQL

```
CREATE TABLE table
    (create_definition,...)

create_definition:
    column column_definition

column_definition:
    data_type [encryption_option] [NOT NULL | NULL]
    [default_option] [PRIMARY KEY]

encryption_option:
    ENCRYPTED [FOR (encryption_type,...)]

default_increment_option:
    DEFAULT default_value
```

- For more information on `table`, refer to [Language Structure - Schema Object Names (PostgreSQL)](../language-structure#postgresql_1)
- For more information on `column`, refer to [Language Structure - Schema Object Names (PostgreSQL)](../language-structure#postgresql_1)
- For more information on `data_type`, refer to [Data Types (PostgreSQL)](../data-types#postgresql)
- `default_value` can be `CURRENT_TIMESTAMP`, or literal values defined at [Language Structure - Literal Values (PostgreSQL)](../language-structure#postgresql)
- Encryption of columns with `default_value` is currently not supported.
- For more information on `encryption_type`, refer to [Encryption Schemes](../encryption-schemes)
- If the optional `[FOR (encryption_type,...)]` in `enc_option` is omitted, the column will be encrypted with `STORE` by default.
- Encryption of columns with primary key constraints are not supported.
- Encryption of auto incrementing (`SERIAL`) columns are not supported.
- If an auto incrementing column is not defined, Prisma/DB will create an additional `PrismaDB_RowId` column which is not visible to the user for indexing purposes.

#### Examples

```
CREATE TABLE table1
(
    col1 SERIAL,
    col2 INT ENCRYPTED FOR(MULTIPLICATION, ADDITION, SEARCH) NOT NULL,
    col3 INT NOT NULL,
    col4 VARCHAR(100) ENCRYPTED FOR(STORE, SEARCH),
    col5 VARCHAR(100) ENCRYPTED
);
```

```
CREATE TABLE "table1"
(
    "col1" INT ENCRYPTED FOR(MULTIPLICATION, ADDITION, SEARCH),
    "col2" TEXT ENCRYPTED FOR(STORE),
    "col3" DOUBLE DEFAULT 0.0
);
```

## CREATE INDEX

### MySQL

```
CREATE INDEX index_name ON table (column,...)
```

- `index_name` follows the rules of table names.
- Creating an index on an encrypted column will create indexes on both actual `SEARCH` and `RANGE` columns, if available.
- For more information on `table`, refer to [Language Structure - Schema Object Names (MySQL)](../language-structure#mysql_1)
- For more information on `column`, refer to [Language Structure - Schema Object Names (MySQL)](../language-structure#mysql_1)

#### Examples

```
CREATE INDEX idx1 ON table1 (col1, col2);
```

```
CREATE INDEX `idx1` ON `table1` (`col1`, `col2`);
```

---

### SQL Server

```
CREATE INDEX index_name ON table (column,...)
```

- `index_name` follows the rules of table names.
- Creating an index on an encrypted column will create indexes on both actual `SEARCH` and `RANGE` columns, if available.
- For more information on `table`, refer to [Language Structure - Schema Object Names (SQL Server)](../language-structure#sql-server_1)
- For more information on `column`, refer to [Language Structure - Schema Object Names (SQL Server)](../language-structure#sql-server_1)

#### Examples

```
CREATE INDEX Idx1 ON Table1 (Col1, Col2);
```

```
CREATE INDEX [Idx1] ON [Table1] ([Col1], [Col2]);
```

---

### PostgreSQL

```
CREATE INDEX index_name ON table (column,...)
```

- `index_name` follows the rules of table names.
- Creating an index on an encrypted column will create indexes on both actual `SEARCH` and `RANGE` columns, if available.
- For more information on `table`, refer to [Language Structure - Schema Object Names (PostgreSQL)](../language-structure#postgresql_1)
- For more information on `column`, refer to [Language Structure - Schema Object Names (PostgreSQL)](../language-structure#postgresql_1)

#### Examples

```
CREATE INDEX idx1 ON table1 (col1, col2);
```

```
CREATE INDEX "idx1" ON "table1" ("col1", "col2");
```

## ALTER TABLE

ALTER TABLE queries are only supported for non-encrypted columns and nullability for encrypted columns, for security and access control reasons. To modify the encryption scheme of a column, use the [Native Commands - ENCRYPT](../native-commands#encrypt) or [Native Commands - DECRYPT](../native-commands#decrypt) commands.

### MySQL

```
ALTER TABLE table
    alter_specification

alter_specification:
    MODIFY COLUMN column column_definition
```

- For more information on `table`, refer to [Language Structure - Schema Object Names (MySQL)](../language-structure#mysql_1)
- For more information on `column`, refer to [Language Structure - Schema Object Names (MySQL)](../language-structure#mysql_1)
- For more information on `column_definition`, refer to [Data Definition Statements - CREATE TABLE (MySQL)](../data-definition-statements/#mysql)

#### Examples

```
ALTER TABLE table1 MODIFY COLUMN
    col1 INT ENCRYPTED FOR(MULTIPLICATION, ADDITION, SEARCH) NOT NULL;
```

```
ALTER TABLE `table1` MODIFY COLUMN
    `col1` INT NULL;
```

---

### SQL Server

```
ALTER TABLE table
    alter_specification

alter_specification:
    ALTER COLUMN column column_definition
```

- For more information on `table`, refer to [Language Structure - Schema Object Names (SQL Server)](../language-structure#sql-server_1)
- For more information on `column`, refer to [Language Structure - Schema Object Names (SQL Server)](../language-structure#sql-server_1)
- For more information on `column_definition`, refer to [Data Definition Statements - CREATE TABLE (SQL Server)](../data-definition-statements/#sql-server)

#### Examples

```
ALTER TABLE Table1 ALTER COLUMN
    Col1 INT ENCRYPTED FOR(MULTIPLICATION, ADDITION, SEARCH) NOT NULL;
```

```
ALTER TABLE [Table1] ALTER COLUMN
    [Col1] INT NULL;
```

---

### PostgreSQL

```
ALTER TABLE table
    alter_specification

alter_specification:
    ALTER COLUMN column column_definition
```

- For more information on `table`, refer to [Language Structure - Schema Object Names (PostgreSQL)](../language-structure#postgresql_1)
- For more information on `column`, refer to [Language Structure - Schema Object Names (PostgreSQL)](../language-structure#postgresql_1)
- For more information on `column_definition`, refer to [Data Definition Statements - CREATE TABLE (PostgreSQL)](../data-definition-statements/#postgresql)

#### Examples

```
ALTER TABLE table1 ALTER COLUMN
    col1 INT ENCRYPTED FOR(MULTIPLICATION, ADDITION, SEARCH) NOT NULL;
```

```
ALTER TABLE "table1" ALTER COLUMN
    "col1" INT NULL;
```

## DROP TABLE

```
DROP TABLE table
```

- For more information on `table`, refer to [Language Structure - Schema Object Names](../language-structure#schema-object-names)

#### Examples

```
DROP TABLE table1;
```

## SHOW TABLES

Returns all the tables in the database.

```
SHOW TABLES
```

#### Examples

```
SHOW TABLES;
```

## SHOW COLUMNS

Returns all the columns in a specified table, including the data type, null, key, default value, extra info and encryption applied.

```
SHOW COLUMNS FROM table
```

- For more information on `table`, refer to [Language Structure - Schema Object Names](../language-structure#schema-object-names)

#### Examples

```
SHOW COLUMNS FROM [table1];
```
