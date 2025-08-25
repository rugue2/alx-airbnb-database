# Database Seed – Airbnb Clone

This directory contains SQL scripts to populate the Airbnb schema with **sample data**.

## Files
- `seed.sql` → Populates the database with test data for Users, Properties, Bookings, Payments, Reviews, and Messages.

## Sample Data Overview
- **Users:** 5 (2 hosts, 2 guests, 1 admin)
- **Properties:** 2 (listed by hosts Bob and Diana)
- **Bookings:** 2 (Alice and Charlie booked properties)
- **Payments:** 1 (confirmed booking paid by Alice)
- **Reviews:** 2 (reviews left by Alice and Charlie)
- **Messages:** 2 (conversation between Alice and Bob)

## Usage
Run the seed script after creating the schema:

```bash
psql -U <username> -d <database> -f seed.sql
