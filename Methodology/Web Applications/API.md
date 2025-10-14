# API Methodology

## Recon

Goal: Gather all possible subdomains for api.domain.com

### 1) Passive Recon

Tools: Gau, waymore, waybackurls, Urx, Subfinder, assetfinder, Amass
Github, Indexed Search Engines

Trickest Solutions, Chaos Database (Public target)

reconFTW

### 2) Active recon

Subdomain permutations

    altdns -u SUBS.txt -w /path/to/permutations.txt -r -o altdns.txt -s final_altdns.txt

Subdomain brute force

    puredns bruteforce /path/to/wordlist.txt rec.net --resolvers /path/to/resolvers | tee puredns_all_wordlist.txt


For non-responsive APIs or 404,405 HTTP codes, try other request methods (PUT, POST, PATCH, DELETE, etc)

For a 304 Modified request, remove all headers, but the necessary to grep the response. This happens likely in .js files

Tools: 

- swaggerHubCLI (Provide a JSON file of Swagger API schema in the website)

- sj tool (Test provided API schema)

### 3) Content Discovery

Goal: Gather as many endpoints as possible and parameters for api.domain.com

#### NOTE: Use tools to rotate your IP address or bypass rate limits if you have been blocked by a WAF.

### Steps:

Before choosing the correct list for fuzzing, browse the site, see requests and try to understand as much as possible the processed data through API.

Look for .js files. Either manually, or with tools like GAP, JSLUICE, BurpJSlinkFinder to extract more endpoints.

Fuzz all APIs with ffuf and Kiterunner

Ffuf

    ffuf -u https://target.com/FUZZ -r -p 0.1 -rate 5 -t 3 -mc 200-299,301,302,307,401,403,405,500 -c -w /path/to/wordlist.txt -o /path/to/output -http2 -H USER_AGENT

Kiterunner

    kiterunner brute api.target.com -w /path/to/wordlist.txt -x 1 -j 5 -o /path/to/output --progress

Extract all possible endpoints from postman via porche-pirate

More tools: Gau, waymore, waybackurls

Get API routes from EVERY exposed GUI function.

Look for API docs and extract URLs, in case you did not hit a swagger API-docs through fuzzing.

Look for URLs in Search Engines via dorking.

### 4) Parameter Fuzzing

Double check on .js files to extract more params (manually).


## Exploitation

After enumerating and discovering APIs, the goal is to exploit them with the vulnerabilities below:

### 1) IDOR

400 bad request sometimes it tells you to add parameters manually.

Check in headers or cookies for user id or something similar.

If you have a purchase you can refund. Also check there.

### 2) Broken Access Control (BAC)

Try to access all subdomains with the cookie or AUTH header that you have. You may get 200.

Replay all AUTHENTICATED requests (200) WITHOUT Cookie or AUTH header. You may get 200.

Try to access all API endpoints with Auth header from another API or subdomain.

On high risk endpoints which return PII or sensitive info, try parameter fuzzing to see if IDs are accepted via parameters.

### 3) Authentication Bypass

Double check on cookies, headers (same as BAC)

Try Authentication bypass on login pages, with SQLi, Response Manipulation, etc.

### 4) Cross-Site Request Forgery (CSRF)

CSRFs may pop up in Action Requests (POST, PUT, PATCH, DELETE) or a GET request accepted modified values as params 

    /api/v1/user?change_email=1@t.com&csrf=1234

If you see a cookie with Unchecked "HTTP Only" or "Secure", submit (Cookie Editor Extension).

If content-type likely to be url-encoded, try to change GET to POST and vice versa.

#### NOTE: If there are headers like: 

- Origin, Referrer, etc

- X-csrf:adcde

- ReCAPTCHA (Google)

#### CSRF is not exploitable!

### 5) Cross-Site Scripting XSS (Reflected-Stored-DOM)

Look for common injection points:

- Event Handlers (onerrpr, onmouseover, etc)

- Hyper links (href)

#### NOTE: DO NOT FORGET to check on IFRAME injections!

### 6) External XML Entity Injection (XXE)

Test if you find an XML content-type header.

Load the content-type list to investigate what a request would take as a content-type by investigating the response.
