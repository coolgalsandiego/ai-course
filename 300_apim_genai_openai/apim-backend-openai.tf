resource "azurerm_api_management_backend" "apim-backend-openai" {
  name                = "apim-backend-openai"
  resource_group_name = azurerm_api_management.apim.resource_group_name
  api_management_name = azurerm_api_management.apim.name
  protocol            = "http"
  url                 = "${azurerm_ai_services.ai-services.endpoint}openai"
}

resource "azapi_resource" "apim-backend-pool-openai" {
  type                      = "Microsoft.ApiManagement/service/backends@2023-09-01-preview"
  name                      = "apim-backend-pool"
  parent_id                 = azurerm_api_management.apim.id
  schema_validation_enabled = false

  body = {
    properties = {
      type = "Pool"
      pool = {
        services = [
          {
            id = azurerm_api_management_backend.apim-backend-openai.id
          }
        ]
      }
    }
  }
}
