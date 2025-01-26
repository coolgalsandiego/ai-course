resource "azurerm_resource_group" "rg" {
  name     = "rg-apim-genai-openai-${var.prefix}"
  location = "francecentral" # "swedencentral"
}