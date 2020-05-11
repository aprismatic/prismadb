## Literal Values

### MySQL

| Literal Data Type | Representation                                        |
| ----------------- | ----------------------------------------------------- |
| String            | `'a string'` or<br />`"a string"`                     |
| Numeric           | `123`, `1.23`                                         |
| Date & Time       | `'YYYY-MM-DD HH:MM:SS'` or<br />`'YY-MM-DD HH:MM:SS'` |
| Hex Bytes         | `'0x00000000'`                                        |

### SQL Server

| Literal Data Type | Representation                                        |
| ----------------- | ----------------------------------------------------- |
| String            | `'a string'`                                          |
| Numeric           | `123`, `1.23`                                         |
| Date & Time       | `'YYYY-MM-DD HH:MM:SS'` or<br />`'YY-MM-DD HH:MM:SS'` |
| Hex Bytes         | `'0x00000000'`                                        |

### PostgreSQL

| Literal Data Type | Representation                                        |
| ----------------- | ----------------------------------------------------- |
| String            | `'a string'`                                          |
| Numeric           | `123`, `1.23`                                         |
| Date & Time       | `'YYYY-MM-DD HH:MM:SS'` or<br />`'YY-MM-DD HH:MM:SS'` |
| Hex Bytes         | `E'\\x00000000'`                                      |

## Schema Object Names

### MySQL

| Schema Object | Representation                                                                                                              |
| ------------- | --------------------------------------------------------------------------------------------------------------------------- |
| Table         | `table_name` or<br />`` `table_name` ``                                                                                     |
| Column        | `column_name` or<br />`` `column_name` `` or<br />`table_name.column_name` or<br />`` `table_name`.`column_name` ``         |
| Function      | <code>function_name(\* &#124; expression,...)</code> or<br /><code>&#96;function_name&#96;(\* &#124; expression,...)</code> |

- For functions, only `SUM()`, `COUNT()` and `AVG()` are supported over encrypted columns. The `ADDITION` encryption scheme is required for the usage of `SUM()` and `AVG()`.

### SQL Server

| Schema Object | Representation                                                                                                              |
| ------------- | --------------------------------------------------------------------------------------------------------------------------- |
| Table         | `table_name` or<br />`[table_name]`                                                                                         |
| Column        | `column_name` or<br />`[column_name]` or<br />`table_name.column_name` or<br />`[table_name].[column_name]`                 |
| Function      | <code>function_name(\* &#124; expression,...)</code> or<br /><code>&#91;function_name&#93;(\* &#124; expression,...)</code> |

- For functions, only `SUM()`, `COUNT()` and `AVG()` are supported over encrypted columns. The `ADDITION` encryption scheme is required for the usage of `SUM()` and `AVG()`.

### PostgreSQL

| Schema Object | Representation                                                                                                      |
| ------------- | ------------------------------------------------------------------------------------------------------------------- |
| Table         | `table_name` or<br />`"table_name"`                                                                                 |
| Column        | `column_name` or<br />`"column_name"` or<br />`table_name.column_name` or<br />`"table_name"."column_name"`         |
| Function      | <code>function_name(\* &#124; expression,...)</code> or<br /><code>"function_name"(\* &#124; expression,...)</code> |

- For functions, only `SUM()`, `COUNT()` and `AVG()` are supported over encrypted columns. The `ADDITION` encryption scheme is required for the usage of `SUM()` and `AVG()`.

## Expression Syntax

```
expression:
    column
  | literal_value
  | function
  | expression + expression
  | expression - expression
  | expression * expression
  | expression / expression
  | expression = expression
  | expression != expression
  | expression > expression
  | expression < expression
  | expression >= expression
  | expression <= expression
  | column [NOT] IN (literal_value,...)
  | column IS [NOT] NULL
  | column [NOT] LIKE string_value [ESCAPE char_literal]
  | expression AND expression
  | expression OR expression
  | (expression)
```
