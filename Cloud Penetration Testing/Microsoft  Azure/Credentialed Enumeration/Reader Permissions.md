# Account with Reader Permissions 

### Methods to enumerate the environment with reader permissions on our account:

#### 1) Automation (Powerzure , MicroBurst)

 - Get-AzureTargets (Powerzure)

 - Get-AzDomainInfo -Verbose -Folder YOUR_FOLDER (MicroBurst)

#### 2) Azure Portal

 - 1) Log in to the portal
  
 - 2) Navigate to: All resources blade
  
 - 3) Select Export to CSV from the top menu bar
  
 - 4) Download the CSV and sort the resource data by TYPE with Excel
  
 - 5) Add an additional column for "Count" and fill in the column with 1 in each row
  
 - 6) Use the Subtotal Excel function (with the following settings) to do a count at each change in type

 - 7) All done!
