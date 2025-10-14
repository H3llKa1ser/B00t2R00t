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

## Content Discovery

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



