# Insecure Direct Object Reference (IDOR)

## Locations:

### 1: URL

### 2: JS Files

### 3: Content loaded via an AJAX request

#### Use parameter mining attack to uncover sensitive to IDOR parameters.

# IDs

### 1: Encoded (Base64)

### 2: Hashed (MD5)

### 3: Unpredictable (Create 2 accounts and swap ID numbers between them)


## IDOR

`Identify IDORS`
- In `URL parameters & APIs`
- In `AJAX Calls`
- By `understanding reference hashing/encoding`
- By `comparing user roles`

| **Command**   | **Description**   |
| --------------|-------------------|
| `md5sum` | MD5 hash a string |
| `base64` | Base64 encode a string |
