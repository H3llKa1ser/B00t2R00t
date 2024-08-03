$token = $AzureManagementToken.access_token
$uri = "https://management.azure.com/subscriptions/ceff06cb-e29d-4486-a3ae-eaaec5689f94/resourceGroups/mbt-rg-14/providers/Microsoft.App/containerApps/project-oakley/listSecrets?api-version=2024-03-01"

$headers = @{
    'Authorization' = "Bearer $token"
    'Content-Type' = 'application/json'
}

Invoke-RestMethod -Uri $uri -Method POST -Headers $headers
