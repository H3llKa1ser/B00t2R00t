# Az Powershell Module Micorsoft Azure and O365 CLI tool

## Commands:

 - Import-Module Az (Import Az Powershell Module)

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

 - Get-AzResource (List all resources)

 - Get-AzResourceGroup (List all resource groups)

 - Get-AzStorageAccount (List storage accounts)

### Web Applications and SQL

 - Get-AzAdApplication (List azure app)

 - Get-AzWebApp (List azure web app)

 - Get-AzSQLServer (List SQL servers)

 - Get-AzSqlDatabase -ServerName $ServerName -ResourceGroupName $ResourceGroupName (Individual databases can be listed with information retrieved from the previous command)

 - Get-AzSqlServerFirewallRule –ServerName $ServerName -ResourceGroupName $ResourceGroupName (List SQL Firewall rules)

 - Get-AzSqlServerActiveDirectoryAdminstrator -ServerName $ServerName -ResourceGroupName $ResourceGroupName (List SQL Server AD Admins)

