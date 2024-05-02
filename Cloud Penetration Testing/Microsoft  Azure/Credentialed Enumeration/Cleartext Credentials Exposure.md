# Cleartext Credentials exposure

### Examples:

# Hunting credentials in Resource Group Deployments

## Steps:

 - Get-AzDomainInfo -Verbose -Folder OUR_FOLDER (Enumerate environment with MicroBurst)

 - notepad .\OUR_FOLDER\Az\Development\Resources\Deployments.txt (Read the .txt file, you might find cleartext credentials and information like SSH credentials, DNS name of a host , etc.)

# App Service Configurations

### Azure App Service is the Microsoft service for hosting web applications and APIs in the cloud. The examples are in the context of a Reader role in a subscription.

## Azure App Service Apps

 - Get-AzWebApp (Enumerate Azure App Service apps)

## Azure Function Apps

### While technically a separate service, Azure Function apps are also kept under the overall umbrella of App Service. Both types of applications can be found in the App Service blade, so it's easy to get the services confused. The primary differentiator for Function apps is the way that apps are run on the Azure architecture.

### While App Service apps tend to mimic traditional web application deployments on a dedicated server, Function apps are intended as serverless functions that are run as needed and don't require the dedicated infrastructure to host. For those more familiar with AWS terminology, these are a close analogy to Lambda functions.

### As a Reader in the subscription, we have limited options with Function apps, but the available options can be quite impactful. 

### There are two options:

#### 1) Reading Function app code

#### 2) Reading app files

## Reading function app code as a reader:

 - 1) Navigate to individual Function apps , enter the Functions section and review the individual functions.
  
 - 2) Once in the menu for the function, we can navigate to the Code + Test section, which allows us to review the source code for the function.

### Anyone that has done source code review in the past will know that developers often hide things in the code to get things working in the application. This can often result in comments, passwords, and very vulnerable functions being readily identified by anyone with access to the code.

### As attackers with Reader access, we can look at this code to extract valuable information about the application, and potentially gather credentials that can be used to pivot.

## TIP: It is worth noting here that being able to read the code in the Function app depends on
the development method and deployment type used. For example, if development is done
locally (not in the portal) and deployed using web deploy, the code will not be visible. This
is also the case for compiled languages such as C

