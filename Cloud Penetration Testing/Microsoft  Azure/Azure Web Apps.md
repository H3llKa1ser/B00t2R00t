# Azure Web Apps

### Find enabled hostnames

 - (Get-AzWebApp -ResourceGroupName "RESOURCE_GROUP_NAME" -Name "WEB_APP_NAME").EnabledHostNames

### Any time an app is created, App Service creates a Kudu companion app for it that allows us to manage the app instance, including getting terminal access. The location of this app can vary depending on the configuration.

 - https://APP_NAME.scm.azurewebsites.net (if the app isn't in an isolation tier)

 - https://APP_NAME.scm.ASE_NAME.p.azurewebsites.net (if the app is internet-facing and in an isolated tier)

 - https://APP_NAME.scm.ASE_NAME.appserviceenvironment.net (if the app is internal and in an isolated tier)
