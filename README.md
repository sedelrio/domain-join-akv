"# domain-join-akv" 



$template = "https://raw.githubusercontent.com/sedelrio/domain-join-akv/master/VM%20-%20Domain%20Join.KV.json"
$parameters = "https://raw.githubusercontent.com/sedelrio/domain-join-akv/master/domainjoinparamsKeyVault.json"

New-AzureRmResourceGroupDeployment -Name DomainJoin  -ResourceGroupName "testdomainjoin" -Templateuri $template -TemplateParameteruri $parameters

