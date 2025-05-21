# SOAPHound

As per the name implies, it functions similarly like Bloodhound, but uses SOAP queries through Active Directory Web Services (ADWS) instead of LDAP. Data can be displayed in Bloodhound.

##### Build cache

    SOAPHound.exe --showstats -c c:\temp\cache.txt

##### Collect data

    SOAPHound.exe -c c:\temp\cache.txt --bhdump -o c:\temp\bloodhound-output

##### For larger domain, if timeout errors are encountered

    SOAPHound.exe -c c:\temp\cache.txt --bhdump -o c:\temp\bloodhound-output --autosplit --threshold 1000

##### Collect ADCS data

    SOAPHound.exe -c c:\temp\cache.txt --certdump -o c:\temp\bloodhound-output

##### Dump ADIDNS data

    SOAPHound.exe --dnsdump -o c:\temp\dns-output
