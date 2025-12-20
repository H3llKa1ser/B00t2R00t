# MaskProcessor

Link: https://github.com/hashcat/maskprocessor

## Examples

### 1) Generate a wordlist with the phrase "admin" followed by 4 digits

    mp64 "admin?d?d?d?d" > wordlist.txt

### 2) Generate a wordlist with the phrase "admin" appended by 4 uppercase, lowercase, digit, or symbol characters

    mp64 "admin?a?a?a?a" > wordlist.txt

## Charsets

Lowercase

    ?l = abcdefghijklmnopqrstuvwxyz

Uppercase

    ?u = ABCDEFGHIJKLMNOPQRSTUVWXYZ

Digits

    ?d = 0123456789

Symbol Characters

    ?s =  !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~

Lowercase, Uppercase, Digit, Symbol Characters
    
    ?a = ?l?u?d?s

Bytes
    
    ?b = 0x00 - 0xff

