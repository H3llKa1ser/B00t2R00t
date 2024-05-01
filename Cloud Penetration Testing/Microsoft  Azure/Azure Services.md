# Azure Services that we can attack

## 1) App Services

 - This service is inclusive of App Service and Function apps in Azure. These services can be used for "serverless" web application and API hosting.

## 2) Storage Accounts

 - Storage accounts are used for most data storage operations in Azure. Files can be publicly or privately hosted, and files can be accessed through several protocols (HTTP, SMB, NFS). This service can also be used for static web content hosting.

## 3) Automation Accounts

 - Another "serverless" code service, Automation accounts allow you to run scripting code (Powershell and Python) from "runbooks" to automate processes in the subscription. This service has a big attack surface.

## 4) Virtual Machines

 - One of the initial backbones of cloud services, these are VMs hosted in the cloud. There are multiple facets to deploying VMs in the cloud, so this service will also be a major focal point.

## 5) Key Vaults

 - Azure key vaults are the primary credential store within Azure. This includes the storage of keys, secrets and certificates. Aside from utilizing the standard IAM rights assignments, access policies can be applied to provide additional resrictions on Key Vault data.

## 6) Azure SQL

 - This service is for hosting SQL databases in the cloud. Everything about the SQL database is managed by Microsoft, which can help simplify the usage of databases in Azure projects.

## 7) Azure Container Registry / Azure Container Instances

 - Azure Container Registry holds the container images used as base images for containerization. While it is a relatively small part of a containerized environment, this service is a commonly targeted one, as the images frequently house sensitive information.
