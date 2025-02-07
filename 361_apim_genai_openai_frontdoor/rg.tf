resource "azurerm_resource_group" "rg" {
  name     = "rg-apim-genai-openai-${random_string.random.result}-${var.prefix}"
  location = "uksouth" # "westeurope" # azurerm_resource_group.rg.location # APIM SKU StandardV2 is not supported in the region Sweden Central
}