resource "azurerm_api_management_api" "apim-api-function" {
  name                  = "apim-api-function"
  resource_group_name   = azurerm_resource_group.rg.name
  api_management_name   = azapi_resource.apim.name
  revision              = "1"
  display_name          = "API Function"
  path                  = "api"
  api_type              = "http" # graphql, http, soap, and websocket
  protocols             = ["http", "https"]
  service_url           = "https://${azurerm_linux_function_app.function.default_hostname}/api"
  subscription_required = false
}

resource "azurerm_api_management_api_operation" "operation-azure-function-get" {
  operation_id        = "api-demo-get"
  api_name            = azurerm_api_management_api.apim-api-function.name
  api_management_name = azurerm_api_management_api.apim-api-function.api_management_name
  resource_group_name = azurerm_api_management_api.apim-api-function.resource_group_name
  display_name        = "Demo API GET"
  method              = "GET"
  url_template        = "/"
  description         = "GET returns sample JSON file."
}