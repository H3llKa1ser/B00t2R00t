# XXE

### 1) Identification

XXE vulnerabilities occur when an application parses XML input from untrusted sources and processes external entities. An attacker can manipulate the XML content to read sensitive files from the system; these are the parts of the XML file.

### 2) Local File Disclosure

In this case data is being sent in the XML, so we can change it and test different variables (&[variable];) to display information.

<img width="1476" height="570" alt="image" src="https://github.com/user-attachments/assets/33b3e4f7-d16d-411b-aa1d-3a1cf78e2664" />

<img width="1260" height="574" alt="image" src="https://github.com/user-attachments/assets/3ebb3012-cd2e-4b78-8d9b-fa696d185ca3" />

