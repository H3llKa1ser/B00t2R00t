## Steps:

### From the target machine:

#### 1) Sharphound.exe --CollectionMethods METHODS (Default all) --Domain DOMAIN --ExcludeDCs

#### 2) Collect Bloodhound.zip file

### From attacking machine:

#### 1) sudo neo4j console start

#### 2) bloodhound --no-sandbox

#### 3) Use default credentials (neo4j:neo4j) Or you can go to http://localhost:7474 to change default credentials

#### 4) Drag and drop zip file in Bloodhound GUI

#### 5) EZ ENUMERATION!1!1!!!1!

## BENEFITS

#### 1) GUI

#### 2) Shows attack paths

#### 3) More profound insights into AD Objects

## DRAWBACKS

#### 1) Requires Sharphound which is VERY noisy

## USAGE OF BLOODHOUND REMOTELY

#### 1) bloodhound-python -d DOMAIN.LOCAL -u 'USER' -p 'PASSWORD -dc DC.DOMAIN.LOCAL -c all

### TIP: If you receive DNS errors, you can set up a fake DNS server with the DNSChef tool https://github.com/iphelix/dnschef

#### 2) python3 dnschef.py --fakeip TARGET_IP --nameserver TARGET_IP

#### 3) bloodhound-python -d DOMAIN.LOCAL -u 'USER' -p 'PASSWORD' -dc DC.DOMAIN.LOCAL -c all -ns 127.0.0.1

## BLOODHOUND CYPHER QUERIES CHEATSHEET

### https://raw.githubusercontent.com/LuemmelSec/Custom-BloodHound-Queries/main/README.md
