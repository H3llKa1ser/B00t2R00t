# COBALT STRIKE 

## For more detailed information about Cobalt Strike: https://www.cobaltstrike.com/ (Cited from the User Guide manual)

## Cobalt Strike Team Server

### Cobalt Strike is split into client and a server components. The server, referred to as the team server, is the controller for the Beacon payload and the host for Cobalt Strike’s social engineering features. The team server also stores data collected by Cobalt Strike and it manages logging

#### Team server start command: ./teamserver <ip_address> <password> [>malleableC2profile> <kill_date>]

  - IP Address - (mandatory) Enter the externally reachable IP address of the team server. Cobalt Strike uses this value as a default host for its features.
  - Password - (mandatory) Enter a password that your team members will use to connect the Cobalt Strike client to the team server.
  - Malleable C2 Profile - (optional) Specify a valid Malleable C2 Profile.
  - Kill Date - (optional) Enter a date value in YYYY-MM-DD format. The team server will embed this kill date into each Beacon stage it generates. The Beacon payload will refuse to run on or after this date and will also exit if it wakes up on or after this date.
