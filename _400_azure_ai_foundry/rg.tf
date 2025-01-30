resource "azurerm_resource_group" "rg" {
  name     = "rg-ai-foundry-eus-${random_string.random.result}-${var.prefix}"
  location = "eastus" # "swedencentral"
}