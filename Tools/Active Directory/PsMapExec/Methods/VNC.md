# VNC

The VNC method is used to simply check if a VNC server has "NoAuth" set which means we can connect to the remote system without providing a username or password.

    PsMapExec -Targets [Targets] -Method VNC
