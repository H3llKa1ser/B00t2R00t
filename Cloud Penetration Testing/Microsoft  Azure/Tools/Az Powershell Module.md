# Az Powershell Module Micorsoft Azure and O365 CLI tool

## Commands:

### 1) Import Az Powershell Module

    Import-Module Az 

## OR 

    Install-Module  -Name Az (Run as Administrator)

### 2) Authentication

    Connect-AzAccount 

    $credential = Get-Credential

### Alternate Authentication Method

    Connect-AzAccount -Credential $credential 

    Import-AzContext -Profile 'C:\Temp\Live Tokens\StolenToken.json'

    Save-AzContext -Path C:\Temp\AzureAccessToken.json

### 3) Account Information

#### List the current Azure contexts available

    Get-AzContext -ListAvailable 

    $context = Get-AzContext

    $context.Name

#### Get context details

    $context.Account 

#### List Subscriptions

    Get-AzSubscription

#### Choose a subscription

    Select-AzSubscription -SubscriptionID "SUBSCRIPTION_ID" 

#### Get the current user's role assignment

    Get-AzRoleAssignment 

#### List all resources (TIP: This command will return the resources for which the user has at least the Reader role in Role-Based Access Control (RBAC).)

    Get-AzResource

#### List all resource groups

    Get-AzResourceGroup

#### List storage accounts

    Get-AzStorageAccount 

#### List all users in the tenant

    Get-AzADUser 

#### List more information for a specific user in the tenant

    Get-AzADUser -UserPrincipalName 'USER.NAME@DOMAIN.CORP' | fl 

### 4) Web Applications and SQL

#### List Azure App

    Get-AzAdApplication 

#### List Azure Web App

    Get-AzWebApp 

#### List hostnames that he web app is hosted and used

    Get-AzWebApp -Name megabigtechdevapp23 | select enabledhostnames 

#### List SQL Servers

    Get-AzSQLServer 

#### Individual databases can be listed with information retrieved from the previous command

    Get-AzSqlDatabase -ServerName $ServerName -ResourceGroupName $ResourceGroupName 

#### List SQL Firewall rules

    Get-AzSqlServerFirewallRule –ServerName $ServerName -ResourceGroupName $ResourceGroupName 

#### List SQL Server AD Admins

    Get-AzSqlServerActiveDirectoryAdminstrator -ServerName $ServerName -ResourceGroupName $ResourceGroupName 

### 5) Runbooks

#### List Azure Runbooks

    Get-AzAutomationAccount

    Get-AzAutomationRunbook -AutomationAccountName AUTOMATION_ACCOUNT_NAME -ResourceGroupName RESOURCE_GROUP_NAME

#### Export a runbook

    Export-AzAutomationRunbook -AutomationAccountName $AccountName -ResourceGroupName $ResourceGroupName -Name $RunbookName -OutputFolder .\Desktop\ 

### 6) Virtual Machines

#### List VMs and get OS details

    Get-AzVM 

    $vm = Get-AzVM -Name "VM Name"

    $vm.OSProfile

#### Run commands on VMs

    Invoke-AzVMRunCommand -ResourceGroupName $ResourceGroupName -VMName $VMName -CommandId RunPowerShellScript -ScriptPath ./powershell-script.ps1 

### 7) Networking

#### List virtual networks

    Get-AzVirtualNetwork 

#### List public IP addresses assigned to virtual NICs

    Get-AzPublicIpAddress 

#### Get Azure ExpressRoute (VPN) Info

    Get-AzExpressRouteCircuit 

#### Get Azure VPN Info

    Get-AzVpnConnection
   
### 8) Miscellaneous

#### Download a specific storage blob to read it

    Get-AzStorageBlobContent -Container $containerName -Blob WHATEVER.TXT -Context $context 
