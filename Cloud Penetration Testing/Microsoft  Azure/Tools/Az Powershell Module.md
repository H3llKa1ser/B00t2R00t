# Az Powershell Module Micorsoft Azure and O365 CLI tool

## Commands:

 - Import-Module Az (Import Az Powershell Module)

## OR 

 - Install-Module  -Name Az (Run as Administrator)

### Authentication

 - Connect-AzAccount (Authentication)

 - $credential = Get-Credential

 - Connect-AzAccount -Credential $credential (Alternate Authentication Method)

 - Import-AzContext -Profile 'C:\Temp\Live Tokens\StolenToken.json'

 - Save-AzContext -Path C:\Temp\AzureAccessToken.json

### Account Information

 - Get-AzContext -ListAvailable (List the current Azure contexts available)

 - $context = Get-AzContext

 - $context.Name

 - $context.Account (Get context details)

 - Get-AzSubscription (List Subscriptions)

 - Select-AzSubscription -SubscriptionID "SUBSCRIPTION_ID" (Choose a subscription)

 - Get-AzRoleAssignment (Get the current user's role assignment)

 - Get-AzResource (List all resources) TIP: This command will return the resources for which the user has at least the Reader role in Role-Based Access Control (RBAC).

 - Get-AzResourceGroup (List all resource groups)

 - Get-AzStorageAccount (List storage accounts)

 - Get-AzADUser (List all users in the tenant)

 - GetAzADUser -UserPrincipalName 'USER.NAME@DOMAIN.CORP' | fl (List more information for a specific user in the tenant)

### Web Applications and SQL

 - Get-AzAdApplication (List azure app)

 - Get-AzWebApp (List azure web app)

 - Get-AzWebApp -Name megabigtechdevapp23 | select enabledhostnames (List hostnames that the web app is hosted and used)

 - Get-AzSQLServer (List SQL servers)

 - Get-AzSqlDatabase -ServerName $ServerName -ResourceGroupName $ResourceGroupName (Individual databases can be listed with information retrieved from the previous command)

 - Get-AzSqlServerFirewallRule –ServerName $ServerName -ResourceGroupName $ResourceGroupName (List SQL Firewall rules)

 - Get-AzSqlServerActiveDirectoryAdminstrator -ServerName $ServerName -ResourceGroupName $ResourceGroupName (List SQL Server AD Admins)

### Runbooks

 - Get-AzAutomationAccount (List Azure Runbooks)

 - Get-AzAutomationRunbook -AutomationAccountName AUTOMATION_ACCOUNT_NAME -ResourceGroupName RESOURCE_GROUP_NAME

 - Export-AzAutomationRunbook -AutomationAccountName $AccountName -ResourceGroupName $ResourceGroupName -Name $RunbookName -OutputFolder .\Desktop\ (Export a runbook)

### Virtual Machines

- Get-AzVM (List VMs and get OS details)

- $vm = Get-AzVM -Name "VM Name"

 - $vm.OSProfile

 - Invoke-AzVMRunCommand -ResourceGroupName $ResourceGroupName -VMName $VMName -CommandId RunPowerShellScript -ScriptPath ./powershell-script.ps1 (Run commands on VMs)

### Networking

 - Get-AzVirtualNetwork (List virtual networks)

 - Get-AzPublicIpAddress (List public IP addresses assigned to virtual NICs)

 - Get-AzExpressRouteCircuit (Get Azure ExpressRoute (VPN) Info)

 - Get-AzVpnConnection (Get Azure VPN Info)
