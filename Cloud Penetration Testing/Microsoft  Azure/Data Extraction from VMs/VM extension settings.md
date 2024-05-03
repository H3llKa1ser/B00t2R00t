# Gathering credentials from the VM extension settings

### As part of the execution and logging associated with the extensions, they store the extension configuration files and logs on the VMs. These files can be parsed for sensitive information, including credentials. One of the primary offenders in this category is the domain join extension, which can end up storing the credentials used to join a VM to the domain.

## IMPORTANT NOTE: Watch out for domain join credentials. Not only can they be logged in the Run Command extension logs, but they can also be seen floating around in improperly shut down PowerShell ISE sessions.

## As the default local administrator account on a VM, you can open the PowerShell ISE and see whether any scripts are automatically recovered. The authors have seen many situations where an administrator will join a VM to the domain via scripts executed in the ISE, but due to an improper shutdown, the credentials can be recovered on the next ISE session with the local administrator user.

### As a local administrator on a VM, we can use certificates on the VM to decrypt protected settings stored by the VM extensions. To extract these data points from the extensions, we will take the following steps:

 - 1) Open a PowerShell session as a local administrator on a Windows VM.

 - 2. Import the Get-AzureVMExtensionSettings function from the MicroBurst toolkit: https://github.com/NetSPI/MicroBurst/blob/master/Misc/Get-AzureVMExtensionSettings.ps1.

 - 3. Run the Get-AzureVMExtensionSettings function and observe the results

### As a result of this script, you should hopefully see multiple instances of "ProtectedSettingsDecrypted" appearing in the output with sensitive extension information.
