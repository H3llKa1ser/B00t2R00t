# Automation Account Credentials

#### 1) Check if we can read the Automation Account Credentials in plaintext

    Get-AzAutomationCredential -ResourceGroupName "RESOURCE_GROUP" -AutomationAccountName "ACC_NAME" | Format-Table Name, CreationTime, Description 

#### 2) Get the plaintext credential

    Get-AzAutomationVariable -ResourceGroupName "RESOURCE_GROUP" -AutomationAccountName "ACC_NAME" | fl Name, Value, Description 
