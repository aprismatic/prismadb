# Data Manipulation Statements

## SELECT

### MySQL

```
SELECT
    * | select_expression,...
    FROM source,...
    [WHERE where_condition]
    [GROUP BY column,...]
    [ORDER BY order_column,...]
    [LIMIT count]

select_expression:
    expression [[AS] alias]
  | table.*

source:
    table_reference [join_clause,...]

join_clause:
    [INNER | LEFT [OUTER] | RIGHT [OUTER] | CROSS] JOIN
    table_reference [ON column = column]

where_condition:
    expression

order_column:
    column [ASC | DESC]

table_reference:
    table [[AS] alias]
  | ( select_statement ) [AS] alias
```

- For more information on `expression`, refer to [Language Structure - Expression Syntax](language-structure#expression-syntax)
- For more information on `table`, refer to [Language Structure - Schema Object Names (MySQL)](language-structure#mysql_1)
- For more information on `column`, refer to [Language Structure - Schema Object Names (MySQL)](language-structure#mysql_1)
- `alias` follows the same syntax as `table` or `column`.
- `count` is an integer literal value. For more information, refer to [Language Structure - Literal Values](language-structure#literal-values)
- `select_statement` is a nested `SELECT` statement that follows the rules of this definition.

#### Examples

```
SELECT t1.col1, t1.col2, t1.col3 * t1.col4 AS MUL, t2.col2, t2.col3
    FROM  table1 t1
    JOIN  table2 t2 ON t1.col1 = t2.col1
    WHERE ( t1.col3 = 1 ) OR ( t2.col4 < 100 )
    ORDER BY MUL, t1.col1 DESC;
```

```
SELECT `col1`, SUM(col2)
    FROM  `table1`
    GROUP BY `col1`;
```

```
SELECT *
    FROM  table1, table2;
```

---

### SQL Server

```
SELECT
    [TOP count | TOP (count)]
    * | select_expression,...
    FROM source,...
    [WHERE where_condition]
    [GROUP BY column,...]
    [ORDER BY order_column,...]

select_expression:
    expression [[AS] alias]
  | table.*

source:
    table_reference [join_clause,...]

join_clause:
    [INNER | LEFT [OUTER] | RIGHT [OUTER] | FULL [OUTER] | CROSS] JOIN
    table_reference [ON column = column]

where_condition:
    expression

order_column:
    column [ASC | DESC]

table_reference:
    table [[AS] alias]
  | ( select_statement ) [AS] alias
```

- For more information on `expression`, refer to [Language Structure - Expression Syntax](language-structure#expression-syntax)
- For more information on `table`, refer to [Language Structure - Schema Object Names (SQL Server)](language-structure#sql-server_1)
- For more information on `column`, refer to [Language Structure - Schema Object Names (SQL Server)](language-structure#sql-server_1)
- `alias` follows the same syntax as `table` or `column`.
- `count` is an integer literal value. For more information, refer to [Language Structure - Literal Values](language-structure#literal-values)
- `select_statement` is a nested `SELECT` statement that follows the rules of this definition.

#### Examples

```
SELECT t1.Col1, t1.Col2, t1.Col3 * t1.Col4 AS MUL, t2.Col2, t2.Col3
    FROM  Table1 t1
    JOIN  Table2 t2 ON t1.Col1 = t2.Col1
    WHERE ( t1.Col3 = 1 ) OR ( t2.Col4 < 100 )
    ORDER BY MUL, t1.Col1 DESC;
```

```
SELECT [Col1], SUM(Col2)
    FROM  [Table1]
    GROUP BY [Col1];
```

```
SELECT *
    FROM  Table1, Table2;
```

---

### PostgreSQL

```
SELECT
    * | select_expression,...
    FROM source,...
    [WHERE where_condition]
    [GROUP BY column,...]
    [ORDER BY order_column,...]
    [LIMIT count]

select_expression:
    expression [[AS] alias]
  | table.*

source:
    table_reference [join_clause,...]

join_clause:
    [INNER | LEFT [OUTER] | RIGHT [OUTER] | FULL [OUTER] | CROSS] JOIN
    table_reference [ON column = column]

where_condition:
    expression

order_column:
    column [ASC | DESC]

table_reference:
    table [[AS] alias]
  | ( select_statement ) [AS] alias
```

- For more information on `expression`, refer to [Language Structure - Expression Syntax](language-structure#expression-syntax)
- For more information on `table`, refer to [Language Structure - Schema Object Names (PostgreSQL)](language-structure#postgresql_1)
- For more information on `column`, refer to [Language Structure - Schema Object Names (PostgreSQL)](language-structure#postgresql_1)
- `alias` follows the same syntax as `table` or `column`.
- `count` is an integer literal value. For more information, refer to [Language Structure - Literal Values](language-structure#literal-values)
- `select_statement` is a nested `SELECT` statement that follows the rules of this definition.

#### Examples

```
SELECT t1.col1, t1.col2, t1.col3 * t1.col4 AS MUL, t2.col2, t2.col3
    FROM  table1 t1
    JOIN  table2 t2 ON t1.col1 = t2.col1
    WHERE ( t1.col3 = 1 ) OR ( t2.col4 < 100 )
    ORDER BY MUL, t1.col1 DESC;
```

```
SELECT "col1", SUM(col2)
    FROM  "table1"
    GROUP BY "col1";
```

```
SELECT *
    FROM  table1, table2;
```

## INSERT

### MySQL

```
INSERT [INTO] table
    (column,...)
    VALUES
    value-list,...

value-list:
    (expression,...)
```

- For more information on `table`, refer to [Language Structure - Schema Object Names (MySQL)](language-structure#mysql_1)
- For more information on `column`, refer to [Language Structure - Schema Object Names (MySQL)](language-structure#mysql_1)
- For more information on `expression`, refer to [Language Structure - Expression Syntax](language-structure#expression-syntax)

#### Examples

```
INSERT INTO table1 (col1, col2, col3, col4)
    VALUES ( 1,  2.7, 'Hello',  '2017-01-01 01:02:03'),
           (12,  0.0, 'Test',   '2015-02-10 01:02:03'),
           ( 0, -123, 'qwerty', '2017-01-01 01:02:03');
```

---

### SQL Server

```
INSERT [INTO] table
    (column,...)
    VALUES
    value-list,...

value-list:
    (expression,...)
```

- For more information on `table`, refer to [Language Structure - Schema Object Names (SQL Server)](language-structure#sql-server_1)
- For more information on `column`, refer to [Language Structure - Schema Object Names (SQL Server)](language-structure#sql-server_1)
- For more information on `expression`, refer to [Language Structure - Expression Syntax](language-structure#expression-syntax)

#### Examples

```
INSERT INTO Table1 (Col1, Col2, Col3, Col4)
    VALUES ( 1,  2.7, 'Hello',  '2017-01-01 01:02:03'),
           (12,  0.0, 'Test',   '2015-02-10 01:02:03'),
           ( 0, -123, 'qwerty', '2017-01-01 01:02:03');
```

---

### PostgreSQL

```
INSERT [INTO] table
    (column,...)
    VALUES
    value-list,...

value-list:
    (expression,...)
```

- For more information on `table`, refer to [Language Structure - Schema Object Names (PostgreSQL)](language-structure#postgresql_1)
- For more information on `column`, refer to [Language Structure - Schema Object Names (PostgreSQL)](language-structure#postgresql_1)
- For more information on `expression`, refer to [Language Structure - Expression Syntax](language-structure#expression-syntax)

#### Examples

```
INSERT INTO table1 (col1, col2, col3, col4)
    VALUES ( 1,  2.7, 'Hello',  '2017-01-01 01:02:03'),
           (12,  0.0, 'Test',   '2015-02-10 01:02:03'),
           ( 0, -123, 'qwerty', '2017-01-01 01:02:03');
```

## UPDATE

### MySQL

```
UPDATE table SET
    assignment,...
    [WHERE where_condition]

assignment:
    column = expression

where_condition:
    expression
```

- For more information on `table`, refer to [Language Structure - Schema Object Names (MySQL)](language-structure#mysql_1)
- For more information on `column`, refer to [Language Structure - Schema Object Names (MySQL)](language-structure#mysql_1)
- For more information on `expression`, refer to [Language Structure - Expression Syntax](language-structure#expression-syntax)

#### Examples

```
UPDATE table1
    SET col1 = 12, col2 = 'abc'
    WHERE ( col3 = 0 ) AND ( col4 = 'test' );
```

```
UPDATE `table1`
    SET `col1` = 0;
```

---

### SQL Server

```
UPDATE table SET
    assignment,...
    [WHERE where_condition]

assignment:
    column = expression

where_condition:
    expression
```

- For more information on `table`, refer to [Language Structure - Schema Object Names (SQL Server)](language-structure#sql-server_1)
- For more information on `column`, refer to [Language Structure - Schema Object Names (SQL Server)](language-structure#sql-server_1)
- For more information on `expression`, refer to [Language Structure - Expression Syntax](language-structure#expression-syntax)

#### Examples

```
UPDATE Table1
    SET Col1 = 12, Col2 = 'abc'
    WHERE ( Col3 = 0 ) AND ( Col4 = 'test' );
```

```
UPDATE [Table1]
    SET [Col1] = 0;
```

---

### PostgreSQL

```
UPDATE table SET
    assignment,...
    [WHERE where_condition]

assignment:
    column = expression

where_condition:
    expression
```

- For more information on `table`, refer to [Language Structure - Schema Object Names (PostgreSQL)](language-structure#postgresql_1)
- For more information on `column`, refer to [Language Structure - Schema Object Names (PostgreSQL)](language-structure#postgresql_1)
- For more information on `expression`, refer to [Language Structure - Expression Syntax](language-structure#expression-syntax)

#### Examples

```
UPDATE table1
    SET col1 = 12, col2 = 'abc'
    WHERE ( col3 = 0 ) AND ( col4 = 'test' );
```

```
UPDATE "table1"
    SET "col1" = 0;
```

## DELETE

### MySQL

```
DELETE FROM table
    [WHERE where_condition]

where_condition:
    expression
```

- For more information on `table`, refer to [Language Structure - Schema Object Names (MySQL)](language-structure#mysql_1)
- For more information on `expression`, refer to [Language Structure - Expression Syntax](language-structure#expression-syntax)

#### Examples

```
DELETE FROM table1
    WHERE col3 IN ( 1, 5 );
```

```
DELETE FROM `table1`;
```

---

### SQL Server

```
DELETE FROM table
    [WHERE where_condition]

where_condition:
    expression
```

- For more information on `table`, refer to [Language Structure - Schema Object Names (SQL Server)](language-structure#sql-server_1)
- For more information on `expression`, refer to [Language Structure - Expression Syntax](language-structure#expression-syntax)

#### Examples

```
DELETE FROM Table1
    WHERE Col3 IN ( 1, 5 );
```

```
DELETE FROM [Table1];
```

---

### PostgreSQL

```
DELETE FROM table
    [WHERE where_condition]

where_condition:
    expression
```

- For more information on `table`, refer to [Language Structure - Schema Object Names (PostgreSQL)](language-structure#postgresql_1)
- For more information on `expression`, refer to [Language Structure - Expression Syntax](language-structure#expression-syntax)

#### Examples

```
DELETE FROM table1
    WHERE col3 IN ( 1, 5 );
```

```
DELETE FROM "table1";
```
