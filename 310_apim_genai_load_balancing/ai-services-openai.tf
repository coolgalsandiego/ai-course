resource "azurerm_ai_services" "ai-services" {
  for_each = var.openai_config

  name                               = each.value.name
  location                           = each.value.location
  resource_group_name                = azurerm_resource_group.rg.name
  sku_name                           = "S0"
  local_authentication_enabled       = true
  public_network_access              = "Enabled"
  outbound_network_access_restricted = false
  custom_subdomain_name              = "${lower(each.value.name)}-${var.prefix}"
}

resource "azurerm_cognitive_deployment" "gpt-4o" {
  for_each = var.openai_config

  name                 = "gpt-4o"                                     # each.value.name
  cognitive_account_id = azurerm_ai_services.ai-services[each.key].id # azurerm_cognitive_account.openai[each.key].id

  sku {
    name     = "GlobalStandard" # "Standard" # DataZoneStandard, GlobalBatch, GlobalStandard and ProvisionedManaged
    capacity = 8 # (8k tokens per minute) to showcase the retry logic in the load balancer
  }

  model {
    format  = "OpenAI"
    name    = "gpt-4o"
    version = "2024-08-06"
  }
}