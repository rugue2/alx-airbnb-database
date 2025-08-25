-- Airbnb Database Seed Script
-- seed.sql

-- Insert Users
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
    (gen_random_uuid(), 'Alice', 'Johnson', 'alice@example.com', 'hashed_pw1', '1234567890', 'guest'),
    (gen_random_uuid(), 'Bob', 'Smith', 'bob@example.com', 'hashed_pw2', '2345678901', 'host'),
    (gen_random_uuid(), 'Charlie', 'Brown', 'charlie@example.com', 'hashed_pw3', '3456789012', 'guest'),
    (gen_random_uuid(), 'Diana', 'Williams', 'diana@example.com', 'hashed_pw4', '4567890123', 'host'),
    (gen_random_uuid(), 'Admin', 'User', 'admin@example.com', 'hashed_pw5', NULL, 'admin');

-- Insert Properties
INSERT INTO Property (property_id, host_id, name, description, location, price_per_night)
VALUES
    (gen_random_uuid(), (SELECT user_id FROM "User" WHERE email='bob@example.com'),
     'Cozy Apartment', 'A nice and cozy apartment in downtown.', 'New York', 120.00),
    (gen_random_uuid(), (SELECT user_id FROM "User" WHERE email='diana@example.com'),
     'Beach House', 'Spacious house with ocean view.', 'Los Angeles', 250.00);

-- Insert Bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
    (gen_random_uuid(),
     (SELECT property_id FROM Property WHERE name='Cozy Apartment'),
     (SELECT user_id FROM "User" WHERE email='alice@example.com'),
     '2025-09-01', '2025-09-05', 480.00, 'confirmed'),

    (gen_random_uuid(),
     (SELECT property_id FROM Property WHERE name='Beach House'),
     (SELECT user_id FROM "User" WHERE email='charlie@example.com'),
     '2025-09-10', '2025-09-15', 1250.00, 'pending');

-- Insert Payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
    (gen_random_uuid(),
     (SELECT booking_id FROM Booking WHERE status='confirmed'),
     480.00, 'credit_card');

-- Insert Reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
    (gen_random_uuid(),
     (SELECT property_id FROM Property WHERE name='Cozy Apartment'),
     (SELECT user_id FROM "User" WHERE email='alice@example.com'),
     5, 'Amazing stay! Very clean and comfortable.'),

    (gen_random_uuid(),
     (SELECT property_id FROM Property WHERE name='Beach House'),
     (SELECT user_id FROM "User" WHERE email='charlie@example.com'),
     4, 'Great view and spacious rooms.');

-- Insert Messages
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
    (gen_random_uuid(),
     (SELECT user_id FROM "User" WHERE email='alice@example.com'),
     (SELECT user_id FROM "User" WHERE email='bob@example.com'),
     'Hi Bob, is your apartment available for next weekend?'),

    (gen_random_uuid(),
     (SELECT user_id FROM "User" WHERE email='bob@example.com'),
     (SELECT user_id FROM "User" WHERE email='alice@example.com'),
     'Yes Alice, it is available! Feel free to book.');
