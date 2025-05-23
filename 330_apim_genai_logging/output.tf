output "apim_resource_gateway_url" {
  value = azurerm_api_management.apim.gateway_url
}

output "app_insights_app_id" {
  value = azurerm_application_insights.app-insights.app_id
}

output "apim_subscription_key_1" {
  value     = azurerm_api_management_subscription.apim-api-subscription-openai-1.primary_key
  sensitive = true
}

output "apim_subscription_key_2" {
  value     = azurerm_api_management_subscription.apim-api-subscription-openai-2.primary_key
  sensitive = true
}

output "apim_subscription_key_3" {
  value     = azurerm_api_management_subscription.apim-api-subscription-openai-3.primary_key
  sensitive = true
}

output "app_insights_resource_name" {
  value = azurerm_application_insights.app-insights.name
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}