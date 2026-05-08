# Username Creation

Tool: username-anarchy https://github.com/urbanadventurer/username-anarchy

### 1) Verify email syntax is correct

    username-anarchy USER NAME -@ @megacorp.com

### 2) Create wordlist

    username-anarchy USER NAME -@ @megacorp.com > emails.txt


## Use Graph API to return emails

### 1) With Graph tokens, query the Microsoft Graph API endpoint to return emails from the domain

    curl -sS -H "Authorization: Bearer $graphtoken" -H "ConsistencyLevel: eventual" "https://graph.microsoft.com/v1.0/users?\$select=mail,userPrincipalName&\$top=999" | jq -r '.value[] | (.mail // .userPrincipalName)' > emails.txt
