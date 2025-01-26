resource "azurerm_api_management_subscription" "apim-api-subscription-openai-1" {
  display_name        = "apim-api-subscription-openai-1"
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_api_management.apim.resource_group_name
  api_id              = replace(azurerm_api_management_api.apim-api-openai.id, "/;rev=.*/", "")
  allow_tracing       = true
  state               = "active"
}

resource "azurerm_api_management_subscription" "apim-api-subscription-openai-2" {
  display_name        = "apim-api-subscription-openai-2"
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_api_management.apim.resource_group_name
  api_id              = replace(azurerm_api_management_api.apim-api-openai.id, "/;rev=.*/", "")
  allow_tracing       = true
  state               = "active"
}

resource "azurerm_api_management_subscription" "apim-api-subscription-openai-3" {
  display_name        = "apim-api-subscription-openai-3"
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_api_management.apim.resource_group_name
  api_id              = replace(azurerm_api_management_api.apim-api-openai.id, "/;rev=.*/", "")
  allow_tracing       = true
  state               = "active"
}
