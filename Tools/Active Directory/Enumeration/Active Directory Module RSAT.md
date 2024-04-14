# Active Directory Module RSAT tool

## TIP: Before using it, make sure to always invoke the command: Import-Module ActiveDirectory

### Usage:

## 1) Get Current Domain

 - Get-ADDomain

## 2) Enumerate Other Domains

 - Get-ADDomain -Identity DOMAIN

## 3) Get Domain SID

 - Get-DomainSID

## 4) Get Domain Controllers

 - Get-ADDomainController

 - Get-ADDomainController -Identity DOMAIN_NAME

## 5) Enumerate Domain Users

 - Get-ADUser -Filter * -Identity USER -Properties *

### Get a specific "string" on a user's attribute

 - Get-ADUser -Filter 'Description -like "*wtver*"' -Properties Description | select
