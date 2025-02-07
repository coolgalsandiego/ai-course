resource "azurerm_private_dns_zone" "privatelink-azure-api-net" {
  name                = "privatelink.azure-api.net"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink-azure-api-net" {
  name                  = "privatelink-azure-api-net"
  resource_group_name   = azurerm_private_dns_zone.privatelink-azure-api-net.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink-azure-api-net.name
  virtual_network_id    = azurerm_virtual_network.vnet-spoke.id
}
