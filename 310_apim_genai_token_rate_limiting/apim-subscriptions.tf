resource "azurerm_api_management_subscription" "apim-subscription" {
  display_name        = "APIM-Subscription"
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_api_management.apim.resource_group_name
  api_id              = azurerm_api_management_api.api-azure-openai.id
  allow_tracing       = true
  state               = "active"
}