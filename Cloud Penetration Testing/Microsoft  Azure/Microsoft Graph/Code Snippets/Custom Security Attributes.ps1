# Connect to Microsoft Graph
Connect-MgGraph

# Retrieve all users
$allUsers = Get-MgUser -All

# Loop through all users and retrieve their custom security attributes
foreach ($user in $allUsers) {
    $userAttributes = Get-MgUser -UserId $user.Id -Property "customSecurityAttributes"
    
    # Display the additional properties of custom security attributes for each user
    Write-Host "User: $($user.UserPrincipalName)"
    $userAttributes.CustomSecurityAttributes.AdditionalProperties | Format-List
    Write-Host "---------------------------------------------"
}
