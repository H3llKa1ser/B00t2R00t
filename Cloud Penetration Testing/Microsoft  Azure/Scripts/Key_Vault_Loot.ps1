$secrets = Get-AzKeyVaultSecret -VaultName "VAULT_NAME"

foreach ($secret in $secrets) {
    Write-Output "Secret Name: $($secret.Name)"
    $secretValue = Get-AzKeyVaultSecret -VaultName "VAULT_NAME" -Name $secret.Name
    $secretValueText = $secretValue.SecretValue | ConvertFrom-SecureString -AsPlainText
    Write-Output "Secret Value: $secretValueText"
    Write-Output "Content Type: $($secretValue.ContentType)"
}
