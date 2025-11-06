# Virtual Network Computing (VNC)

Port 5900

### 1) Login

Use vncviewer or tigervnc to connect to a VNC server

    vncviewer <ip>:5900

More detailed connection with authentication

    vncviewer -passwd /path/to/passwordfile <ip>:5900

### 2) Brute force

    hydra -L <user_list> -P <password_list> vnc://<ip>

### 3) Default Credentials

    No Password
    vnc
    1234

### 4) Usage

1. Explore the filesystem
2. Run commands
3. Capture screenshots with scrot
4. Manipulate files
