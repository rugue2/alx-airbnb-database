# Database Normalization (Airbnb Database)

## Objective
The goal of this document is to ensure our Airbnb database design follows **Third Normal Form (3NF)** to eliminate redundancies and maintain data integrity.

---

## Step 1: First Normal Form (1NF)
- Each table has a **primary key** uniquely identifying each record.
- All attributes are **atomic** (no multi-valued or composite fields).
- No repeating groups.

**Check:**
- `User`, `Property`, `Booking`, `Payment`, `Review`, and `Message` tables all have single-valued attributes.  
✅ All tables are in 1NF.

---

## Step 2: Second Normal Form (2NF)
- Database is in 1NF.  
- All **non-key attributes must depend on the whole primary key** (no partial dependency).

**Check:**
- Each table uses a single-column primary key (`UUID`), so partial dependency is not possible.  
✅ All tables are in 2NF.

---

## Step 3: Third Normal Form (3NF)
- Database is in 2NF.  
- No **transitive dependencies** (non-key attributes must not depend on other non-key attributes).

**Check by table:**
- **User:** `role` depends only on `user_id`. No transitive dependency.  
- **Property:** `host_id` references `User`. All other attributes describe the property. No transitive dependency.  
- **Booking:** `total_price` depends only on booking details, not another non-key. No issue.  
- **Payment:** Attributes (`amount`, `payment_date`, `method`) depend directly on `payment_id`. No transitive dependency.  
- **Review:** `rating`, `comment`, `created_at` depend on `review_id`. No issue.  
- **Message:** `sender_id`, `recipient_id`, `message_body`, `sent_at` depend directly on `message_id`.

✅ All tables are in 3NF.

---

## Notes & Justifications
- **Derived attributes** such as `total_price` could be calculated from `Property.price_per_night × number_of_nights`. We chose to store it for performance reasons, but strictly speaking, storing it introduces redundancy. This is an intentional design trade-off.
- **Enums** (`role`, `status`, `payment_method`) could be normalized into lookup tables, but current enum use is acceptable since values are limited and controlled.

---

## Conclusion
The Airbnb database schema meets **Third Normal Form (3NF)**.  
- No repeating groups (1NF).  
- No partial dependencies (2NF).  
- No transitive dependencies (3NF).  

This ensures **data integrity**, **reduced redundancy**, and a clean foundation for further scaling.
