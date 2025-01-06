output "apim_resource_gateway_url" {
  value = azapi_resource.apim.output.properties.gatewayUrl
}

output "apim_subscription_key" {
  value     = azurerm_api_management_subscription.apim-api-subscription-openai.primary_key
  sensitive = true
}

output "aca_redis_url" {
  value = "${azurerm_container_app.aca-redis-stack.name}.${azurerm_container_app_environment.aca-env.default_domain}"
}