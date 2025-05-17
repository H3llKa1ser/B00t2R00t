# Timestomp

Modify file time attributes to hide new changes to existing files.

### 1) Empire C2

usemodule powershell/management/timestomp

    > set FilePath "C:\Secrets\SecretNotes.txt"
    > set Modified 10/10/2020 12:00pm
    > set Accessed 10/10/2020 13:00pm
    > execute

### 2) Metasploit

##### View current MACE information

    timestomp "C:\Secrets\SecretNote.txt" -v

##### Set all MACE attributes

    timestomp "C:\Secrets\SecretNote.txt" -z "02/02/2020 23:13:23"

##### Recursively blank all MACE attributes

    timestomp C:\\Secrets\\ -r
