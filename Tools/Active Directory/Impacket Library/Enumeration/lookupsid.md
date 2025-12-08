# Impacket-lookupsid

Impacket’s lookupsid allows you to enumerate user SIDs (Security Identifiers) and group SIDs on a Windows system. Each user account and group account on a Windows system has a unique SID. By obtaining the SIDs, you can gather information about existing user accounts, which can be valuable in understanding the network's structure and potential attack vectors.

    impacket-lookupsid domain.local/USER1:Password@123@DC_IP | grep -oP 'domain\\\K\w+(?=\s+\(SidTypeUser\))' | sort -u > usernames.txt
