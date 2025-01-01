resource "azurerm_application_insights_workbook" "workbook" {
  name                = "85b3e8bb-fc93-40be-83f2-98f6bec18ba0"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  display_name        = "openai-usage-analysis-workbook"
  category            = "OpenAI"
  source_id           = lower(azurerm_application_insights.app-insights.id)

  data_json = file("openai-usage-analysis-workbook.json")
}
