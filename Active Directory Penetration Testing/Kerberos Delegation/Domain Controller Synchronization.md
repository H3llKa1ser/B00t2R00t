# Domain Controller Synchronization

### Commands:

    sudo rdate -n DOMAIN.LOCAL

    sudo ntpdate -n DOMAIN.LOCAL

## TIP: In case you cannot get a kerberos tricket due to error like: "Clock skew too great", then run these commands to synchronize with the DC. Afterwards, you can obtain the ticket with the method you want to do as usual.

## TIP 2: Disable time sync in Virtualbox if clock skew errors are persistent

    VBoxManage.exe setextradata "Kali" "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled" 1
