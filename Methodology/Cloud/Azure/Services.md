# Azure Services

## CosmosDB

Tool: https://github.com/fjodoin/AzureRT/tree/main/cosmosdb_curling

### Connection String format:

    connection_string='AccountEndpoint=https://azsrvfw3374cdb.documents.azure.com:443/;AccountKey=KEY'

### 1) List Databases

 Use a CosmosDB connection string to connect to the database and conduct database operations. This will be used for all the commands with this tool here.

    python3 cosmosdb_curling.py --connection-string $connection_string --operation list-dbs

### 2) List CosmosDB collections

    python3 cosmosdb_curling.py --connection-string $connection_string --operation list-colls --database DATABASE_NAME

### 3) Pillage collection documents

    python3 cosmosdb_curling.py --connection-string $connection_string --operation list-docs --database DATABASE_NAME --collection COLLECTION_NAME

