### Tools: awscli

#### 1) aws --endpoint-url=http://ENDPOINT_URL:PORT dynamodb list-tables (List tables on the dynamoDB)

#### 2) aws --endpoint-url=http://ENDPOINT_URL:PORT dynamodb scan --table-name TABLE (List contents of the table)

#### 3) aws --endpoint-url=http://ENDPOINT_URL:PORT dynamodb create-table --table-name TABLE --attribute-definitions AttributeName=NAME,AttributeType=TYPE --key-schema AttributeName=NAME,AttributeType=S,KeyType=HASH provisioned-throughput ReadCapacityUnits=NUM,WriteCapacityUnits=NUM (Create a table with specific characteristics)

#### 4) aws --endpoint-url=http://ENDPOINT_URL:PORT dynamodb put-item --table-name TABLE --item '{"NAME":{"S":"WHATEVER"} (Creates an item for the specified table)

### TIP: If we are in a machine that has the database internally, before we use aws configure we must make sure we define as the home directory somewhere our current user has permissions.

#### 1) mkdir /tmp/f

#### 2) export HOME=/tmp/f

#### 3) aws configure (We are good to go!)
