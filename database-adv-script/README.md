# Advanced SQL Joins – Airbnb Database

This directory contains SQL queries that demonstrate how to use different types of JOINs in the Airbnb clone database.

## Queries Included

### 1. INNER JOIN

**File:** `joins_queries.sql`

```sql
SELECT b.id AS booking_id, b.property_id, b.start_date, b.end_date,
       u.id AS user_id, u.first_name, u.last_name, u.email
FROM Booking b
INNER JOIN User u
    ON b.user_id = u.id;
```

➡️ Retrieves all **bookings** along with the **users** who made them.
Bookings without a matching user will not be shown.

---

### 2. LEFT JOIN

```sql
SELECT p.id AS property_id, p.title, p.location,
       r.id AS review_id, r.rating, r.comment
FROM Property p
LEFT JOIN Review r
    ON p.id = r.property_id;
```

➡️ Retrieves all **properties** and their **reviews**.
Properties without reviews are still included.

---

### 3. FULL OUTER JOIN

```sql
SELECT u.id AS user_id, u.first_name, u.last_name,
       b.id AS booking_id, b.property_id, b.start_date, b.end_date
FROM User u
FULL OUTER JOIN Booking b
    ON u.id = b.user_id;
```

➡️ Retrieves all **users** and all **bookings**, even if:

* a user has **no bookings**
* or a booking is not linked to a valid user

---

## Usage

1. Load the schema and seed data in your database.
2. Run the queries in `joins_queries.sql`.
3. Verify results by checking cases where:

   * A booking exists without a user.
   * A property exists without reviews.
   * A user exists without bookings.

----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------

# SQL Subqueries – Airbnb Database

This directory contains examples of subqueries (correlated and non-correlated) using the Airbnb clone database.

## Queries Included

### 1. Non-Correlated Subquery

```sql
SELECT *
FROM Property
WHERE id IN (
    SELECT property_id
    FROM Review
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
)
ORDER BY id;
```

➡️ Finds all **properties** where the **average rating > 4.0**.
The inner subquery computes average ratings for each property.
The outer query retrieves only the properties that match.

---

### 2. Correlated Subquery

```sql
SELECT *
FROM "User" u
WHERE (
    SELECT COUNT(*)
    FROM Booking b
    WHERE b.user_id = u.id
) > 3
ORDER BY u.id;
```

➡️ Finds all **users** who have made **more than 3 bookings**.
The inner query depends on each row from the outer query (`u.id`).
This makes it a **correlated subquery**.

---

## Usage

1. Ensure schema and sample data are loaded.
2. Run the queries in `subqueries.sql`.
3. Verify results by checking:

   * Properties with average rating > 4.0.
   * Users with more than 3 bookings.

