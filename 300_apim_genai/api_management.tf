resource "azurerm_public_ip" "pip-apim" {
  name                = "pip-apim"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"] # ["1", "2", "3"]
  domain_name_label   = "apim-external-${random_string.random.result}-${var.prefix}"
}

resource "azurerm_api_management" "apim" {
  name                          = "apim-external-${random_string.random.result}-${var.prefix}"
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  publisher_name                = "My Company"
  publisher_email               = "houssem.dellai@live.com"
  sku_name                      = "Developer_1"
  virtual_network_type          = "External" # None, External, Internal
  public_ip_address_id          = azurerm_public_ip.pip-apim.id
  public_network_access_enabled = true # false applies only when using private endpoint as the exclusive access method

  identity {
    type = "SystemAssigned"
  }

  virtual_network_configuration {
    subnet_id = azurerm_subnet.snet-apim.id
  }

  depends_on = [azurerm_subnet_network_security_group_association.nsg-association]
}

resource "azurerm_role_assignment" "Cognitive-Services-OpenAI-User" {
  for_each = var.openAIConfig

  scope                = azurerm_cognitive_account.openai[each.key].id
  role_definition_name = "Cognitive Services OpenAI User"
  principal_id         = azurerm_api_management.apim.identity.0.principal_id
}