# Enumeration

Check on any endpoints if SMB signing is disabled (If disabled, we can do relay attacks)

    nxc smb 10.10.10.0/24 --gen-relay-list list.txt
