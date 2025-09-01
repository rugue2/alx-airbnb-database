-- 1. Aggregation with GROUP BY
-- Find the total number of bookings made by each user
SELECT 
    u.id AS user_id,
    u.first_name,
    u.last_name,
    COUNT(b.id) AS total_bookings
FROM "User" u
LEFT JOIN Booking b
    ON u.id = b.user_id
GROUP BY u.id, u.first_name, u.last_name
ORDER BY total_bookings DESC;


-- 2a. Window Function using ROW_NUMBER()
-- Assigns a unique rank to each property based on total bookings
SELECT 
    p.id AS property_id,
    p.title,
    COUNT(b.id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.id) DESC) AS booking_row_number
FROM Property p
LEFT JOIN Booking b
    ON p.id = b.property_id
GROUP BY p.id, p.title
ORDER BY booking_row_number;


-- 2b. Window Function using RANK()
-- Ranks properties by total bookings, ties get the same rank
SELECT 
    p.id AS property_id,
    p.title,
    COUNT(b.id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.id) DESC) AS booking_rank
FROM Property p
LEFT JOIN Booking b
    ON p.id = b.property_id
GROUP BY p.id, p.title
ORDER BY booking_rank;
