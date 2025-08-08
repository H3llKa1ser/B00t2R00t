# Roadrecon

### Commands

#### 1) Authenticate with our user using roadrecon

    roadrecon auth -u USER@DOMAIN.CORP -p 'PASSWORD' 

#### 2) Collects all Azure information that our user has permissions to see

    roadrecon gather 

#### 3) Start the RoadRecon webserver running at http://127.0.0.1:5000

    roadrecon gui 

#### 4) Transfers data to the corresponding neo4j database if we have bloodhound installed

    roadrecon plugin bloodhound --neodatabase localhost -du neo4j -dp password 
