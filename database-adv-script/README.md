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
