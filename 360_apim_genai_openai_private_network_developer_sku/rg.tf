resource "azurerm_resource_group" "rg" {
  name     = "rg-apim-genai-openai-${var.prefix}"
  location = "westeurope" # azurerm_resource_group.rg.location # APIM SKU StandardV2 is not supported in the region Sweden Central
}