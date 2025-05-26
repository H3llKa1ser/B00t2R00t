# C2 Setup

## Example: DNS based beacon

Setting up DNS records for DNS based beacon payloads

### Set below DNS Type A & NS records, where IP points to TeamServer

    @    | A  | 10.10.5.50
    ns1  | A  | 10.10.5.50
    pics | NS | ns1.nickelviper.com

### Verify the DNS configuration from TeamServer, it should return 0.0.0.0

    $ dig @ns1.nickelviper.com test.pics.nickelviper.com +short

### Use pics.nickelviper.com as DNS Host and Stager in Listener Configuration

Start the team server and run as service

    sudo ./teamserver 10.10.5.50 Passw0rd! c2-profiles/normal/webbug.profile

    sudo nano /etc/systemd/system/teamserver.service


    sudo systemctl daemon-reload
    sudo systemctl status teamserver.service
    sudo systemctl start teamserver.service
    sudo systemctl enable teamserver.service

Enable Hosting of Web Delivery Payloads via agscript client in headless mode

        cat host_payloads.cna
