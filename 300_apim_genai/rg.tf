resource "azurerm_resource_group" "rg" {
  name     = "rg-apim-genai-${var.prefix}"
  location = "swedencentral"
}