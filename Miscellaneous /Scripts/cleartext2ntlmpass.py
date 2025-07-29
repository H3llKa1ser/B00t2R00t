import hashlib
ntlm = hashlib.new('md4', 'CLEARTEXT_PASSWORD'.encode('utf- 16le')).digest().hex()
print(ntlm)
