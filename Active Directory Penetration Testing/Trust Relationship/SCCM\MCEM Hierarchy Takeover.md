# SCCM/MCEM Hierarchy Takeover

In case an organisation has multiple SCCM primary sites dispersed between different domains, it has the possibility to setup a Central Administration Site to administrate all the sites from one "top" site server.

https://hideandsec.sh/link/59#bkmrk-if-it-the-case%2C-by-d
 
If it the case, by default the CAS will automatically replicate all the SCCM site admins between all the sites. This means, if you have takeover one site and added a controlled user as SCCM site admin, he will be automatically added as a site admin on all the other site by the CAS, and you can use him to pivot between the sites.
