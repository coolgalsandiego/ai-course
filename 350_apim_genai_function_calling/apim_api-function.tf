resource "azurerm_api_management_api" "apim-api-function" {
  name                  = "apim-api-function"
  resource_group_name   = azurerm_resource_group.rg.name
  api_management_name   = azapi_resource.apim.name
  revision              = "1"
  display_name          = "API Function"
  path                  = "weather"
  api_type              = "http" # graphql, http, soap, and websocket
  protocols             = ["https"]
  service_url           = "https://${azurerm_linux_function_app.function.default_hostname}/api/weather"
  subscription_required = true

  import {
    content_format = "openapi+json"
    content_value  = file("weather.json")
  }

  subscription_key_parameter_names {
    header = "api-key"
    query  = "api-key"
  }
}