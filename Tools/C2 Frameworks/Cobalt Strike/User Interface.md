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

### An arrow connecting one Beacon session to another represents a link between two Beacons. Cobalt Strike’s Beacon uses Windows named pipes and TCP sockets to control Beacons in this peer-to-peer fashion. An orange arrow is a named pipe channel. SSH sessions use an orange arrow as well. A blue arrow is a TCP socket channel. A red (named pipe) or purple (TCP) arrow indicates that a Beacon link is broken.

### Click a Beacon to select it. You may select multiple Beacons by clicking and dragging a box over the desired hosts. Press Ctrl and Shift and click to select or unselect an individual Beacon.

### Right-click a Beacon to bring up a menu with available post-exploitation options.

### Right-click the Pivot Graph with no selected Beacons to configure the layout of this graph. This menu also has an Unlinked menu. Select Hide to hide unlinked sessions in the pivot graph. Select Show to show unlinked sessions again.

## Sessions Table

### The sessions table shows which Beacons are calling home to this Cobalt Strike instance. Beacon is Cobalt Strike’s payload to emulate advanced threat actors.

### If you use a DNS Beacon listener, be aware that Cobalt Strike will not know anything about a host until it checks in for the first time. If you see an entry with a last call time and that’s it, you will need to give that Beacon its first task to see more information.

### Right-click one or more Beacon’s to see your post-exploitation options.

## Targets Table

### The Targets Table shows the targets in Cobalt Strike’s data model. The targets table displays the IP address of each target, its NetBIOS name, and a note that you or one of your team members assigned to the target. The icon to the left of a target indicates its operating system. A red icon with lightning bolts indicates that the target has a Cobalt Strike Beacon session associated with it.

### Click any of the table headers to sort the hosts. Highlight a row and right-click it to bring up a menu with options for that host. Press Ctrl and Alt and click to select and deselect individual hosts.

### The target’s table is a useful for lateral movement and to understand your target’s network.

## Tabs

### Cobalt Strike opens each dialog, console, and table in a tab. Click the X button to close a tab. Use Ctrl+D to close the active tab. Ctrl+Shift+D will close all tabs except the active on.

### You may right-click the X button to open a tab in a window, take a screenshot of a tab, or close all tabs with the same name.

### Keyboard shortcuts exist for these functions too. Use Ctrl+W to open the active tab in its own window. Use Ctrl+T to quickly save a screenshot of the active tab.

### Ctrl+B will send the current tab to the bottom of the Cobalt Strike window. This is useful for tabs that you need to constantly watch. Ctrl+E will undo this action and remove the tab at the bottom of the Cobalt Strike window.

### Hold shift and click X to close all tabs with the same name. Hold shift + control and click X to open the tab in its own window

### Use Ctrl+Left and Ctrl+Right to quickly switch tabs. You may drag and drop tabs to change their order.

## TIP: The full list of Default Keyboard Shortcuts are available from the menu (Help -> Default Keyboard Shortcuts).

## Consoles

### Cobalt Strike provides a console to interact with Beacon sessions, scripts, and chat with your teammates.

### The consoles track your command history. Use the up arrow to cycle through previously typed commands. The down arrow moves back to the last command you typed. The history command lists previously typed commands. The ! command allows previously typed commands to be ran again.

## Note: The list of previously typed commands is not maintained between sessions. Closing a console window and then reopening it will start with no previously typed commands.

### Use the Tab key to complete commands and parameters.

### Use Ctrl+Plus to make the console font size larger, Ctrl+Minus to make it smaller, and Ctrl+0 to reset it. This change is local to the current console only. Visit Cobalt Strike -> Preferences to permanently change the font.

### Press Ctrl+F to show a panel that will let you search for text within the console. Use Ctrl+A to select all text in the console’s buffer.

## Tables

### Cobalt Strike uses tables to display sessions, credentials, targets, and other engagement information.

### Most tables in Cobalt Strike have an option to assign a color highlight to the highlighted rows. These highlights are visible to other Cobalt Strike clients. Right-click and look for the Color menu.

### Press Ctrl+F within a table to show the table search panel. This feature lets you filter the current table

### The text field is where you type your filter criteria. The format of the criteria depends on the column you choose to apply the filter to. Use CIDR notation (e.g., 192.168.1.0/24) and host ranges (192.168.1-192.169.200) to filter columns that contain addresses. Use numbers or ranges of numbers for columns that contain numbers. Use wildcard characters (*, ?) to filter columns that contain strings.

### The ! button negates the current criteria. Press enter to apply the specified criteria to the current table. You may stack as many criteria together as you like. The Reset button will remove the filters applied to the current table.

## Keyboard Shortcuts

### There are many default keyboard shortcuts available to you when working in the user interface. Some can be used anywhere while others are specific to different areas of the UI. 

### The Aggressor function, openDefaultShortcutsDialog, can also be used to open the same list.
