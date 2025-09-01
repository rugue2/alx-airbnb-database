# Performance Monitoring Report

## Objective

To continuously monitor and refine the performance of the Airbnb database by analyzing execution plans, identifying bottlenecks, and applying schema or index optimizations.

---

## Monitoring Methodology

* **Tools Used**: `EXPLAIN ANALYZE`, `SHOW PROFILE`.
* **Queries Analyzed**: Frequently executed queries involving joins, filters, and aggregations.

---

## Query 1: Fetch Bookings with User Email

```sql
EXPLAIN ANALYZE
SELECT b.id, b.start_date, p.title
FROM Booking b
JOIN "User" u ON b.user_id = u.id
JOIN Property p ON b.property_id = p.id
WHERE u.email = 'alice@example.com';
```

### Before

* Sequential scan on `User.email`.
* Slow when dataset size increased.

### Fix

```sql
CREATE INDEX idx_user_email ON "User"(email);
```

✅ Improved query to use **Index Scan** instead of Seq Scan.

---

## Query 2: Bookings by Date Range

```sql
EXPLAIN ANALYZE
SELECT *
FROM Booking
WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31';
```

### Before

* Full table scan on `Booking`.

### Fix

* Implemented **partitioning by start\_date**.
* Query execution only scans the relevant partition (2023).

---

## Query 3: Ranking Properties by Bookings

```sql
EXPLAIN ANALYZE
SELECT p.id, p.title,
       COUNT(b.id) AS total_bookings,
       RANK() OVER (ORDER BY COUNT(b.id) DESC) AS popularity_rank
FROM Property p
LEFT JOIN Booking b ON p.id = b.property_id
GROUP BY p.id, p.title;
```

### Before

* GROUP BY operation required scanning all bookings.

### Fix

```sql
CREATE INDEX idx_booking_property ON Booking(property_id);
```

✅ Reduced aggregation time by speeding up join lookups.

---

## Summary of Improvements

* **Indexes**: `User.email`, `Booking.property_id`.
* **Partitioning**: `Booking.start_date`.
* **Monitoring**: Execution plans are significantly faster and resource usage reduced.

