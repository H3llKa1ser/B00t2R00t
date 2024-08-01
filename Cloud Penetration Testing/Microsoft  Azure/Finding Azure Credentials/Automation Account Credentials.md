# Automation Account Credentials

 - Get-AzAutomationCredential -ResourceGroupName "RESOURCE_GROUP" -AutomationAccountName "ACC_NAME" | Format-Table Name, CreationTime, Description (Check if we can read the Automation Account Credentials in plaintext)

 - Get-AzAutomationVariable -ResourceGroupName "RESOURCE_GROUP" -AutomationAccountName "ACC_NAME" | fl Name, Value, Description (Get the plaintext credential)
