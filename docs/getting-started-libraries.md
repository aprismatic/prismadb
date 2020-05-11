# Getting Started (Libraries)

These quick start samples are only relevant if you are using Prisma/DB libraries instead of the Prisma/DB proxy.

## Non-Query Execution

```csharp
PrismaSqlConnection conn = new PrismaSqlConnection(connectionString);
PrismaSqlCommand command = new PrismaSqlCommand("INSERT INTO table1 (col1, col2, col3) VALUES (1, 2, 'abc')", conn);
conn.Open();
int res = command.ExecuteNonQuery();
Console.WriteLine(res);
conn.Close();
conn.Dispose();
```

## Query Result Execution with `using`

```csharp
using (var conn = new PrismaSqlConnection(connectionString))
{
    conn.Open();

    using (var command = new PrismaSqlCommand("SELECT col1, col2, col3 FROM table1", conn))
    {
        using (var reader = command.ExecuteReader())
        {
            Console.WriteLine($"{reader.Columns[0].ColumnName}, " +
                                $"{reader.Columns[1].ColumnName}, " +
                                $"{reader.Columns[2].ColumnName}");

            while (reader.Read())
            {
                Console.WriteLine($"{reader[0]}, {reader[1]}, {reader[2]}");
            }
        }
    }
}
```
