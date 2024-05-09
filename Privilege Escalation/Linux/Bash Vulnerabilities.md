# Bash scripting language vulnerabilities

## Pattern matching

### Example:

  if [[ $DB_PASS == $USER_PASS ]]; then
 /usr/bin/echo "Password confirmed!"
else
 /usr/bin/echo "Password confirmation failed!"
exit 1
fi

### Due to the use of == inside [[ ]] in Bash, it performs pattern matching rather than a direct string comparison.

### If the user inputs a wildcard (*) as their $USER_PASS password, the pattern match will be evaluated as TRUE because a wildcard matches ANY string.
