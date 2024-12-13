output "apim_gateway_url" {
  value = azurerm_api_management.apim.gateway_url
}

output "apim_subscription_key" {
  value     = azurerm_api_management_subscription.openai-subscription.primary_key
  sensitive = true
}