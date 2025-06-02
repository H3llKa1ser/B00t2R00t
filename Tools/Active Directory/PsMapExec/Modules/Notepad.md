# Notepad

This module searches for stored data in various applications in the following locations as referenced in the table below;

| Application           | Location                                                                                         |
|------------------------|--------------------------------------------------------------------------------------------------|
| Notepad++              | `C:\Users\<UserProfile>\AppData\Roaming\Notepad++\backup\`                                       |
| Notepad (Windows 11 / Server 2025) | `C:\Users\<UserProfile>\AppData\Local\Packages\Microsoft.WindowsNotepad_*\LocalState\TabState\` |
| Visual Studio Code     | `C:\Users\<UserProfile>\AppData\Roaming\Code\Backups`                                            |
| PowerShell_ISE         | `C:\Users\<UserProfile>\AppData\Local\Microsoft_Corporation\powershell_ise*\`                   |

## NOTE: Default behavior in Windows 11 and Windows Server 2025 is to store Notepad files on disk in binary files. This module will attempt to extract readable strings from these files.

For each system output is stored in $pwd\PME\PME\Notepad\

# Usage

##### Standard execution

    PsMapExec [Method] -targets All -Module Notepad -ShowOutput

# Optional Parameters

### 1) Displays each target output to the console

    -ShowOutput

### 2) Display only successful results

    -SuccessOnly

# Supported Methods

1) MSSQL 

2) SMB 

3) SessionHunter

4) WMI 

5) WinRM
