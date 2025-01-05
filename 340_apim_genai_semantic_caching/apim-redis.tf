resource "azurerm_api_management_redis_cache" "apim-redis" {
  name              = "apim-redis"
  api_management_id = azurerm_api_management.apim.id
  connection_string = azurerm_redis_cache.redis.primary_connection_string
  description       = "Redis cache instances"
  redis_cache_id    = azurerm_redis_cache.redis.id
  cache_location    = azurerm_resource_group.rg.location
}