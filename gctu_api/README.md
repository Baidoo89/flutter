# GCTU Student Public Information API

A clean PHP/MySQL JSON API for retrieving public student information by card number.

## Files

- `server_1.php` - demo client that sends a JSON request to Server 2.
- `server_2.php` - API endpoint that validates the request and returns student data as JSON.
- `config.php` - shared MySQL connection settings.
- `setup/setup.php` - one-click setup for the database, table, and sample records.

## Setup

1. Copy the `gctu_api` folder into your web server root, for example `htdocs` in XAMPP.
2. Start Apache and MySQL.
3. Open:

   `http://localhost/gctu_api/setup/setup.php`

4. Test the API client:

   `http://localhost/gctu_api/server_1.php`

## Sample API Request

POST `http://localhost/gctu_api/server_2.php`

```json
{
  "student_id": "GHA-726767000-3",
  "request_source": "Server_1",
  "opt": "getInfo"
}
```

## Sample Success Response

```json
{
  "status": "success",
  "message": "Student record found.",
  "data": {
    "card_number": "GHA-726767000-3",
    "surname": "Baidoo",
    "firstname": "Benjamin",
    "sex": "Male",
    "dob": "2002-05-14",
    "phone": "0240000000",
    "email": "benjamin.baidoo@gctu.edu.gh",
    "digital_address": "GA-123-4567"
  }
}
```

## Notes

- Uses prepared statements to protect the database query.
- Returns proper JSON errors for validation, invalid source, invalid operation, missing records, and database issues.
- Accepts the old `reqstSrc`/`Sever_1` spelling for compatibility, but the professional request field is `request_source: Server_1`.
