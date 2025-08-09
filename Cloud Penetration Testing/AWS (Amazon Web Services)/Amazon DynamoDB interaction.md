# Amazon DynamoDB 

### Tools: awscli

### Default port: 4566

#### 1) List tables on the DynamoDB

    aws --endpoint-url=http://ENDPOINT_URL:PORT dynamodb list-tables 

#### 2) List contents of the table

    aws --endpoint-url=http://ENDPOINT_URL:PORT dynamodb scan --table-name TABLE 

#### 3) Create a table with specific characteristics

    aws --endpoint-url=http://ENDPOINT_URL:PORT dynamodb create-table --table-name TABLE --attribute-definitions AttributeName=NAME,AttributeType=TYPE --key-schema AttributeName=NAME,AttributeType=S,KeyType=HASH provisioned-throughput ReadCapacityUnits=NUM,WriteCapacityUnits=NUM 

#### 4) Creates an item for the specified table

    aws --endpoint-url=http://ENDPOINT_URL:PORT dynamodb put-item --table-name TABLE --item '{"NAME":{"S":"WHATEVER"} 

### TIP: If we are in a machine that has the database internally, before we use aws configure we must make sure we define as the home directory somewhere our current user has permissions.

#### 1) 

    mkdir /tmp/f

#### 2) 

    export HOME=/tmp/f

#### 3) 

    aws configure (We are good to go!)
