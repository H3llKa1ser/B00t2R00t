# Domain Enumeration

### Domain Policy

    ldeep ldap -u user1 -p password -d domain.local -s <LDAP_server_IP> domain_policy

### Password Policy

    nxc smb <targets> -u user1 -p password --pass-pol

### Another Domain

    ldeep ldap -u user1 -p password -d domain.local -s <remote_LDAP_server_IP> domain_policy

## Domain Controller

    nslookup domain.local
    nxc smb <DC_IP> -u user1 -p password

## Users Enumeration

### List Users

    ldeep ldap -u user1 -p password -d domain.local -s <LDAP_server_IP> users

### User's properties

    ldeep ldap -u user1 -p password -d domain.local -s <LDAP_server_IP> users -v
    nxc ldap <DC_IP> -u user1 -p password -M get-unixUserPassword -M getUserPassword

### Search for a particular string in attributes

    ldeep ldap -u user1 -p password -d domain.local -s <LDAP_server_IP> users -v |grep -i password

### Actively logged users on a machine (Local Admin access)

    nxc smb <target> -u user1 -p password --sessions

## User Hunting

### Find machine where the user has admin privs

If a Pwned connection appears, admin rights are present. However, if the UAC is present it can block the detection.

    nxc smb <targets_file> -u user1 -p password

### Find local admins on a domain machine

https://gist.github.com/ropnop/7a41da7aabb8455d0898db362335e139

    python3 lookupadmins.py domain.local/user1:password@<target_IP>

##### NXC

    nxc smb <targets> -u user1 -p password --local-groups Administrators

## Computers Enumeration

    ldeep ldap -u user1 -p password -d domain.local -s <LDAP_server_IP> machines

##### Full info

    ldeep ldap -u user1 -p password -d domain.local -s <LDAP_server_IP> machines -v

##### Hostname enumeration

    ldeep ldap -u user1 -p password -d domain.local -s <LDAP_server_IP> computers
    ldeep ldap -u user1 -p password -d domain.local -s <LDAP_server_IP> computers --resolve

## Groups Enumeration

### Groups in the current domain

    ldeep ldap -u user1 -p password -d domain.local -s <LDAP_server_IP> groups

##### Full info

    ldeep ldap -u user1 -p password -d domain.local -s <LDAP_server_IP> groups -v

### Search for a particular string in attributes

    ldeep ldap -u user1 -p password -d domain.local -s <LDAP_server_IP> groups -v |grep -i admin

### All users in a specific group

    ldeep ldap -u user1 -p password -d domain.local -s <LDAP_server_IP> membersof <group> -v

### All groups of a user

    ldeep ldap -u user1 -p password -d domain.local -s <LDAP_server_IP> memberships <user_account>

### Local groups enumeration

    nxc smb <target> -u user1 -p password --local-groups

### Members of a local group

    nxc smb <target> -u user1 -p password --local-groups <group>

## Shares / Files

### Find shares on the domain

    nxc smb <targets> -u user1 -p password --shares

A module for searching network shares:spider_plus. Running the module without any options (on a /24, for example) will produce a JSON output for each server, containing a list of all files (and some info), but without their contents. Then grep on extensions (conf, ini...) or names (password .. ) to identify an interesting file to search:

    nxc smb <targets> -u user1 -p password -M spider_plus

Then, when identifying a lot of interesting files, to speed up the search, dump this on the attacker machine by adding the -o READ_ONLY=False option after the -M spider_plus (but avoid /24, otherwise it'll take a long time). In this case, NetExec will create a folder with the machine's IP, and all the folders/files in it.

    nxc smb <targets> -u user1 -p password -M spider_plus -o READ_ONLY=False

Manspider can also be used for this purpose. It permits to crawl all the shares or specific ones, and filter on file extensions, file names, and file contents.

https://github.com/blacklanternsecurity/MANSPIDER

##### Filter on file names

    manspider <targets> -f passw user admin account network login logon cred -d domain -u user1 -p password

##### Search for content

    manspider <targets> -c passw cpassword -d domain -u user1 -p password

##### Search for file extension

    manspider <targets> -e bat com vbs ps1 psd1 psm1 pem key rsa pub reg pfx cfg conf config vmdk vhd vdi dit -d domain -u user1 -p password

Parameters can be combined.

### Find files with a specific pattern

    nxc smb <targets> -u user1 -p password --spider <share_name> --content --pattern pass

### Find files with sensitive data

https://github.com/skelsec/pysnaffler

    pysnaffler 'smb2+ntlm-password://domain\user1:password@<target>' <target>

## GPO Enumeration

### List of GPO in the domain

    ldeep ldap -u user1 -p password -d domain.local -s <LDAP_server_IP> gpo

## Organizational Units

### OUs of the domain and their linked GPOs

    ldeep ldap -u user1 -p password -d domain.local -s <LDAP_server_IP> ou

### Computers within an OU

    ldeep ldap -u user1 -p password -d domain.local -s <LDAP_server_IP> machines -v |grep -i "OU=<OU_name>" |grep -i "distinguishedName"

## DACLs

### All ACLs associated with an object (inbound)

##### With samAccountName

    dacledit.py -action read -target <target_samAccountName> -dc-ip <DC_IP> domain.local/user1:password

##### With DN

    dacledit.py -action read -target-dn <target_DN> -dc-ip <DC_IP> domain.local/user1:password

##### With SID

    dacledit.py -action read -target-sid <target_SID> -dc-ip <DC_IP> domain.local/user1:password

### Outbound ACLs of an object

These are the rights a principal has against another object

    dacledit.py -action read -target <target_samAccountName> -principal <principal_samAccountName> <-dc-ip <DC_IP> domain.local/user1:password

## Trusts

### Trusts for the current domain

    ldeep ldap -u user1 -p password -d domain.local -s <LDAP_server_IP> trusts
