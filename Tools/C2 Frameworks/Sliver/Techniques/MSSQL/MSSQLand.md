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
