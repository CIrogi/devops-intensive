# Demo API (Java + PostgreSQL)

This is a minimal Spring Boot API that persists users in PostgreSQL.

## Requirements

- Java 17+
- Maven
- PostgreSQL

## Environment variables

Set the database credentials via environment variables:

- `DB_URL` (example: `jdbc:postgresql://localhost:5432/demo`)
- `DB_USER`
- `DB_PASSWORD`

## Run

```bash
export DB_URL=jdbc:postgresql://localhost:5432/demo
export DB_USER=demo
export DB_PASSWORD=demo

mvn spring-boot:run
```

## API

- `GET /api/users`
- `GET /api/users/{id}`
- `POST /api/users` with body:

```json
{
  "name": "Ada Lovelace",
  "email": "ada@example.com"
}
```
