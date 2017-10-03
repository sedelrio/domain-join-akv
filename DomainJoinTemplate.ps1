#New-AzureRmResourceGroupDeployment -Name TestingDeploy  -ResourceGroupName "testdomainjoin" -TemplateFile C:\Users\sebastid\Documents\Documentation\Templates\Domain Join\VM - Domain Join.json" -TemplateParameterFile C:\Users\sebastid\Documents\Documentation\Templates\Domain Join\domainjoinparameters.json"


#create Azure Key Vault
$vaultname = "kv-sebastid"
$password = "Passw0rd23456"

New-AzureRmKeyVault -VaultName $vaultname -ResourceGroupName security-sebastid -Location "eastus" -EnabledForTemplateDeployment
$secretvalue = ConvertTo-SecureString $password -AsPlainText -Force
Set-AzureKeyVaultSecret -VaultName $vaultname -Name "examplesecret" -SecretValue $secretvalue


# Using Secure String for password
$template = "C:\Users\sebastid\Documents\Documentation\Templates\Domain Join\VM - Domain Join.json"
$parameters = "C:\Users\sebastid\Documents\Documentation\Templates\Domain Join\domainjoinparamsKeyVault.json"
New-AzureRmResourceGroupDeployment -Name DomainJoin  -ResourceGroupName "testdomainjoin" -TemplateFile $template -TemplateParameterFile $parameters



# Using Azure Key Vault
$template = "C:\Users\sebastid\Documents\Documentation\Templates\Domain Join\VM - Domain Join.KV.json"
$parameters = "C:\Users\sebastid\Documents\Documentation\Templates\Domain Join\domainjoinparamsKeyVault.json"
New-AzureRmResourceGroupDeployment -Name DomainJoin  -ResourceGroupName "testdomainjoin" -TemplateFile $template -TemplateParameterFile $parameters

# Using Azure Key Vault and DSC
$template = "C:\Users\sebastid\Documents\Documentation\Templates\Domain Join\VM - Domain Join.KV.DSC.json"
$parameters = "C:\Users\sebastid\Documents\Documentation\Templates\Domain Join\domainjoinparamsKeyVault.DSC.json"
New-AzureRmResourceGroupDeployment -Name DomainJoin  -ResourceGroupName "testdomainjoin" -TemplateFile $template -TemplateParameterFile $parameters


#CLI
az group deployment create --resource-group examplegroup --template-file "C:\Users\sebastid\Documents\Documentation\Templates\Domain Join\VM - Domain Join.KV.DSC.json" --parameters "C:\Users\sebastid\Documents\Documentation\Templates\Domain Join\domainjoinparamsKeyVault.DSC.json" 



Publish-AzureVMDscConfiguration .\iisinstall.ps1 -ConfigurationArchivePath .\iisinstall.zip -Force
Publish-AzureVMDscConfiguration .\IISInstall.ps1 -ConfigurationArchivePath .\iisinstalllast.zip -Force