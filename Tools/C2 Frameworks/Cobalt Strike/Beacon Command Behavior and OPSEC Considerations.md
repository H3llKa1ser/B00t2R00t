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

## House-keeping Commands

### The following commands are built into Beacon and exist to configure Beacon or perform housekeeping actions. Some of these commands (e.g., clear, downloads, help, mode, note) do not generate a task for Beacon to execute.

 - argue

 - blockdlls

 - cancel

 - checkin

 - clear

 - downloads

 - help

 - jobs

 - mode dns

 - mode dns-txt

 - mode dns6

 - note

 - powershell-import

 - ppid

 - sleep

 - socks stop

 - spawnto
