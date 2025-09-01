# Query Optimization Report – Airbnb Database

## Initial Query
The first query retrieved **all booking, user, property, and payment details** using multiple JOINs.  
It selected more columns than necessary, which increased query cost.

### Issues Identified
- Selected unnecessary columns (`u.email`, `p.location`, `pay.payment_date`) when not always needed.
- Used **INNER JOIN** for payments, which excluded bookings without payments.
- Large joins increased execution time without proper filtering.

---

## Optimized Query
The optimized version:
- Reduced columns to only **essential ones** (`first_name`, `last_name`, `property_title`, `amount`, `status`).
- Used **LEFT JOIN** for `Payment` to include bookings without payments.
- Leveraged **indexes** on:
  - `Booking.user_id`
  - `Booking.property_id`
  - `Payment.booking_id`
  - `Booking.booking_date`

---

## Performance Analysis
Using `EXPLAIN ANALYZE`:
- **Initial query:** Sequential scans + high cost when dataset grows.
- **Optimized query:** Index scans on `booking_date`, `user_id`, and `payment.booking_id`. Lower execution cost.

---

## Conclusion
By reducing columns, changing unnecessary INNER JOINs to LEFT JOINs, and relying on indexes, we improved performance.  
This results in **faster queries**, especially on large datasets, while still delivering required data.
