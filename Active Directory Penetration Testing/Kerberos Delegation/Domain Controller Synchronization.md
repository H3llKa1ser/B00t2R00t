# Domain Controller Synchronization

### Commands:

 - sudo rdate -n DOMAIN.LOCAL

 - sudo ntpdate -n DOMAIN.LOCAL

## TIP: In case you cannot get a kerberos tricket due to error like: "Clocl skew too fast", then run these commands to synchronize with the DC. Afterwards, you can obtain the ticket with the method you want to do as usual.
