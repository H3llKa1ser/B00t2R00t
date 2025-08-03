# Active Directory Module RSAT tool

## TIP: Before using it, make sure to always invoke the command: 

    Import-Module ActiveDirectory

### Usage:

## 1) Get Current Domain

    Get-ADDomain

## 2) Enumerate Other Domains

    Get-ADDomain -Identity DOMAIN

## 3) Get Domain SID

    Get-DomainSID

## 4) Get Domain Controllers

    Get-ADDomainController

    Get-ADDomainController -Identity DOMAIN_NAME

## 5) Enumerate Domain Users

    Get-ADUser -Filter * -Identity USER -Properties *

### Get a specific "string" on a user's attribute

    Get-ADUser -Filter 'Description -like "*wtver*"' -Properties Description | select

## 6) Enumerate Domain Computers

    Get-ADComputer -Filter * -Properties *

    Get-ADGroup -Filter *

## 7) Enumerate Domain Trust

    Get-ADTrust -Filter *

    Get-ADTrust -Identity DOMAIN_NAME

## 8) Enumerate Forest Trust

    Get-ADForest

    Get-ADForest -Identity FOREST_NAME

### Domains of forest enumeration

    (Get-ADForest).Domains

## 9) Enumerate Local AppLocker Effective Policy

    Get-AppLockerPolicy -Effective | select -ExpandProperty RuleCollections
