#New-AzureRmResourceGroupDeployment -Name TestingDeploy  -ResourceGroupName "testdomainjoin" -TemplateFile C:\Users\sebastid\Documents\Documentation\Templates\Domain Join\VM - Domain Join.json" -TemplateParameterFile C:\Users\sebastid\Documents\Documentation\Templates\Domain Join\domainjoinparameters.json"


#Login to Azure
Login-AzureRmAccount

#create Azure Key Vault
$vaultname = "KV-Name"   # Modify to match name of Key Vault
$password = "Passw0rd23456"

New-AzureRmKeyVault -VaultName $vaultname -ResourceGroupName security-sebastid -Location "eastus" -EnabledForTemplateDeployment
$secretvalue = ConvertTo-SecureString $password -AsPlainText -Force
Set-AzureKeyVaultSecret -VaultName $vaultname -Name "examplesecret" -SecretValue $secretvalue



# Using Azure Key Vault
$template = "C:\Users\sebastid\Documents\Documentation\Templates\Domain Join\VM - Domain Join.KV.json"
$parameters = "C:\Users\sebastid\Documents\Documentation\Templates\Domain Join\domainjoinparamsKeyVault.json"


$template = "C:\Users\sebastid\Documents\Documentation\Templates\Domain Join Azure Key Vault\VM - Domain Join.KV.json"
$parameters = "C:\Users\sebastid\Documents\Documentation\Templates\Domain Join Azure Key Vault\domainjoinparamsKeyVault.json"

$template = "https://raw.githubusercontent.com/sedelrio/domain-join-akv/master/VM%20-%20Domain%20Join.KV.json"
$parameters = "https://raw.githubusercontent.com/sedelrio/domain-join-akv/master/domainjoinparamsKeyVault.json"
New-AzureRmResourceGroupDeployment -Name DomainJoin  -ResourceGroupName "testdomainjoin" -Templateuri $template -TemplateParameteruri $parameters



# Create MOF File
Publish-AzureVMDscConfiguration .\iisinstall.ps1 -ConfigurationArchivePath .\iisinstall.zip -Force
Publish-AzureVMDscConfiguration .\IISInstall.ps1 -ConfigurationArchivePath .\iisinstalllast.zip -Force