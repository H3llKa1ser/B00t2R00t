# Application Whitelisting

Sliver can run C# bins within the current process so we can use all those to enumerate, two ways:

- use the argument -i with execute-assembly

- inline-execute-assembly

### 1) Execute Assembly

    sharpup -- audit
    sharpup -i -- audit
    execute-assembly -i -- /home/kali/tools/bins/csharp-files/SharpUp.exe audit

### 2) Inline-execute-assembly

    inline-execute-assembly /home/kali/tools/bins/csharp-files/SharpUp.exe audit

