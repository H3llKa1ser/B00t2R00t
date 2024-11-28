# SQLi Filter Evasion Techniques

## Tool: Cyberchef https://gchq.github.io/CyberChef/

### 1) Character Encoding

#### There are 3 types if character encoding techniques:

 - 1) URL Encoding
  
 - 2) Unicode Encoding
  
 - 3) Hexadecimal Encoding
  
#### Use these type of encoding techniques to bypass WAF and code that sanitizes input on specific keywords (OR, UNION, SELECT, etc)

### 2) No Quotes

#### Techniques used:

 - 1) Numerical Values (Example: Instead of ' OR '1'='1, use OR 1=1)
  
 - 2) SQL Comments (Example: Instead of admin'--, use admin--)
  
 - 3) CONCAT() Function (Example: CONCAT(0x61, 0x64, 0x6d, 0x69, 0x6e). String is admin.)
  
 ### 3) No Spaces Allowed

 #### Techniques used:

  - 1) Comments to replace spaces
    
           (Example: Instead of SELECT * FROM users WHERE name = 'admin', use SELECT/**//*FROM/**/users/**/WHERE/**/name/**/='admin')
     
 -  2) Tab or Newline Characters
    
           (Example payload: SELECT\t*\tFROM\tusers\tWHERE\tname\t=\t'admin'. You can use \n instead of \t.)
  
 - 3) Alternate Characters (One effective method is using alternative URL-encoded characters representing different types of whitespace, such as %09 (horizontal tab), %0A (line feed), %0C (form feed), %0D (carriage return), and %A0 (non-breaking space). These characters can replace spaces in the payload.)

### 4) Banned keywords

        (Example: Instead of SELECT, write SelECt or SE/**/LECT)

### 5) Banned Logical Operators

        (Example: Instead of AND and OR, use || or &&
