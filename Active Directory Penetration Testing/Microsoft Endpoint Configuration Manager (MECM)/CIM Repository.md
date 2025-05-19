# CIM Repository

https://viperone.gitbook.io/pentest-everything/everything/everything-active-directory/sccm-mecm/cred-4-cim-repository

## Description

Dump legacy secrets via CIM repository

The Network Access Account (NAA) is a domain account provisioned on a site server. The NAA account is used by SCCM clients to download software from the distribution point. Otherwise, it serves no other purpose within the configuration.

Regardless of whether a NAA account is configured or not, this method may still provide credential material.

Data stored within WMI classes can still exist with the CIM repository file, even long after the WMI class has been deleted or cleared of data. This file is located at

    C:\Windows\System32\wbem\Repository\OBJECTS.DATA

SharpDPAPI and SharpSCCM can be used to decrypted the encrypted data blobs and reveal the underlying credentials.

## Requirements

1) Local administrator privileges on an SCCM client

### SharpSCCM

    SharpSCCM.exe local secrets -m disk
