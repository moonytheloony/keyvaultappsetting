#Login to your Azure Account
Login-AzureRmAccount 
#Set your subscription as default
Set-AzureRmContext -SubscriptionId #YOUR SUBSCRIPTION ID#
#Create new Resource Group
New-AzureRmResourceGroup –Name 'KeyVaultAppSettingsResources' –Location 'SouthEast Asia'
#Create new Key Vault in the Resource Group
New-AzureRmKeyVault -VaultName 'KeyVaultAppSettings' -ResourceGroupName 'KeyVaultAppSettingsResources' -Location 'SouthEast Asia'
#Add some secrets
$secretValue1 = ConvertTo-SecureString 'Pa$$w0rd1' -AsPlainText -Force
$secretValue2 = ConvertTo-SecureString 'Pa$$w0rd2' -AsPlainText -Force
Set-AzureKeyVaultSecret -VaultName 'KeyVaultAppSettings' -Name 'APPSETTING-SecretKey1' -SecretValue $secretValue1
Set-AzureKeyVaultSecret -VaultName 'KeyVaultAppSettings' -Name 'SQLCONNSTR-SecretKey2' -SecretValue $secretValue2
#Grant permission to your application.
Set-AzureRmKeyVaultAccessPolicy -VaultName 'KeyVaultAppSettings' -ServicePrincipalName '#YOUR APPLICATION ID (Provisioned in Azure AD)#' -PermissionsToKeys all -PermissionsToSecrets all
#If you want to clear the resources, run the following script.
#Remove-AzureRmResourceGroup -ResourceGroupName 'KeyVaultAppSettingsResources'