# Encodings

### 1) Encode powershell

    $text = "[Your PowerShell Command]"
    $encoded = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($text))
    Write-Output $encoded

### Altering Powershell Execution Policies

    powershell.exe -ExecutionPolicy Bypass -NoProfile -WindowStyle Hidden -EncodedCommand [Your Base64 Encoded Command]
