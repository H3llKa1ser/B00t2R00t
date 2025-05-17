# Delete Files

### 1) Cmd

##### Delete File

    del /f C:\TestFile.txt

##### Delete Folder

    rmdir /s /q C:\TestFolder

### 2) Powershell

##### Remove File

    Remove-Item -Path C:\TestFile.txt -Force -Verbose

##### Remove Folder

    Remove-Item -Recurse -Path C:\TestFolder -Force -Verbose

##### Remove Contents of Folder (Recursive)

    Get-ChildItem -Recurse -Path C:\TestFolder | Remove-Item -Force -Verbose

### 3) SDelete (Sysinternals)

##### Delete File securely 

    SDelete.exe -accepteula -nobanner -p 3 C:\TestFile.ext

##### Delete folder recursivley

    SDelete.exe -accepteula -nobanner -p 3 -s C:\TestFolder 
