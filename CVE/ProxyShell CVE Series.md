# ProxyNotShell / ProxyShell / ProxyLogon (CVE-2022-41040 & CVE-2022-41082 / CVE-2021-34473 & CVE-2021-34523 & CVE-2021-31207 / CVE-2021-26855 & CVE-2021-27065)

These CVE series target Windows Exchange servers. Any unpatched server results in an RCE (full system compromise)

### 1) Metasploit

    msf6 exploit(windows/http/exchange_proxynotshell_rce) >
    msf6 exploit(windows/http/exchange_proxyshell_rce) >
    msf6 exploit(windows/http/exchange_proxylogon_rce) >
