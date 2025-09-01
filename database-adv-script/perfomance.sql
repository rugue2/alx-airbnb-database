-- Initial complex query: retrieves all bookings with user, property, and payment details
SELECT 
    b.id AS booking_id,
    u.first_name,
    u.last_name,
    u.email,
    p.title AS property_title,
    p.location,
    pay.amount,
    pay.payment_date,
    pay.status
FROM Booking b
JOIN "User" u ON b.user_id = u.id
JOIN Property p ON b.property_id = p.id
JOIN Payment pay ON b.id = pay.booking_id
ORDER BY b.booking_date DESC;

-- Analyze performance of initial query
EXPLAIN ANALYZE
SELECT 
    b.id AS booking_id,
    u.first_name,
    u.last_name,
    u.email,
    p.title AS property_title,
    p.location,
    pay.amount,
    pay.payment_date,
    pay.status
FROM Booking b
JOIN "User" u ON b.user_id = u.id
JOIN Property p ON b.property_id = p.id
JOIN Payment pay ON b.id = pay.booking_id
ORDER BY b.booking_date DESC;

-- Optimized query using indexes and selecting only needed columns
SELECT 
    b.id AS booking_id,
    u.first_name,
    u.last_name,
    p.title AS property_title,
    pay.amount,
    pay.status
FROM Booking b
JOIN "User" u ON b.user_id = u.id
JOIN Property p ON b.property_id = p.id
LEFT JOIN Payment pay ON b.id = pay.booking_id
ORDER BY b.booking_date DESC;

-- Analyze optimized query performance
EXPLAIN ANALYZE
SELECT 
    b.id AS booking_id,
    u.first_name,
    u.last_name,
    p.title AS property_title,
    pay.amount,
    pay.status
FROM Booking b
JOIN "User" u ON b.user_id = u.id
JOIN Property p ON b.property_id = p.id
LEFT JOIN Payment pay ON b.id = pay.booking_id
ORDER BY b.booking_date DESC;
