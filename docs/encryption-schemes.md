# Encryption Schemes

| Encryption Scheme | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `STORE`           | Encrypt with Advanced Encryption Standard (AES).<br />Unsearchable.<br />Available for all datatypes.<br />Stored as `column_name.Store.Enc` in the table.                                                                                                                                                                                                                                                                                                                      |
| `SEARCH`          | Encode with fingerprint.<br />Searchable, for exact match.<br />Available for all datatypes.<br />Stored as `column_name.Fingerprint` in the table.                                                                                                                                                                                                                                                                                                                             |
| `ADDITION`        | Encrypt with Paillier.<br />Unsearchable.<br />Able to perform addition and subtraction arithmetics.<br />Available only for numeric datatypes.<br />Stored as `column_name.Paillier.Enc` in the table.                                                                                                                                                                                                                                                                         |
| `MULTIPLICATION`  | Encrypt with ElGamal.<br />Unsearchable.<br />Able to perform multiplication and division arithmetics.<br />Available only for numeric datatypes.<br />Stored as `column_name.ElGamal.Enc` in the table.                                                                                                                                                                                                                                                                        |
| `RANGE`           | Encode with Order Preserving Encoding (OPE) (Versions 0.3.3 and above).<br />Searchable, for equals, less than / greater than (equals) matches.<br />Available for numeric datatypes.<br />Stored as `column_name.Range` in the table.<br />NOTE: OPE is implemented as a binary tree, with a maximum height of 63 nodes. When the height reaches 63 nodes, an [OPETREE REBUILD](../native-commands#opetree-rebuild) command is required to be executed to re-balance the tree. |
| `WILDCARD`        | Encode with wildcard indexes.<br />Used with the `LIKE` operator.<br />Available only for string datatypes, except `TEXT` or `BLOB`.<br />Stored as `column_name.Wildcard` in the table.<br />NOTE: `WILDCARD` search uses full-text search in the backend, with significant performance degradation, and thus not recommended for databases with intensive workloads.                                                                                                          |

- A single column can be encrypted with multiple encryption schemes, or none. Columns encrypted with multiple encryption schemes will take up more space in the encrypted database. Columns without any encryption schemes are stored as plaintext.
- Additional supporting columns will also be added for encrypted tables.
- If only `SEARCH` or/and `RANGE` or/and `WILDCARD` encryption schemes are defined, the `STORE` encryption scheme will automatically be added as well.

## Support Matrix

| Operation | `STORE` | `SEARCH` | `ADDITION` | `MULTIPLICATION` | `RANGE` | `WILDCARD` |
| --------- | ------- | -------- | ---------- | ---------------- | ------- | ---------- |
| `=`       | -       | ⚪       | -          | -                | ⚪      | -          |
| `+`       | -       | -        | ⚪         | -                | -       | -          |
| `-`       | -       | -        | ⚪         | -                | -       | -          |
| `*`       | -       | -        | -          | ⚪               | -       | -          |
| `/`       | -       | -        | -          | ⚪               | -       | -          |
| `<`       | -       | -        | -          | -                | ⚪      | -          |
| `>`       | -       | -        | -          | -                | ⚪      | -          |
| `<=`      | -       | -        | -          | -                | ⚪      | -          |
| `>=`      | -       | -        | -          | -                | ⚪      | -          |
| `LIKE`    | -       | -        | -          | -                | -       | ⚪         |
| `SUM()`   | -       | -        | ⚪         | -                | -       | -          |
| `COUNT()` | -       | -        | -          | -                | -       | -          |
| `AVG()`   | -       | -        | ⚪         | -                | -       | -          |
| `MIN()`   | -       | -        | -          | -                | ⚪      | -          |
| `MAX()`   | -       | -        | -          | -                | ⚪      | -          |

- '⚪' signifies supported operation by encryption scheme.
- Plain-text columns support all native operations and are not restricted to the operators or functions listed here.
