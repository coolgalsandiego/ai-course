# resource "azurerm_api_management_backend" "apim-backend-openai" {
#   name                = "apim-backend-openai"
#   resource_group_name = azurerm_api_management.apim.resource_group_name
#   api_management_name = azurerm_api_management.apim.name
#   protocol            = "http"
#   url                 = "${azurerm_ai_services.ai-services.endpoint}openai"
# }