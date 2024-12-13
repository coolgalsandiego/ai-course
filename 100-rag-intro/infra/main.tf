# https://github.com/Azure/terraform/blob/master/quickstart/101-ai-studio/main.tf

resource "azurerm_resource_group" "rg" {
  name     = "rg-openai-tf"
  location = "swedencentral"
}

resource "azurerm_ai_services" "ai-services" {
  name                = "ai-services"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "S0"
}

resource "azurerm_cognitive_account" "cognitive-account" {
  name                = "azure-openai-swc"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "OpenAI"
  sku_name            = "S0"
}

resource "azurerm_cognitive_deployment" "text-embedding-3-large" {
  name                 = "text-embedding-3-large"
  cognitive_account_id = azurerm_cognitive_account.cognitive-account.id

  model {
    format  = "OpenAI"
    name    = "text-embedding-3-large"
    version = "1"
  }

  scale {
    type = "Standard"
  }
}

resource "azurerm_cognitive_deployment" "gpt-4o" {
  name                 = "gpt-4o"
  cognitive_account_id = azurerm_cognitive_account.cognitive-account.id
  
  model {
    format  = "OpenAI"
    name    = "gpt-4o"
    version = "2024-05-13"
  }

  scale {
    type = "Standard"
  }
}

# resource "azapi_resource" "this" {
#   type     = "Microsoft.MachineLearningServices/workspaces@2023-02-01-preview"
#   name     = var.machine_learning_workspace_name
#   location = var.location
#   identity {
#     type = "SystemAssigned"
#   }
#   parent_id                 = var.resource_group_id
#   schema_validation_enabled = false # requiered for now
#   body = jsonencode({
#     properties = {
#       kind                = "Hub"
#       friendlyName        = var.machine_learning_workspace_name
#       keyVault            = var.key_vault_id
#       applicationInsights = var.appi_id
#       containerRegistry   = var.acr_id
#       storageAccount      = var.storage_account_id
#       managedNetwork = {
#         isolationMode = "Disabled"
#       }
#       workspaceHubConfig = {
#         defaultWorkspaceResourceGroup = var.resource_group_id
#       }
#       publicNetworkAccess = "Enabled"
#     }
#   })
# }


# https://github.com/Azure-Samples/azuresandbox/blob/main/extras/terraform-azurerm-aistudio/020-aistudio.tf