# Index Performance – Airbnb Database

This document explains how indexes were implemented in the **Airbnb Clone Database** to optimize query performance.

---

## Why Indexes?

Indexes help speed up queries that frequently use:

* **JOIN conditions** (foreign keys).
* **WHERE filters** (search by email, property location).
* **ORDER BY clauses** (sorting by booking date, etc.).

Without indexes, the database must scan the entire table (sequential scan), which is slow for large datasets.

---

## Indexes Implemented

### 1. User Table

```sql
-- Index on email for fast login and authentication lookups
CREATE INDEX idx_user_email ON "User"(email);

-- Index on id (primary key already indexed automatically, but explicitly noted)
CREATE INDEX idx_user_id ON "User"(id);
```

### 2. Property Table

```sql
-- Index on location to optimize property searches by city/country
CREATE INDEX idx_property_location ON Property(location);

-- Index on host_id for quick joins between User and Property
CREATE INDEX idx_property_host ON Property(host_id);
```

### 3. Booking Table

```sql
-- Index on user_id to speed up queries for "bookings by a user"
CREATE INDEX idx_booking_user ON Booking(user_id);

-- Index on property_id for property-booking lookups
CREATE INDEX idx_booking_property ON Booking(property_id);

-- Index on booking_date for sorting/filtering by date
CREATE INDEX idx_booking_date ON Booking(booking_date);
```

---

## Measuring Performance

### Example Query (Before Index)

```sql
EXPLAIN ANALYZE
SELECT *
FROM Booking b
JOIN "User" u ON b.user_id = u.id
WHERE u.email = 'alice@example.com'
ORDER BY b.booking_date DESC;
```

* **Without index:** Sequential Scan on `User` + `Booking` → slower as data grows.
* **With index:** Index Scan on `idx_user_email` and `idx_booking_date` → much faster.

---

## Summary

Indexes dramatically reduce query times for frequent operations such as:

* User login (`email` lookups).
* Property search (`location` filtering).
* Bookings (`user_id`, `property_id`, and `booking_date` joins & filters).

They trade off **slightly higher storage and slower writes** (INSERT/UPDATE) for **much faster reads**, which is ideal for the Airbnb use case where reads dominate.
