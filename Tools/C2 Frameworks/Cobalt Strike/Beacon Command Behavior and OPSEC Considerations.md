# Beacon Command Behavior and OPSEC Considerations

### A good operator knows their tools and has an idea of how the tool is accomplishing its objectives on their behalf. This document surveys Beacon's commands and provides background on which commands inject into remote processes, which commands spawn jobs, and which commands rely on cmd.exe or powershell.exe.

# API-only

### The following commands are built into Beacon and rely on Win32 APIs to meet their objectives:

 - cd

 - cp

 - connect

 - download

 - drives

 - exit

 - getprivs

 - getuid

 - inline-execute

 - jobkill

 - kill

 - link

 - ls

 - make_token

 - mkdir

 - mv

 - ps

 - pwd

 - rev2self

 - rm

 - rportfwd

 - rportfwd_local

 - setenv

 - socks

 - steal_token

 - unlink

 - upload
