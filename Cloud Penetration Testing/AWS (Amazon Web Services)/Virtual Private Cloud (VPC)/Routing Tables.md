# AWS VPC Routing Tables

### A set of rules to determine where the traffic will be directed, comes in form of Destination and Target, defined as follows:

# DESTINATION -> TARGET

#### 1) IP local -> VPC Internal

#### 2) IP igw -> Internet Gateway

#### 3) IP nat -> NAT Gateway

#### 4) IP pcx -> VPC Peering

#### 5) IP vpce -> VPC Endpoint

#### 6) IP vgw -> VPN Gateway

#### 7) IP eni -> Network Interface

 - VPC Internal -> Internal IP, no internet connection

 - Internet Gateway -> Used to access the internet

 - NAT Gateway -> Does the NAT between machines, allows one way connection to the internet

 - VPC Peering -> Allows the communication between 2 VPC's

 - VPC Endpoint -> Used to access aws services without internet connection (Internet Gateway)

 - VPN Gateway -> Used to expand the cloud to on premises and vice-versa

 - Network Interface -> Network Interfaces
