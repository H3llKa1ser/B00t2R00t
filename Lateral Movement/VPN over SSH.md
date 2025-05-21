# VPN over SSH

## Manual creation and destruction of interfaces

### On the pivot machine

    sudo ip tuntap add dev tun0 mode tun
    sudo ip addr add 10.43.43.1/30 peer 10.43.43.2 dev tun0
    sudo ip link set tun0 up

    sudo sysctl net.ipv4.conf.default.forwarding=1

### On the attacker machine

    sudo ip tuntap add dev tun0 mode tun
    sudo ip addr add 10.43.43.2/30 peer 10.43.43.1 dev tun0
    sudo ip link set tun0 up

    ssh user1@$PIVOT -w 0:0

##### -w permits to specify the interface numbers

### Setup NAT on the pivot machine

    sudo iptables -t nat -A POSTROUTING -s 10.43.43.2 -o eth1 -j MASQUERADE

##### Or

    sudo iptables -t nat -A POSTROUTING -s 10.43.43.2 -d 10.42.42.0/24 -j MASQUERADE

### Setup route on the attacker machine

    sudo ip route add 10.42.42.0/24 via 10.43.43.1

### Use ARP proxy instead of NAT

    sudo sysctl net.ipv4.conf.eth0.proxy_arp=1
    sudo ip neigh add proxy 10.43.43.2 dev eth0
