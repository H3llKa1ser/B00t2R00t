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

# Types of CSRF Attack

#### 1) Traditional CSRF

 - Conventional CSRF attacks frequently concentrate on state-changing actions carried out by submitting forms. The victim is tricked into submitting a form without realising the associated data like cookies, URL parameters, etc. The victim's web browser sends an HTTP request to a web application form where the victim has already been authenticated. These forms are made to transfer money, modify account information, or alter an email address.

#### 2) XMLHttpRequest CSRF (Asynchronous)

 - An asynchronous CSRF exploitation occurs when operations are initiated without a complete page request-response cycle. This is typical of contemporary online apps that leverage asynchronous server communication (via XMLHttpRequest or the Fetch API) and JavaScript to produce more dynamic user interfaces. These attacks use asynchronous calls instead of the more conventional form submissions. Still, they exploit the same trust relationship between the user and the online service.

#### 3) Flash-based CSRF (.swf malicious Flash file)

 - The term "Flash-based CSRF" describes the technique of conducting a CSRF attack by taking advantage of flaws in Adobe Flash Player components. Internet applications with features like interactive content, video streaming, and intricate animationsflash based csrf have been made possible with Flash. But over time, security flaws in Flash, particularly those that can be used to launch CSRF attacks, have become a major source of worry. As HTML5 technology advanced and security flaws multiplied, official support for Adobe Flash Player ceased on December 31, 2020.

# Hidden Link/Image Exploitation

## Requirements:

### Victim has to click your malicious link while logged in with his credentials stored in the browser (Cookies, tokens, etc)

#### Craft an email and send this to a victim:

 - <!-- Website --> 
<a href="https://bank.xyz/transfer.php" target="_blank">Click Here</a>  
<!-- User visits attacker's website while authenticated -->

## Explanation:

### A covert technique known as hidden link/image exploitation in CSRF involves an attacker inserting a 0x0 pixel image or a link into a webpage that is nearly undetectable to the user. Typically, the src or href element of the image is set to a destination URL intended to act on the user's behalf without the user's awareness. It takes benefit of the fact that the user's browser transfers credentials like cookies automatically.

### This technique preys on authenticated sessions and utilises a social engineering approach when a user may inadvertently perform operations on a different website while still logged in.
