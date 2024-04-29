# Cross-Site Request Forgery (CSRF/XSRF)

### CSRF is a type of security vulnerability where an attacker tricks a user's web browser into performing an unwanted action on a trusted site where the user is authenticated. This is achieved by exploiting the fact that the browser includes any relevant cookies (credentials) automatically, allowing the attacker to forge and submit unauthorised requests on behalf of the user (through the browser). The attacker's website may contain HTML forms or JavaScript code that is intended to send queries to the targeted web application.

## Cycle of CSRF

#### 1) The attacker already knows the format of the web application's requests to carry out a particular task and sends a malicious link to the user.

#### 2) The victim's identity on the website is verified, typically by cookies transmitted automatically with each domain request and clicks on the link shared by the attacker. This interaction could be a click, mouse over, or any other action.

#### 3) Insufficient security measures prevent the web application from distinguishing between authentic user requests and those that have been falsified.

## CSRF Impact

#### 1) Unauthorised Access

 - Attackers can access and control a user's actions, putting them at risk of losing money, damaging their reputation, and facing legal consequences.

#### 2) Exploiting Trust

 -  CSRF exploits the trust websites put in their users, undermining the sense of security in online browsing.

#### 3) Stealthy Exploitation

 -  CSRF works quietly, using standard browser behaviour without needing advanced malware. Users might be unaware of the attack, making them susceptible to repeated exploitation.
