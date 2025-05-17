# Startup Folder Persistence

The following assumes the following:

Privilege escalation is not of concern

You have access to at least to a low privilege user account.

Dropping shell scripts / binaries into the following folder will execute them on user login:

    C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

For example:

### 1) Upload backdoor.exe to the specific folder

    C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\backdoor.exe

### 2) Backdoor will be executed upon user login
