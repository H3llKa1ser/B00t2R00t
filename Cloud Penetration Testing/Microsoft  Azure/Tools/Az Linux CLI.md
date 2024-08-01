# Az Linux CLI Tool

### Authentication

 - az login

# Dump Azure Key Vaults

### List out any key vault resources the current account can view

 - az keyvault list –query '[].name' --output tsv

### With contributor level access you can give yourself the right permissions to obtain secrets.

 - az keyvault set-policy --name KEY_VAULT_NAME --upn YOUR_CONTRIBUTOR_USERNAME --secretpermissions get list --key-permissions get list --storage-permissions get list --certificate-permissions get list

### Get URI for Key Vault

 - az keyvault secret list --vault-name KEY_VAULT_NAME --query '[].id' --output tsv

### Get cleartext secret from keyvault

 - az keyvault secret show --id URI_FROM_LAST_COMMAND | ConvertFrom-Json

### Download the secret from keyvault in a .pem file for better formatting

 - az keyvault secret download --id URI_ID --file KEY.pem
