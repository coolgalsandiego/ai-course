# https://github.com/Azure/terraform/blob/master/quickstart/101-ai-studio/main.tf

variable "prefix" {
  type    = string
  default = "0013"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-openai-tf"
  location = "swedencentral"
}

resource "azurerm_ai_services" "ai-services" {
  name                               = "ai-services"
  location                           = azurerm_resource_group.rg.location
  resource_group_name                = azurerm_resource_group.rg.name
  sku_name                           = "S0"
  local_authentication_enabled       = true
  public_network_access              = "Enabled"
  outbound_network_access_restricted = false
  # custom_subdomain_name              = "${lower(each.value.name)}-${var.prefix}"
}

# resource "azurerm_cognitive_account" "cognitive-account" {
#   name                = "azure-openai-swc"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   kind                = "OpenAI"
#   sku_name            = "S0"
# }

resource "azurerm_cognitive_deployment" "gpt-4o" {
  name                 = "gpt-4o"
  cognitive_account_id = azurerm_ai_services.ai-services.id

  sku {
    name     = "GlobalStandard" # "Standard" # DataZoneStandard, GlobalBatch, GlobalStandard and ProvisionedManaged
    capacity = 8                # (8k tokens per minute) to showcase the retry logic in the load balancer
    # tier = Free, Basic, Standard, Premium, Enterprise
    # size = ""
    # family = ""
  }

  model {
    format  = "OpenAI"
    name    = "gpt-4o"
    version = "2024-08-06"
  }
}

resource "azurerm_cognitive_deployment" "text-embedding-3-large" {
  name                 = "text-embedding-3-large"
  cognitive_account_id = azurerm_ai_services.ai-services.id

  model {
    format  = "OpenAI"
    name    = "text-embedding-3-large"
    version = "1"
  }

  sku {
    name     = "Standard" # "Standard" # DataZoneStandard, GlobalBatch, GlobalStandard and ProvisionedManaged
    capacity = 8          # (8k tokens per minute) to showcase the retry logic in the load balancer
    # tier = Free, Basic, Standard, Premium, Enterprise
    # size = ""
    # family = ""
  }
}

resource "azurerm_search_service" "search-service" {
  name                          = "search-service-${var.prefix}"
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  sku                           = "free"
  public_network_access_enabled = false

  identity {
    type = "SystemAssigned"
  }
}

resource "azapi_resource" "ai-hub" {
  type      = "Microsoft.MachineLearningServices/workspaces@2024-07-01-preview"
  name      = "ai-hub"
  location  = azurerm_resource_group.rg.location
  parent_id = azurerm_resource_group.rg.id

  identity {
    type = "SystemAssigned"
  }

  body = {
    kind = "hub"
    properties = {
      description    = "This is my Azure AI hub"
      friendlyName   = "My Hub"
      publicNetworkAccess = "Enabled"
      # managedNetwork = {
      #   isolationMode = "Disabled"
      # }
      # storageAccount = azurerm_storage_account.default.id
      # keyVault       = azurerm_key_vault.default.id
      # applicationInsights = azurerm_application_insights.default.id
      # containerRegistry = azurerm_container_registry.default.id
    }
  }
}

# resource "azurerm_machine_learning_workspace" "ml-workspace" {
#   name                    = "ml-workspace-${var.prefix}"
#   location                = azurerm_resource_group.rg.location
#   resource_group_name     = azurerm_resource_group.rg.name
#   application_insights_id = null
#   key_vault_id            = null
#   storage_account_id      = null
#   kind                    = "hub"

#   identity {
#     type = "SystemAssigned"
#   }
# }

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
