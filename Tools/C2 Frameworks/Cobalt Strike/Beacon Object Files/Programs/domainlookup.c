#include <windows.h>
#include <stdio.h>
#include <dsgetdc.h>
#include "beacon.h"
DECLSPEC_IMPORT DWORD WINAPI NETAPI32$DsGetDcNameA(LPVOID, LPVOID, LPVOID,
LPVOID,
ULONG, LPVOID);
DECLSPEC_IMPORT DWORD WINAPI NETAPI32$NetApiBufferFree(LPVOID);
void go(char * args, int alen) {
DWORD dwRet;
PDOMAIN_CONTROLLER_INFO pdcInfo;
dwRet = NETAPI32$DsGetDcNameA(NULL, NULL, NULL, NULL, 0, &pdcInfo);
if (ERROR_SUCCESS == dwRet) {
BeaconPrintf(CALLBACK_OUTPUT, "%s", pdcInfo->DomainName);
}
NETAPI32$NetApiBufferFree(pdcInfo);
}
