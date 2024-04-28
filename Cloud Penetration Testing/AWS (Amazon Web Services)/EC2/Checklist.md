# EC2 Checklist

 - AMI, images used to create virtual machines

 - It's possible to create a malicious image to compromise users

 - We can access an instance using SSH Keys, EC2 Instance Connect, Session Manager 

 - The SSH Key method is permanent, we need to gather the private key to connect to the instance

 - EC2 Instance connect is an IAM right that we can add to a user, enabling us to temporarily connect to an instance

 - Session manager only work in browser and it does not need SSH Key

 - Windows machines can be accessed by using RDP, Session Manager

 - Security Groups acts as a virtual firewall to control inbound and outbound traffic, acts at the instance level, not the subnet level.
