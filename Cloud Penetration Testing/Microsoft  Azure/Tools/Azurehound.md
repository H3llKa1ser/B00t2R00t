# Azurehound

## Github repo: https://github.com/BloodHoundAD/AzureHound/releases/tag/v2.1.9

### Usage:

    ./azurehound -u "USER.NAME@DOMAIN.CORP" -p 'PASSWORD' list --tenant "TENANT_ID" -o output.json

    ./azurehound -j "JWT_ACCESS_TOKEN" list -o output.json (We can use access tokens from managed identities as well)

### Then upload the .json file on our bloodhound instance for processing
