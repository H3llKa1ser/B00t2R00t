# Shares Enumeration

## SharpShares

Takes a lot of time, if lots of share - Better to run within shell

    execute-assembly -t 200 /home/kali/tools/bins/csharp-files/SharpShares.exe /ldap:all

## Snaffler

Goes through all the network shares and their files to find out any credentials or sensitive information. Really useful for actual gigs. Better to run within shell

    execute-assembly -t 200 /home/kali/tools/bins/csharp-files/Snaffler.exe -s
