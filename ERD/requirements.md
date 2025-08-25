# Airbnb ER Diagram

```mermaid
erDiagram
    USER {
        UUID user_id PK
        string first_name
        string last_name
        string email UNIQUE
        string password_hash
        string phone_number
        enum role
        timestamp created_at
    }

    PROPERTY {
        UUID property_id PK
        UUID host_id FK
        string name
        text description
        string location
        decimal price_per_night
        timestamp created_at
        timestamp updated_at
    }

    BOOKING {
        UUID booking_id PK
        UUID property_id FK
        UUID user_id FK
        date start_date
        date end_date
        decimal total_price
        enum status
        timestamp created_at
    }

    PAYMENT {
        UUID payment_id PK
        UUID booking_id FK
        decimal amount
        timestamp payment_date
        enum payment_method
    }

    REVIEW {
        UUID review_id PK
        UUID property_id FK
        UUID user_id FK
        int rating
        text comment
        timestamp created_at
    }

    MESSAGE {
        UUID message_id PK
        UUID sender_id FK
        UUID recipient_id FK
        text message_body
        timestamp sent_at
    }

    USER ||--o{ PROPERTY : "hosts"
    USER ||--o{ BOOKING : "makes"
    PROPERTY ||--o{ BOOKING : "has"
    BOOKING ||--o{ PAYMENT : "pays"
    USER ||--o{ REVIEW : "writes"
    PROPERTY ||--o{ REVIEW : "receives"
    USER ||--o{ MESSAGE : "sends/receives"
