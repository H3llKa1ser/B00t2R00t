import jwt

public_key = "ADD_KEY_HERE"

payload = {
    'username' : 'user',
    'admin' : 0
}

access_token = jwt.encode(payload, public_key, algorithm="HS256")
print (access_token)
