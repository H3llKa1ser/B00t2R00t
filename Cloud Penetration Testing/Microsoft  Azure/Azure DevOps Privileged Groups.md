## Privileged Groups on Azure DevOps

### How to check:

#### 1) Go to: Project -> Porject Settings -> Security -> Azure DevOps Groups

### Privileged group 1: Build Administrators

### Build Administrators group have full access over the pipelines in the project. Which means we can create new build definitions to execute arbitrary commands

## Steps:

#### 1) Go to: Project Settings -> Agent Pools -> Setup -> Agents -> USER -> Capabilities (Check in whose context the build definition is executed)

#### 2) Then go to: Pipelines -> New pipeline -> Use the classic editor -> Continue (Abuse this)

#### 3) Select: Empty Pipeline at the bottom of the list -> Add

#### 4) In the Agent Pool choose setup -> Click the + button -> Powershell Task (Set the agent to do a task)

#### 5) Click the newly created Powershell Task and set it to run as inline (It allows to insert powershell code directly into the task)

#### 6) net user kaiser Pwned!123 /add ; net localgroup administrators kaiser /add

#### 7) PWNED!
