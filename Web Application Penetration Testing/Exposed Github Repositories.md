# Exposed Github Repositories Dumping

## Tools: Directory fuzzer tools (Feroxbuster, gobuster, dirbouster, etc...) and GitTools: https://github.com/internetwache/GitTools

## Wordlist used: /usr/share/seclists/Discovery/Web-Content/common.txt (Other standard wordlists might NOT detect the .git exposed folder)

### Steps:

 - feroxbuster -u http://DOMAIN.LOCAL -w /usr/share/seclists/Discovery/Web-Content/common.txt

### If an exposed .git folder is found, then we use the git tools to dump the entire repository to search for sensitive data and source code review

 - git-dumper.sh http://DOMAIN.LOCAL/ ./repo_source
