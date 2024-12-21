resource "azurerm_api_management_api_policy" "apim-openai-policy-openai" {
  api_name            = azurerm_api_management_api.apim-api-openai.name
  api_management_name = azurerm_api_management_api.apim-api-openai.api_management_name
  resource_group_name = azurerm_api_management_api.apim-api-openai.resource_group_name

  # xml_content = replace(file("policy.xml"), "{backend-id}", azurerm_api_management_backend.apim-backend-openai.name)
  xml_content = file("policy.xml")
  # xml_content = replace(file("policy.xml"), "{backend-id}", azapi_resource.apim-backend-pool-openai.name)
}
