$params = @{ 	
passwordProfile = @{
forceChangePasswordNextSignIn = $false
forceChangePasswordNextSignInWithMfa = $false
password = "Password12345!!"}
}
Update-MgUser -userid 'USER.NAME@DOMAIN.CORP' -BodyParameter $params
