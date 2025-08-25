# Database Schema – Airbnb Clone

This directory contains the **DDL SQL script** for the Airbnb database schema.

## Files
- `schema.sql` → SQL queries to create tables, constraints, and indexes.

## Schema Overview
The database includes 6 main entities:
1. **User** – stores user details (guest, host, admin).
2. **Property** – listings created by hosts.
3. **Booking** – reservations made by guests.
4. **Payment** – payments linked to bookings.
5. **Review** – reviews by users on properties.
6. **Message** – direct messages between users.

## Relationships
- A User **hosts** many Properties.
- A User **books** many Properties (via Booking).
- A Booking **has** Payments.
- A User **reviews** Properties.
- A User **sends/receives** Messages.

## Normalization
The schema is normalized up to **Third Normal Form (3NF)**:
- No repeating groups (1NF).
- No partial dependencies (2NF).
- No transitive dependencies (3NF).

## How to Use
Run the script in your PostgreSQL or MySQL environment:

```bash
psql -U <username> -d <database> -f schema.sql
