output "apim_resource_gateway_url" {
  value = azapi_resource.apim.output.properties.gatewayUrl
}

output "apim_subscription_key" {
  value     = azurerm_api_management_subscription.apim-api-subscription-openai.primary_key
  sensitive = true
}

output "function_app_name" {
  value = azurerm_linux_function_app.function.name
}

output "function_app_url" {
  value = azurerm_linux_function_app.function.default_hostname
}