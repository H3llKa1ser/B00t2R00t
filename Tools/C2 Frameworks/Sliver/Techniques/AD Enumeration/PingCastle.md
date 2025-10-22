# PingCastle

Download the free version from PingCastle's site - Its in C# so we can run this easily using exec-assem

### 1) Go within the world writable directory for ease

    cd C:/Windows/tasks


### 2) Run the pingcastle tool

    execute-assembly -t 200 /home/kali/tools/bins/PingCastle_3.3.0.1/PingCastle.exe --healthcheck --explore-trust --explore-forest-trust --level Full --no-enum-limit --skip-null-session


### 3) Against a domain

    execute-assembly -t 200 /home/kali/tools/bins/PingCastle_3.3.0.1/PingCastle.exe --server mydomain.com --healthcheck --explore-trust --explore-forest-trust --level Full --no-enum-limit --skip-null-session


### 4) Generate logs for PingCastle - on disk

    execute-assembly -t 200 /home/kali/tools/bins/PingCastle_3.3.0.1/PingCastle.exe --server mydomain.com --log --healthcheck --explore-trust --explore-forest-trust --level Full --no-enum-limit --skip-null-session
