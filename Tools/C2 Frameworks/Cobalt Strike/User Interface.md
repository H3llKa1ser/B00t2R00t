# User Interface

## Overview

### The Cobalt Strike user interface is split into two parts. The top of the interface shows a visualization of sessions or targets. The bottom of the interface displays tabs for each Cobalt Strike feature or session you interact with. You may click the area between these two parts and resize them to your liking.

## Toolbar

### The toolbar at the top of Cobalt Strike offers quick access to common Cobalt Strike functions. Knowing the toolbar buttons will speed up your use of Cobalt Strike considerably.

#### 1) Plus sign: Connect to another team server

#### 2) Minus sign: Disconnect from the current team server

#### 3) Headset: Create and edit Cobalt Strike’s listeners

#### 4) Nodes: Show Sessions in Graph View

#### 5) Three lines: Show Session in Table View

#### 6) Computer Screen: Show Targets in Table View

#### 7) Internet sign: Manage Web Server

#### 8) Three starts and one line sign: View Credentials

#### 9) Cloud download sign: View Download Files

#### 10) Keyboard: View Keystrokes

#### 11) Camera: View Screenshots

## Session and Target Visualizations

### Cobalt Strike has several visualizations each designed to aid a different part of your engagement. You may switch between visualizations through (Pivot Graph, Session Table, Target Table) buttons on the toolbar or the Cobalt Strike -> Visualization menu.

## Pivot Graph

### Cobalt Strike has the ability to link multiple Beacons into a chain. These linked Beacons receive their commands and send their output through the parent Beacon in their chain. This type of chaining is useful to control which sessions egress a network and to emulate a disciplined actor who restricts their communication paths inside of a network to something plausible. This chaining of Beacons is one of the most powerful features in Cobalt Strike.

### Cobalt Strike’s workflows make this chaining very easy. It’s not uncommon for Cobalt Strike operators to chain Beacons four or five levels deep on a regular basis. Without a visual aid it’s very difficult to keep track of and understand these chains. This is where the Pivot Graph comes in

### The Pivot Graph shows your Beacon chains in a natural way. Each Beacon session has an icon. As with the sessions table:the icon for each host indicates its operating system. If the icon is red with lightning bolts, the Beacon is running in a process with administrator privileges. A darker icon indicates that the Beacon session was asked to exit and it acknowledged this command.

### The firewall icon represents the egress point of your Beacon payload. A dashed green line indicates the use of beaconing HTTP or HTTPS connections to leave the network. A yellow dashed line indicates the use of DNS to leave the network.
