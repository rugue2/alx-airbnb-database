-- Indexes for User table
CREATE INDEX idx_user_email ON "User"(email);
CREATE INDEX idx_user_id ON "User"(id);

-- Indexes for Property table
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_host ON Property(host_id);

-- Indexes for Booking table
CREATE INDEX idx_booking_user ON Booking(user_id);
CREATE INDEX idx_booking_property ON Booking(property_id);
CREATE INDEX idx_booking_date ON Booking(booking_date);

-- Measure performance with EXPLAIN ANALYZE
-- Example: Checking performance before/after using email filter and booking_date ordering
EXPLAIN ANALYZE
SELECT *
FROM Booking b
JOIN "User" u ON b.user_id = u.id
WHERE u.email = 'alice@example.com'
ORDER BY b.booking_date DESC;
