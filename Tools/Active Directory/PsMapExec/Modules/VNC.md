# VNC

This module searches for VNC passwords stored in the registry and configuration files for various VNC implementations, including RealVNC, TightVNC, TigerVNC, and UltraVNC. The module identifies and decrypts these passwords using the DES algorithm with a fixed key. It covers the following VNC implementations:

### RealVNC: Searches the registry for VNC server proxy credentials.

### TightVNC: Searches the registry for server passwords, control passwords, and view-only passwords.

### TigerVNC: Searches the registry for server passwords.

### UltraVNC: Searches for passwords in configuration files located in specified directories.

For each system output is stored in $pwd\PME\PME\VNC\

# Usage

##### Standard execution

    PsMapExec [Method] -targets All -Module VNC -ShowOutput

# Optional Parameters

### 1) Displays each target output to the console

    -ShowOutput

### 2) Display only successful results

    -SuccessOnly

# Supported Methods

1) MSSQL 

2) SMB 

3) SessionHunter

4) WMI 

5) WinRM
