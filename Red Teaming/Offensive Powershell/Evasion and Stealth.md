# Evasion and Stealth

### 1) String Obfuscation

    $originalString = 'SensitiveCommand'; $obfuscatedString = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($originalString)); code $decodedString = [System.Text.Encoding]::Unicode.GetString([Convert]::FromBase64String($obfuscatedString)); Invoke-Expression $decodedString

### 2) Variable Name Obfuscation

    $o = 'Get'; $b = 'Process'; $cmd = $o + '-' + $b; Invoke-Expression $cmd

### 3) File Path Obfuscation

    $path = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('QzpcVGVtcFxBZG1pblRvb2xz')); Invoke-Item $path

### 4) Alternate Data Streams

    $content = 'Invoke-Mimikatz'; $file = 'C:\temp\normal.txt'; $stream = 'C:\temp\normal.txt:hidden'; Set-Content -Path $file -Value 'This is a normal file'; Add-Content -Path $stream -Value $content; Get-Content -Path $stream

### 5) In-Memory Script Execution

    $code = [System.IO.File]::ReadAllText('C:\temp\script.ps1'); Invoke-Expression $code

### 6) Dynamic Invocation with Reflection

    $assembly = [Reflection.Assembly]::LoadWithPartialName('System.Management'); $type = $assembly.GetType('System.Management.ManagementObjectSearcher'); $constructor = $type.GetConstructor(@([string])); $instance = $constructor.Invoke(@('SELECT * FROM Win32_Process')); $method = $type.GetMethod('Get'); $result = $method.Invoke($instance, @())

### 7) Encoded Command Execution

    $encodedCmd = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes('Get-Process')); powershell.exe -EncodedCommand $encodedCmd

### 8) Powershell Runspaces

    $runspace = [runspacefactory]::CreateRunspace(); $runspace.Open(); $pipeline = $runspace.CreatePipeline(); $pipeline.Commands.AddScript('Get-Process'); $results = $pipeline.Invoke(); $runspace.Close(); $results

### 9) Environment Variable Obfuscation

    $env:PSVariable = 'Get-Process'; Invoke-Expression $env:PSVariable

### 10) Function Renaming

    Function MyGetProc { Get-Process }; MyGetProc

### 11) Powershell Classes to Hide Code

    class HiddenCode { [string] Run() { return 'Hidden command executed' } }; $instance = [HiddenCode]::new(); $instance.Run()

### 12) Access WMI 

    $query = 'SELECT * FROM Win32_Process'; Get-WmiObject -Query $query

### 13) Base64 Encoding Command Obfuscation

    $command = 'Get-Process'; $encodedCommand = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($command)); powershell.exe -EncodedCommand $encodedCommand

### 14) Powershell Add-Type Code Execution

    Add-Type -TypeDefinition 'using System; public class MyClass { public static void Run() {Console.WriteLine("Executed"); } }'; [MyClass]::Run()
