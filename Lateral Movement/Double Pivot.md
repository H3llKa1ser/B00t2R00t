# Double Pivot

Double pivot AKA double proxy is used when we are trying to connect deeper into another network that is not visible to us via another internal network

##### /etc/proxychains.conf

##### Ensure dynamic_chain is uncommented

    dynamic_chain
    proxy_dns 
    tcp_read_time_out 15000
    tcp_connect_time_out 8000
    socks5  127.0.0.1 1080  # First Pivot
    socks5  127.0.0.1 1081  # Second Pivot
