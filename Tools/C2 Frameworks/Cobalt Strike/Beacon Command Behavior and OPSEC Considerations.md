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

# House-keeping Commands

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

# Inline Execute (BOF)

### The following commands are implemented as internal Beacon Object Files. A Beacon Object File is a compiled C program, written to a certain convention, that executes within a Beacon session. The capability is cleaned up after it finishes running.

 - dllload

 - elevate svc-exe

 - elevate uac-token-duplication

 - getsystem

 - jump psexec

 - jump psexec64

 - jump psexec_psh

 - kerberos_ccache_use

 - kerberos_ticket_purge

 - kerberos_ticket_use

 - net domain

 - reg query

 - reg queryv

 - remote-exec psexec

 - remote-exec wmi

 - runasadmin uac-cmstplua

 - runasadmin uac-token-duplication

 - timestomp

### The network interface resolution within both the portscan and covertvpn dialogs uses a Beacon Object File as well.

## OPSEC Advice

### The memory for Beacon Object Files is controlled with settings from the Malleable C2’s process-inject block.

