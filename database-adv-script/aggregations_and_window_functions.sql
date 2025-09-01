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


-- 2. Window Function
-- Rank properties based on total number of bookings (using ROW_NUMBER)
SELECT 
    p.id AS property_id,
    p.title,
    COUNT(b.id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.id) DESC) AS booking_rank
FROM Property p
LEFT JOIN Booking b
    ON p.id = b.property_id
GROUP BY p.id, p.title
ORDER BY booking_rank;

