# Partitioning Performance Report

## Objective

The goal was to optimize queries on a large `Booking` table by partitioning it based on the `start_date` column.

## Implementation

* Created a new table `Booking_Partitioned` partitioned by `RANGE (start_date)`.
* Defined yearly partitions: `booking_2023`, `booking_2024`.
* Inserted sample data into the partitioned table.

## Performance Testing

### Before Partitioning

```sql
EXPLAIN ANALYZE
SELECT * FROM Booking b
WHERE b.start_date BETWEEN '2023-01-01' AND '2023-12-31';
```

* The query scanned the **entire Booking table**, resulting in higher execution time on large datasets.

### After Partitioning

```sql
EXPLAIN ANALYZE
SELECT * FROM Booking_Partitioned bp
WHERE bp.start_date BETWEEN '2023-01-01' AND '2023-12-31';
```

* The query **scanned only the `booking_2023` partition**, significantly reducing execution time.

## Observations

* Partitioning reduced the search space by eliminating irrelevant partitions.
* Queries with `start_date` filters showed **noticeable performance improvements**.
* Maintenance becomes easier, as old partitions can be archived or dropped without impacting active data.

## Conclusion

Partitioning the `Booking` table by `start_date` is an effective optimization for time-based queries in large datasets.
