resource "azurerm_ai_services" "ai-services" {
  name                               = "ai-services"
  location                           = azurerm_resource_group.rg.location
  resource_group_name                = azurerm_resource_group.rg.name
  sku_name                           = "S0"
  local_authentication_enabled       = true
  public_network_access              = "Enabled"
  outbound_network_access_restricted = false
  #   custom_subdomain_name = ""
  #   fqdns = 

  identity {
    type = "SystemAssigned"
  }

  #   network_acls {
  #     default_action = "Allow"
  #     ip_rules       = []
  #     virtual_network_rules {
  #       subnet_id                            = azurerm_subnet.snet-apim.id
  #       ignore_missing_vnet_service_endpoint = false
  #     }
  #   }

  #   storage {
  #     storage_account_id
  #     identity_client_id 
  #   }
}

resource "azurerm_cognitive_account" "openai" {
  for_each = var.openAIConfig

  name                               = each.value.name
  location                           = each.value.location
  resource_group_name                = azurerm_resource_group.rg.name
  kind                               = "OpenAI"
  sku_name                           = "S0"
  public_network_access_enabled      = true
  outbound_network_access_restricted = false
  custom_subdomain_name              = "${lower(each.value.name)}-${random_string.random.result}"
}

# resource "azurerm_cognitive_account" "azure-openai-swc" {
#   name                               = "azure-openai-swc"
#   location                           = "swedencentral"
#   resource_group_name                = azurerm_resource_group.rg.name
#   kind                               = "OpenAI"
#   sku_name                           = "S0"
#   public_network_access_enabled      = true
#   outbound_network_access_restricted = false
# #   custom_subdomain_name = ""
# }

# resource "azurerm_cognitive_account" "azure-openai-frc" {
#   name                               = "azure-openai-frc"
#   location                           = "francecentral"
#   resource_group_name                = azurerm_resource_group.rg.name
#   kind                               = "OpenAI"
#   sku_name                           = "S0"
#   public_network_access_enabled      = true
#   outbound_network_access_restricted = false
# #   custom_subdomain_name = ""
# }

# resource "azurerm_cognitive_account" "azure-openai-uks" {
#   name                               = "azure-openai-uks"
#   location                           = "uksouth"
#   resource_group_name                = azurerm_resource_group.rg.name
#   kind                               = "OpenAI"
#   sku_name                           = "S0"
#   public_network_access_enabled      = true
#   outbound_network_access_restricted = false
# #   custom_subdomain_name = ""
# }

resource "azurerm_cognitive_deployment" "gpt-4o" {
  for_each = var.openAIConfig

  name                 = each.value.name
  cognitive_account_id = azurerm_cognitive_account.openai[each.key].id

  sku {
    name = "GlobalStandard" # "Standard" # DataZoneStandard, GlobalBatch, GlobalStandard and ProvisionedManaged
    # tier = Free, Basic, Standard, Premium, Enterprise
    # size = ""
    # family = ""
    # capacity = 0
  }

  model {
    format  = "OpenAI"
    name    = "gpt-4o"
    version = "2024-08-06" # "2024-05-13"
  }
}

# resource "azurerm_cognitive_deployment" "gpt-4o-swc" {
#   name                 = "gpt-4o"
#   cognitive_account_id = azurerm_cognitive_account.azure-openai-swc.id

#   sku {
#     name = "Standard" # DataZoneStandard, GlobalBatch, GlobalStandard and ProvisionedManaged
#     # tier = Free, Basic, Standard, Premium, Enterprise
#     # size = ""
#     # family = ""
#     # capacity = 0
#   }

#   model {
#     format  = "OpenAI"
#     name    = "gpt-4o"
#     version = "2024-08-06" # "2024-05-13"
#   }
# }

# resource "azurerm_cognitive_deployment" "gpt-4o-frc" {
#   name                 = "gpt-4o"
#   cognitive_account_id = azurerm_cognitive_account.azure-openai-frc.id

#   sku {
#     name = "GlobalStandard" # "Standard" # DataZoneStandard, GlobalBatch, GlobalStandard and ProvisionedManaged
#     # tier = Free, Basic, Standard, Premium, Enterprise
#     # size = ""
#     # family = ""
#     # capacity = 0
#   }

#   model {
#     format  = "OpenAI"
#     name    = "gpt-4o"
#     version = "2024-08-06" # "2024-05-13"
#   }
# }

# resource "azurerm_cognitive_deployment" "gpt-4o-uks" {
#   name                 = "gpt-4o"
#   cognitive_account_id = azurerm_cognitive_account.azure-openai-uks.id

#   sku {
#     name = "GlobalStandard" # "Standard" # DataZoneStandard, GlobalBatch, GlobalStandard and ProvisionedManaged
#     # tier = Free, Basic, Standard, Premium, Enterprise
#     # size = ""
#     # family = ""
#     # capacity = 0
#   }

#   model {
#     format  = "OpenAI"
#     name    = "gpt-4o"
#     version = "2024-08-06" # "2024-05-13"
#   }
# }

# resource "azurerm_cognitive_deployment" "text-embedding-3-large" {
#   name                 = "text-embedding-3-large"
#   cognitive_account_id = azurerm_cognitive_account.cognitive-account.id

#   sku {
#     name = "Standard" # DataZoneStandard, GlobalBatch, GlobalStandard and ProvisionedManaged
#     # tier = Free, Basic, Standard, Premium, Enterprise
#     # size = ""
#     # family = ""
#     # capacity = 0
#   }

#   model {
#     format  = "OpenAI"
#     name    = "text-embedding-3-large"
#     version = "1"
#   }
# }


# import {
#     id = "/subscriptions/dcef7009-6b94-4382-afdc-17eb160d709a/resourceGroups/rg-lab-apim-genai-backend-pool-load-balancing/providers/Microsoft.ApiManagement/service/apim-3t7q6ame6pmrs"
#     to = azurerm_api_management.main
# }

# import {
#     id = "/subscriptions/dcef7009-6b94-4382-afdc-17eb160d709a/resourceGroups/rg-lab-apim-genai-backend-pool-load-balancing/providers/Microsoft.ApiManagement/service/apim-3t7q6ame6pmrs/apis/openai"
#     to = azurerm_api_management_api.api-openai
# }
