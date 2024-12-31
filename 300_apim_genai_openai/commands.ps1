$RG = "rg-apim-genai-openai-0019"
$location = "swedencentral"
$aiServiceName = "ai-genai-openai-0019"
$apimName = "apim-genai-openai-0019"

# create Azure resource group
az group create --name $RG --location $location

# create API Management with Comsumption mode
az apim create --name $apimName --resource-group $RG --location $location --sku-name Consumption --publisher-email "noreply@microsoft.com" --publisher-name "Microsoft" --enable-managed-identity

# create Azure AI services
az cognitiveservices account create -n $aiServiceName -g $RG --kind AIServices --sku S0 --location $location --custom-domain $aiServiceName

# create deployment for ChatGPT 4o model
az cognitiveservices account deployment create -n $aiServiceName -g $RG `
    --deployment-name gpt-4o `
    --model-name gpt-4o `
    --model-version "2024-11-20" `
    --model-format OpenAI `
    --sku-capacity "150" `
    --sku-name "GlobalStandard"

# create role assignment for API Management to access Azure AI Services
$apimIdentityPrincipalId = $(az apim show --name $apimName --resource-group $RG --query identity.principalId -o tsv)
$aiServicesResourceId = $(az cognitiveservices account show --name $aiServiceName --resource-group $RG --query id -o tsv)
az role assignment create --role "Cognitive Services OpenAI User" --assignee $apimIdentityPrincipalId --scope $aiServicesResourceId

# import OpenAPI specification for OpenAI to API Management
$aiServiceUrl = $(az cognitiveservices account show -n $aiServiceName -g $RG --query properties.endpoint -o tsv)
az apim api import --service-name $apimName -g $RG `
                   --display-name "OpenAI" `
                   --path openai `
                   --specification-url "https://raw.githubusercontent.com/Azure/azure-rest-api-specs/refs/heads/main/specification/cognitiveservices/data-plane/AzureOpenAI/inference/stable/2024-10-21/inference.json" `
                   --specification-format OpenApiJson `
                   --api-type http `
                   --protocols "https" `
                   --service-url ${aiServiceUrl}openai `
                   --subscription-required true `
                   --subscription-key-header-name "api-key" `
                   --subscription-key-query-param-name "api-key"

# create subscription for API Management
# Not supported in Azure CLI, use Azure Portal or ARM template

# Add authentication to the policy
# Not supported in Azure CLI, use Azure Portal or ARM template
# Use the policy in file policy.xml

# test the API: chatting with Chat GPT 4o model
