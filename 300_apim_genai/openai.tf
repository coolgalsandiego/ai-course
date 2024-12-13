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

resource "azurerm_cognitive_deployment" "gpt-4o" {
  for_each = var.openAIConfig

  name                 = "gpt-4o" # each.value.name
  cognitive_account_id = azurerm_cognitive_account.openai[each.key].id

  sku {
    name     = "GlobalStandard" # "Standard" # DataZoneStandard, GlobalBatch, GlobalStandard and ProvisionedManaged
    capacity = 20
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
