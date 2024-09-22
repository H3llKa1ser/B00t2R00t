# Web App Enumeration Playbook

## STEPS

 - Port scan the machine. Check for open ports.
  
 - Browse to the open web server. If it tries to resolve a name of the app, go to /etc/hosts file and insert the IP and name of the web app to resolve through DNS.

 - Use wappalyzer extension to enumerate for technologies used by the webapp.

 - Do directory fuzzing.

 - Do subdomain/virtual host enumeration.

 - Use cURL or/and Burpsuite to check for requests and responses to collect information such as: Scripting language, library names and versions, HTTP response headers.

 - If version enumeration was successful, use searchsploit or google to search for public exploits.

 - If not, try to test the functionalities of the web app to do manual exploitation and information gathering.

## LOGIN PAGES

 - If we encounter login pages, try to use default credentials.

 - If not, try to enumerate the rest of the site to find credentials to access.

 - As a last resort, you can brute-force the login page.
