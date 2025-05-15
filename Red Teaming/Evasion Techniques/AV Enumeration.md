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
