resource "azurerm_api_management_logger" "apim-logger" {
  name                = "apim-logger"
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_api_management.apim.resource_group_name

  application_insights {
    instrumentation_key = azurerm_application_insights.app-insights.instrumentation_key
  }
}