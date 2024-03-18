# COBALT STRIKE 

## For more detailed information about Cobalt Strike: https://www.cobaltstrike.com/ (Cited from the User Guide manual)

## Cobalt Strike Team Server

### Cobalt Strike is split into client and a server components. The server, referred to as the team server, is the controller for the Beacon payload and the host for Cobalt Strike’s social engineering features. The team server also stores data collected by Cobalt Strike and it manages logging

#### Team server start command: ./teamserver <ip_address> <password> [>malleableC2profile> <kill_date>]

  - IP Address - (mandatory) Enter the externally reachable IP address of the team server. Cobalt Strike uses this value as a default host for its features.
  - Password - (mandatory) Enter a password that your team members will use to connect the Cobalt Strike client to the team server.
  - Malleable C2 Profile - (optional) Specify a valid Malleable C2 Profile.
  - Kill Date - (optional) Enter a date value in YYYY-MM-DD format. The team server will embed this kill date into each Beacon stage it generates. The Beacon payload will refuse to run on or after this date and will also exit if it wakes up on or after this date.

### When the team server starts, it will publish the SHA256 hash of the team server’s SSL certificate. Distribute this hash to your team members. When your team members connect, their Cobalt Strike client will ask if they recognize this hash before it authenticates to the team server. This is an important protection against man-in-the-middle attacks.

## Cobalt Strike Client
## Steps:
### To start the Cobalt Strike client, use the launcher included with your platform’s package.
### a. For Linux:
#### i. Enter the following commands:
#### ./cobaltstrike
### b. For MacOS X:
#### i. Navigate to the Cobalt Strike folder.
#### ii. Double-click cobaltstrike.
### c. For Windows:
#### i. Navigate to the Cobalt Strike folder.
#### ii. Double-click cobaltstrike.exe.

### The Connect Dialog screen displays.

### Cobalt Strike keeps track of the team servers you connect to and remembers your information. Select one of these team server profiles from the left-hand-side of the connect dialog to populate the connect dialog with its information. Use the Alias Names and Host Names buttons to toggle how the list of hosts are displayed. Active connections will be displayed in blue text. You may control how the host list is initially displayed, active connection text color, and prune the list through Cobalt Strike -> Preferences -> Team Servers

### Parameters: 

Alias - Enter an alias for the host or use the default. The alias name can not be empty,
start with an '*', or use the same alias name of an active connection.

Host - Specify your team server’s address in the Host field. The host name can not be
empty.

Port - Displays the default Port for the team server (50050). This is rarely change. The
port can not be empty and must be a numeric number.

User - The User field is your nickname on the team server. Change this to your call sign,
handle, or made-up hacker fantasy name. The user name can not be empty.

Password - Enter the shared password for the team server.

### Press Connect to connect to the Cobalt Strike team server

### If this is your first connection to this team server, Cobalt Strike will ask if you recognize the SHA256 hash of this team server.

### If you do, press Yes, and the Cobalt Strike client will connect to the server and open the client user interface.

## NOTE:  Cobalt Strike will also remember this SHA256 hash for future connections. You may manage these hashes through Cobalt Strike -> Preferences -> Fingerprints.

## Distributed and Team Operations

### Use Cobalt Strike to coordinate a distributed red team effort. Stage Cobalt Strike on one or more remote hosts. Start your team servers and have your team connect.

### Once connected to a team server, your team will:
  - Use the same sessions
  - Share hosts, captured data, and downloaded files
  - Communicate through a shared event log.

### The Cobalt Strike client may connect to multiple team servers. Go to Cobalt Strike -> New Connection to initiate a new connection. When connected to multiple servers, a switchbar will show up at the bottom of your Cobalt Strike window.

### This switchbar allows you to switch between active Cobalt Strike server instances. Each server has its own button. Right-click a button and select Rename to make the button’s text reflect the role of the server during your engagement. The server button will display the active button in bold text and color based on color preference found in Cobalt Strike -> Preferences -> TeamServers to better indicate which button is active. This button name will also identify the server in the Cobalt Strike Activity Report.

### When connected to multiple servers, Cobalt Strike aggregates listeners from all of the servers it’s connected to. This aggregation allows you to send a phishing email from one server that references a malicious website hosted on another server. At the end of your engagement, Cobalt Strike’s reporting feature will query all of the servers you’re connected to and merge the data to tell one story.

## Reconnecting the Client

### When the client disconnection is user-initiated with the Menu, Toolbar or Switchbar Server button, a red banner displays with a Reconnect and Close button.

### Press Close to close the window. Press Reconnect to reconnect to the TeamServer.

### If the TeamServer is not available a dialog displays asking if you want to retry (Yes/No). If Yes then connection is attempted again (repeats if needed). If No, the dialog closes.

### When disconnection is initiated by the TeamServer or other network interruption the red banner will display a message with a countdown for connection retry. This will repeat until a connection is made with the TeamServer or the user clicks on Close. In this case the user can interact with other parts of the UI.

### When the client reconnects, the red reconnect bar disappears.
