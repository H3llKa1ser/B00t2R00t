# Sapphire ticket attack

### Sapphire tickets are similar to Diamond tickets in the way the ticket is not forged, but instead based on a legitimate one obtained after a request. The difference lays in how the PAC is modified. The Diamond ticket approach modifies the legitimate PAC. In the Sapphire ticket approach, the PAC of another powerful user is obtained through an S4U2self+u2u trick. This PAC then replaces the one featured in the legitimate ticket. The resulting ticket is an assembly of legitimate elements, and follows a standard ticket request, which makes it then most difficult silver/golden ticket variant to detect.

### Since Diamond tickets modify PACs on-the-fly to include arbitrary group IDs, chances are some detection software are (of will be) able to detect discrepancies between a PAC's values and actual AD relationships (e.g. a PAC indicates a user belongs to some groups when in fact it doesn't).

### Sapphire tickets are an alternative to obtaining similar tickets in a stealthier way, by including a legitimate powerful user's PAC in the ticket. There will be no discrepancy anymore between what's in the PAC and what's in Active Directory.

### The powerful user's PAC can be obtained through an S4U2self+u2u trick.

### Requesting the target user's PAC with S4U2self+U2U exchange during TGS-REQ(P) (PKINIT).

### The goal is to mimic the PAC field as close as possible to a legitimate one.

## Requirements:

#### 1) Impacket

#### 2) krbtgt AES key

## Sapphire Ticket on Linux

 - ticketer.py -request -impersonate 'domainadmin' -domain 'DOMAIN.FQDN' -user 'domain_user' -password 'password' -nthash 'krbtgt NT hash' -aesKey 'krbtgt AES key' -user-id '1115' -domain-sid 'S-1-5-21-...' 'baduser' (baduser value will be ignored)

### The arguments used to customize the PAC will be ignored (-groups, -extra-sid,-duration), the required domain SID (-domain-sid) as well as the username supplied in the positional argument (baduser in this case). All these information will be kept as-is from the PAC obtained beforehand using the S4U2self+u2u trick.





