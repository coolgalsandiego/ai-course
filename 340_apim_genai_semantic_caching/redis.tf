resource "azurerm_redis_cache" "redis" {
  name                 = "redis-${var.prefix}"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  capacity             = 1         # SKU family of C (Basic/Standard) are 0, 1, 2, 3, 4, 5, 6, and for P (Premium) family are 1, 2, 3, 4, 5.
  family               = "P"       # "C"        # C (for Basic/Standard SKU family) and P (for Premium)
  sku_name             = "Premium" # "Standard" # Basic, Standard and Premium.
  non_ssl_port_enabled = false
  minimum_tls_version  = "1.2"
  redis_version        = "6" # Possible values are 4 and 6

  redis_configuration {
    aof_backup_enabled = false
  }
}

# resource "azurerm_redis_enterprise_database" "redis-database" {
#   name              = "default"
#   cluster_id        = azurerm_redis_enterprise_cluster.example.id
#   client_protocol   = "Encrypted"
#   clustering_policy = "EnterpriseCluster"
#   eviction_policy   = "NoEviction"
#   port              = 10000

# #   linked_database_id = [
# #     "${azurerm_redis_enterprise_cluster.example.id}/databases/default",
# #     "${azurerm_redis_enterprise_cluster.example1.id}/databases/default"
# #   ]

# #   linked_database_group_nickname = "tftestGeoGroup"
# }
