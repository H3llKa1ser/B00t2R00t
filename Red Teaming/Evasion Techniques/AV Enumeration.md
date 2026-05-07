# AV Enumeration

# Check if Defender is enabled

    Get-MpComputerStatus

    Get-MpComputerStatus | Select AntivirusEnabled

# Check if defensive modules are enabled

    Get-MpComputerStatus | Select RealTimeProtectionEnabled, IoavProtectionEnabled,AntispywareEnabled | FL

# Check if tamper protection is enabled

    Get-MpComputerStatus | Select IsTamperProtected,RealTimeProtectionEnabled | FL

# Alternate AV products

    Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct

## Decode "Product State" to hex can help identify which antivirus is enabled

    '0x{0:x}' -f <ProductState>
    '0x{0:x}' -f 393472

## Enumerate AV products with this One-Liner

    $processes = @{ "acnamagent" = "Absolute Persistence - Asset Management"; "acnamlogonagent" = "Absolute Persistence - Asset Management"; "AGMService" = "Adobe - Telemetry"; "AGSService" = "Adobe - Telemetry"; "aswidsagent" = "Avast - AV"; "avastsvc" = "Avast - AV"; "avastui" = "Avast - AV"; "avgnt" = "Avira - AV"; "avguard" = "Avira - AV"; "axcrypt" = "AxCrypt - Encryption"; "bdntwrk" = "Bitdefender - AV"; "updatesrv" = "Bitdefender - AV"; "bdagent" = "Bitdefender Total Security - AV"; "vsserv" = "Bitdefender Total Security - AV"; "cpd" = "Check Point Daemon - Security"; "fw" = "Check Point Firewall - Firewall"; "vpnagent" = "Cisco AnyConnect - VPN"; "vpnui" = "Cisco AnyConnect - VPN"; "aciseagent" = "Cisco Umbrella - Security DNS"; "acumbrellaagent" = "Cisco Umbrella - Security DNS"; "CmRcService" = "CmRcService - Remote Control"; "csfalconcontainer" = "CrowdStrike Falcon - EDR"; "csfalcondaterepair" = "CrowdStrike Falcon - EDR"; "csfalconservice" = "CrowdStrike Falcon - EDR"; "cbcomms" = "CrowdStrike Falcon Insight XDR"; "cybereason" = "Cybereason EDR"; "cytomicendpoint" = "Cytomic Orion - Security"; "DarktraceTSA" = "Darktrace - EDR"; "dsmonitor" = "DriveSentry - Security"; "dwengine" = "DriveSentry - Security"; "egui" = "ESET NOD32 AV"; "ekrn" = "ESET NOD32 AV"; "winlogbeat" = "Elastic Winlogbeat - Security"; "firesvc" = "FireEye Endpoint Agent - Security"; "firetray" = "FireEye Endpoint Agent - Security"; "xagt" = "FireEye HX - Security"; "fortiedr" = "FortiEDR - EDR"; "hips" = "Host Intrusion Prevention System - HIPS"; "avp" = "Kaspersky - AV"; "avpui" = "Kaspersky - AV"; "klwtblfs" = "Kaspersky - AV"; "klwtpwrs" = "Kaspersky - AV"; "ksde" = "Kaspersky Secure Connection - VPN"; "ksdeui" = "Kaspersky Secure Connection - VPN"; "kpf4ss" = "Kerio Personal Firewall - Firewall"; "mbae64" = "Malwarebytes - AV"; "mbamservice" = "Malwarebytes - AV"; "mbamswissarmy" = "Malwarebytes - AV"; "mbamtray" = "Malwarebytes - AV"; "mfeann" = "McAfee - AV"; "mfemms" = "McAfee - AV"; "masvc" = "McAfee - AV"; "macmnsvc" = "McAfee - AV"; "dlpsensor" = "McAfee DLP Sensor - DLP"; "eegoservice" = "McAfee Endpoint Encryption - Encryption"; "mdecryptservice" = "McAfee Endpoint Encryption - Encryption"; "mfeepehost" = "McAfee Endpoint Encryption - Encryption"; "edpa" = "McAfee Endpoint Security - AV"; "shstat" = "McAfee Endpoint Security - AV"; "mcshield" = "McAfee Endpoint Security - AV"; "mfefire" = "McAfee Endpoint Security - Firewall"; "msascuil" = "Windows Defender - AV"; "msmpeng" = "Windows Defender - AV"; "windefend" = "Windows Defender - AV"; "SecurityHealthService" = "Windows Security Health Service"; "tanclient" = "Tanium EDR - EDR" }; foreach ($key in $processes.Keys) { $description = $processes[$key]; if (![string]::IsNullOrWhiteSpace($key)) { $process = Get-Process -Name $key -ErrorAction SilentlyContinue; if ($process) { Write-Output "$description is running." } } }
