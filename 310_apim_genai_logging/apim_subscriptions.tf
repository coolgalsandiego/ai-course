resource "azurerm_api_management_subscription" "apim-subscription-1" {
  display_name        = "Subscription-1"
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_api_management.apim.resource_group_name
  api_id              = azurerm_api_management_api.api-azure-openai.id
  allow_tracing       = true
}

resource "azurerm_api_management_subscription" "apim-subscription-2" {
  display_name        = "Subscription-2"
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_api_management.apim.resource_group_name
  api_id              = azurerm_api_management_api.api-azure-openai.id
  allow_tracing       = true
}

resource "azurerm_api_management_subscription" "apim-subscription-3" {
  display_name        = "Subscription-3"
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_api_management.apim.resource_group_name
  api_id              = azurerm_api_management_api.api-azure-openai.id
  allow_tracing       = true
}
