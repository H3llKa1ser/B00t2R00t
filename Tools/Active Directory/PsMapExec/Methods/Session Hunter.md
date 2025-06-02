# Session Hunter

The SessionHunter method identifies systems with privileged or administrative user sessions, checks whether the current or provided user credentials have administrative access, and, if so, continues with command execution. 

This is an ideal method through which to filter target acquisition to isolate only the most pertinent targets.

# Usage

### Without command execution

    PsMapExec -Targets [Targets] -Method SessionHunter

### With command execution

    PsMapExec -Targets [Targets] -Command ipconfig

### With modules

    PsMapExec -Targets [Targets] -Module [Module]

# Optional Parameters

### 1) Only shows targets successful and relevant results

    -SuccessOnly

### 2) Set the Domain for which to run against

    -Domain domain.local

### 3) Will execute commands over WMI on candidate systems

    -Command whoami

### 4) Will execute specified modules over WMI on candidate systems

    -Module MODULE
