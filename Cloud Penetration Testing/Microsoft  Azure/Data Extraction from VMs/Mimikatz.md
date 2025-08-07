# Gathering local credential with Mimikatz

## Example 1: Dump lsass.exe via task manager

 - On the Target VM, open Task Manager (CTRL + SHIFT + ESC) or type "taskmgr" in the Start Menu

 - Under details tab, find the lsass.exe process

 - Right-click on the lsass process and select "Create dump file"

 - Navigate to the folder of the process dump and copy the .dmp file to our system

 - On our testing system, we open a privileged powershell or CMD session and run Mimikatz

       sekurlsa::minidump lsass.dmp

       sekurlsa::logonPasswords full
