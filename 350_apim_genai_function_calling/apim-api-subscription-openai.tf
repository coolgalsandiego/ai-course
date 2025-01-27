resource "azurerm_api_management_subscription" "apim-api-subscription-openai" {
  display_name        = "apim-api-subscription-openai"
  api_management_name = azapi_resource.apim.name
  resource_group_name = azurerm_resource_group.rg.name # azurerm_api_management.apim.resource_group_name
  # api_id              = "" # "/apis" # replace(azurerm_api_management_api.apim-api-openai.id, "/;rev=.*/", "") # If both are missing /apis scope is used for the subscription and all apis are accessible.
  allow_tracing       = true
  state               = "active"
}