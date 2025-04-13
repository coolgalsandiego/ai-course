# Azure API Management with OpenAI

![](images/architecture.png)

```sh
terraform init
terraform apply -auto-approve
```

## Important notes

Error message: Setting up Private Endpoint Connection for API Management service /subscriptions/dcef7009-6b94-4382-afdc-17eb160d709a/resourceGroups/rg-apim-genai-openai-baqam-361/providers/Microsoft.ApiManagement/service/apim-genai-prm-v2-baqam-361 which is of PremiumV2 is not supported yet.

Setting up 'Internal' Internal Virtual Network Type is not supported for Sku Type 'StandardV2'.

API Management service V2 outbound Virtual Network integration with SubnetId `/subscriptions/dcef7009-6b94-4382-afdc-17eb160d709a/resourceGroups/rg-apim-genai-openai-baqam-361/providers/Microsoft.Network/virtualNetworks/vnet-spoke/subnets/snet-apim` requires subnet to be delegated to Microsoft.Web/serverFarms. Please refer to https://aka.ms/apim-vnet-outbound for more details.

Error: expected private_link.0.target_type to be one of ["blob" "blob_secondary" "sites" "web"], got Gateway.

Blocking all public network access by setting property `publicNetworkAccess` of API Management service is not enabled during service creation.

Starting in July 2019, Azure AI services use custom subdomain names for each resource created through the Azure portal, Azure Cloud Shell, or Azure CLI. Unlike regional endpoints, which were common for all customers in a specific Azure region, custom subdomain names are unique to the resource. Custom subdomain names are required to enable features like Microsoft Entra ID for authentication.
Src: https://learn.microsoft.com/en-us/azure/ai-services/cognitive-services-custom-subdomains


