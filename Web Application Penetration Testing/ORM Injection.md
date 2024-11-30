# Object Relational Mapping (ORM) Injection

### ORM Framework Identification Methods


 - 1) Verifying cookies: Examine the cookies set by the application. Frameworks often use unique naming conventions or formats for their session cookies, which can provide clues about the underlying technology.

 - 2) Reviewing source code: Look through the HTML source code for comments, meta tags, or any embedded scripts that might reveal framework-specific signatures. However, this method may only sometimes be conclusive.
  
 - 3) Analysing HTTP headers: HTTP headers can sometimes contain information about the server and framework. Tools like Burp Suite or browser developer tools can be used to inspect these headers.

 - 4) URL structure: The structure of URLs can give hints about the framework. For instance, certain routing patterns are unique to specific frameworks.

 - 5) Login and error pages: Authentication pages and error messages can sometimes reveal the framework. Some frameworks have distinctive error pages or login form structures. 

### ORM Injection Testing Techniques

 - 1) Manual code review: A thorough source code inspection can reveal raw query methods (such as whereRaw() in Laravel) that incorporate user inputs directly. Look for concatenated strings or unescaped inputs in ORM methods, which can indicate injection points.

 - 2) Automated scanning: Use security scanning tools that are designed to detect ORM injection vulnerabilities. These tools analyse the codebase to identify patterns that could lead to injection, such as dynamic query construction or improper input handling.

 - 3) Input validation testing: Perform manual testing by injecting payloads into application inputs to see if they affect the underlying ORM query. For example, injecting SQL control characters or keywords to determine if they alter the execution of the query.

 - 4) Error-based testing: Enter deliberately incorrect or malformed data to trigger errors. Detailed error messages can provide insights into the structure of the underlying queries and indicate potential vulnerabilities.

### Common Vulnerable Methods of ORM Libraries and Frameworks

#### Framework -> Library -> Methods

 - 1) Laravel -> Eloquent ORM -> whereRaw(), DB::raw()
  
 - 2) Ruby on Rails -> Active Record -> where("name = '#{input}'")
  
 - 3) Django -> Django ORM -> extra(), raw()
  
 - 4) Spring -> Hibernate -> createQuery() with concatenation
  
 - 5) Node.js -> Sequelize -> sequelize.query()
  

 ### PoC Payload against weak implementation of ORM framework

    1' OR '1'='1

 
