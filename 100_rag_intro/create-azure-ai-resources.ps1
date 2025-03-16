# Introduction to RAG with Azure OpenAI

## Create Azure AI Search resource

$rgName = "rg-azure-openai-rag-pprod-0017"
$aiSearchName = "ai-search-rag-pprod-0017"
$aiServiceName = "ai-services-rag-pprod-0017" # must be unique
$location = "swedencentral"
$llmDeploymentName = "gpt-4o"
$llmModelVersion = "2024-08-06"
$embeddingModelName = "text-embedding-3-large"

### 1. Create a resource group

az group create -n $rgName -l $location

### 2. Create a search service

az search service create -n $aiSearchName -g $rgName --sku free

## Create an Azure AI Services resource

az cognitiveservices account create -n $aiServiceName -g $rgName --kind AIServices --sku S0 --location $location  --custom-domain $aiServiceName

## Creating deployment for ChatGPT 4o model

az cognitiveservices account deployment create -n $aiServiceName -g $rgName `
    --deployment-name $llmDeploymentName `
    --model-name $llmDeploymentName `
    --model-version $llmModelVersion `
    --model-format OpenAI `
    --sku-capacity "150" `
    --sku-name "GlobalStandard"

## Creating an embedding model deployment

az cognitiveservices account deployment create -n $aiServiceName -g $rgName `
    --deployment-name $embeddingModelName `
    --model-name $embeddingModelName `
    --model-version "1" `
    --model-format OpenAI `
    --sku-capacity "120" `
    --sku-name "Standard"

## Create a Hub and Project

### Create a Hub

az ml workspace create --kind hub -g $rgName -n hub-demo

### Create a Project

$hubId=$(az ml workspace show -g $rgName -n hub-demo --query id -o tsv)

az ml workspace create --kind project --hub-id $hubId -g $rgName -n project-demo

# View the connection details

az cognitiveservices account show -n $aiServiceName -g $rgName --query properties.endpoint
az cognitiveservices account keys list -n $aiServiceName -g $rgName
az cognitiveservices account show -n $aiServiceName -g $rgName --query id

## Create a connection.yml file to connect AI Services to the Hub

$endpoint=$(az cognitiveservices account show -n $aiServiceName -g $rgName --query properties.endpoint)
$api_key=$(az cognitiveservices account keys list -n $aiServiceName -g $rgName --query key1)
$ai_services_resource_id=$(az cognitiveservices account show -n $aiServiceName -g $rgName --query id)

@"
name: ai-service-connection
type: azure_ai_services
endpoint: $endpoint
api_key: $api_key
ai_services_resource_id: $ai_services_resource_id
"@ > connection.yml

az ml connection create --file connection.yml -g $rgName --workspace-name hub-demo

# create the .env file for the python code

@"
AZURE_OPENAI_ENDPOINT=$endpoint
AZURE_OPENAI_API_KEY=$api_key
AZURE_OPENAI_CHAT_COMPLETIONS_DEPLOYMENT_NAME="$llmDeploymentName"

AZURE_OPENAI_EMBEDDING_MODEL=$embeddingModelName
EMBEDDING_VECTOR_DIMENSIONS=3072

AZURE_SEARCH_SERVICE_ENDPOINT=https://$aiSearchName.search.windows.net
AZURE_SEARCH_SERVICE_ADMIN_KEY=$(az search admin-key show -g $rgName --service-name $aiSearchName --query primaryKey -o tsv)
SEARCH_INDEX_NAME=index-doc
"@ > .env