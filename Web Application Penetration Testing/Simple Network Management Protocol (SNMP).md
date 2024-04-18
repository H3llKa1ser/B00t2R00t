# Simple Network Management Protocol (SNMP)

### SNMP - Simple Network Management Protocol is a protocol used to monitor different devices in the network (like routers, switches, printers, IoTs...).

### Port: 161/162 UDP, 10161/10162 UDP if TLS is used

## SNMP Versions

### There are 2 important versions of SNMP:

#### 1) SNMPv1

 - Main one, it is still the most frequent, the authentication is based on a string (community string) that travels in plain-text (all the information travels in plain text). Version 2 and 2c send the traffic in plain text also and uses a community string as authentication.

#### 2) SNMPv3

 - Uses a better authentication form and the information travels encrypted using (dictionary attack could be performed but would be much harder to find the correct creds than in SNMPv1 and v2).

## Community Strings

### As mentioned before, in order to access the information saved on the MIB you need to know the community string on versions 1 and 2/2c and the credentials on version 3.

### The are 2 types of community strings:

#### 1) Public: Mainly read only functions

#### 2) Private: Read/Write in general

### Note that the writability of an OID depends on the community string used, so even if you find that "public" is being used, you could be able to write some values. Also, there may exist objects which are always "Read Only".

### If you try to write an object a  noSuchName or readOnly error is received**.**

### In versions 1 and 2/2c if you to use a bad community string the server wont respond. So, if it responds, a valid community strings was used.
