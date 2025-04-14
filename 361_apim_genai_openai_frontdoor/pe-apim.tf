# # ERROR: Setting up Private Endpoint Connection for API Management service which is of PremiumV2 is not supported yet.
# resource "azurerm_private_endpoint" "pe-apim" {
#   name                = "pe-apim"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   subnet_id           = azurerm_subnet.snet-pe.id

#   private_service_connection {
#     name                           = "pe-connection"
#     private_connection_resource_id = azapi_resource.apim.id
#     subresource_names              = ["Gateway"]
#     is_manual_connection           = false
#   }

#   private_dns_zone_group {
#     name = "private-dns-zone-group"
#     private_dns_zone_ids = [
#       azurerm_private_dns_zone.privatelink-azure-api-net.id
#     ]
#   }
# }
