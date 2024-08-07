# Azure Cosmos DB Service

## Database Enumeration:

$apiVersion = "API_VERSION"
$resourceGroupName = "RESOURCE_GROUP_NAME"
$databaseAccountName = "DB_ACCOUNT_NAME"
$databaseUri = "DATABASE_URI"

$dbResponse = Invoke-RestMethod -Uri $databaseUri -Method Get -Headers $headers
$dbResponse

## Connection to the Cosmos DB using a connection string or with username/password:

 - 1) Go to: https://cosmos.azure.com
  
 - 2) Use valid credentials or any key you have found to connect to the DB

### Example Key can be: AccountKey=AccountKey=SECRET_KEY==;TableEndpoint=https://DATABASE_NAME.table.cosmos.azure.com:443/;
