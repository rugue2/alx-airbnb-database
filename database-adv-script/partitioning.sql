-- Step 1: Create a partitioned version of the Booking table
-- Partitioning by RANGE on start_date
CREATE TABLE Booking_Partitioned (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(50),
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES "User"(id),
    CONSTRAINT fk_property FOREIGN KEY (property_id) REFERENCES Property(id)
) PARTITION BY RANGE (start_date);

-- Step 2: Create partitions (for example, by year)
CREATE TABLE booking_2023 PARTITION OF Booking_Partitioned
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE booking_2024 PARTITION OF Booking_Partitioned
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- Step 3: Insert sample data
INSERT INTO Booking_Partitioned (user_id, property_id, start_date, end_date, status)
VALUES
(1, 1, '2023-05-01', '2023-05-07', 'Confirmed'),
(2, 3, '2023-08-15', '2023-08-20', 'Completed'),
(3, 2, '2024-02-10', '2024-02-15', 'Pending');

-- Step 4: Test query performance before partitioning
EXPLAIN ANALYZE
SELECT * FROM Booking b
WHERE b.start_date BETWEEN '2023-01-01' AND '2023-12-31';

-- Step 5: Test query performance after partitioning
EXPLAIN ANALYZE
SELECT * FROM Booking_Partitioned bp
WHERE bp.start_date BETWEEN '2023-01-01' AND '2023-12-31';
