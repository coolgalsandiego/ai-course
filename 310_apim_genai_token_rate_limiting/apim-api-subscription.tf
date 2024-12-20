resource "azurerm_api_management_subscription" "apim-api-subscription" {
  display_name        = "apim-api-subscription"
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_api_management.apim.resource_group_name
  api_id              = azurerm_api_management_api.apim-api-openai.id
  allow_tracing       = true
  state               = "active"
}