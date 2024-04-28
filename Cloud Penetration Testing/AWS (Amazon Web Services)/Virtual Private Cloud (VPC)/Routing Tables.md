# AWS VPC Routing Tables

### A set of rules to determine where the traffic will be directed, comes in form of Destination and Target, defined as follows:

# DESTINATION -> TARGET

IP local -> VPC Internal

IP igw -> Internet Gateway

IP nat -> NAT Gateway

IP pcx -> VPC Peering

IP vpce -> VPC Endpoint

IP vgw -> VPN Gateway

IP eni -> Network Interface

 - VPC Internal -> Internal IP, no internet connection

 - Internet Gateway -> Used to access the internet

 - NAT Gateway -> Does the NAT between machines, allows one way connection to the internet

 - VPC Peering -> Allows the communication between 2 VPC's

 - VPC Endpoint -> Used to access aws services without internet connection (Internet Gateway)

 - VPN Gateway -> Used to expand the cloud to on premises and vice-versa

 - Network Interface -> Network Interfaces
