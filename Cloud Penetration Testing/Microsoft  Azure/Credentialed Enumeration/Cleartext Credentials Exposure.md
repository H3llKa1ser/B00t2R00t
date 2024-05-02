# Cleartext Credentials exposure

### Examples:

# Hunting credentials in Resource Group Deployments

## Steps:

 - Get-AzDomainInfo -Verbose -Folder OUR_FOLDER (Enumerate environment with MicroBurst)

 - notepad .\OUR_FOLDER\Az\Development\Resources\Deployments.txt (Read the .txt file, you might find cleartext credentials and information like SSH credentials, DNS name of a host , etc.)
