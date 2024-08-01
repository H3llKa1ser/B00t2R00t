# Roadrecon

### Commands

 - roadrecon auth -u USER@DOMAIN.CORP -p 'PASSWORD' (Authenticate with our user using roadrecon)

 - roadrecon gather (Collects all Azure information that our user has permissions to see)

 - roadrecon gui (Start the RoadRecon webserver running at http://127.0.0.1:5000)

 - roadrecon plugin bloodhound --neodatabase localhost -du neo4j -dp password (Transfers data to the corresponding neo4j database if we have bloodhound installed)
