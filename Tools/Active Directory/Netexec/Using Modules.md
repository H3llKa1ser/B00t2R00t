# Using Modules with Netexec

## Viewing Available Modules for a Protocol

## Run nxc <protocol> -L to view available modules for the specified protocol.

### For example to view all modules for the SMB protocol:

    nxc smb -L

## Using a Module

    nxc <protocol> <target(s)> -M <module name>.

### For example to run the SMB Mimikatz module:

    nxc smb <target(s)> -u Administrator -p 'October2022' -M lsassy

## Viewing Module Options

    nxc <protocol> -M <module name> --options

#### Example: 

    nxc smb -M lsassy --options

## Using Module Options

### Module options are specified with the -o flag. All options are specified in the form of KEY=value (msfvenom style)

#### Example: 

    nxc <protocol> <target(s)> -u Administrator -p 'P@ssw0rd' -M lsassy -o COMMAND=xxxxxxxxug'

## Running Multiple Modules

### Simply define all the modules you want, each proceeded by a -m option flag:
 
    nxc <protocol> <target(s)> -u Administrator -p 'P@ssw0rd' -M spooler -M printnightmare -M shadowcoerce -M petitpotam
