# Rubeus createnetonly

### 1) Create process with the user credentials

    rubeus -t 20 -- createnetonly /program:C:\\Windows\\System32\\cmd.exe /domain:domain.com /username:user /password:password123

### 2) Migrate to the process or exec-shellcode, whichever works

    migrate -p 2560
