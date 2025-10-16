# Admin Panel

If you gain access to an admin panel, either through brute force or default credentials, your first step should be to check for file upload functionality. See if the application allows file uploads. If it’s a large application, search for remote code execution (RCE) vulnerabilities based on the application name and version. In many cases, you might find a file upload that leads to RCE.

## Steps

#### 1) Identify the application name and version

#### 2) Search for RCE

Immediately search public vulnerability databases (like Exploit-DB) for Authenticated RCE or File Upload vulnerabilities specific to that version.

#### 3) Execute via Upload

If a vulnerability exists, craft a payload (e.g., a reverse shell) and attempt to upload it, bypassing any client-side or server-side restrictions on file type.

#### 4) Trigger the Payload: 

Accessing the uploaded file via a web request or a specific function within the application can often trigger the execution of your payload, leading straight to a low-privilege shell (e.g., www-data).
