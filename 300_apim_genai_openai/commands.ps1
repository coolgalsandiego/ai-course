$RG = "rg-apim-genai-openai-001"
$location = "swedencentral"
$aiServiceName = "ai-genai-openai-001"
$apimName = "apim-genai-openai-001"

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
    --model-version "2024-08-06" `
    --model-format OpenAI `
    --sku-capacity "150" `
    --sku-name "GlobalStandard"

# create role assignment for API Management to access Azure AI Services
$apimIdentityPrincipalId = $(az apim show --name $apimName --resource-group $RG --query identity.principalId -o tsv)
$aiServicesResourceId = $(az cognitiveservices account show --name $aiServiceName --resource-group $RG --query id -o tsv)
az role assignment create --role "Cognitive Services OpenAI User" --assignee $apimIdentityPrincipalId --scope $aiServicesResourceId

# import OpenAPI specification for OpenAI to API Management

# Add authentication to the policy