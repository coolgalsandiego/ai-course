resource "random_string" "random" {
  length  = 5
  special = false
  lower   = true
  upper   = false
}

resource "azurerm_storage_account" "sa" {
  name                     = "storfunc${random_string.random.result}${var.prefix}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "plan" {
  name                = "plan-functions"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_function_app" "function" {
  name                        = "function-${random_string.random.result}-${var.prefix}"
  resource_group_name         = azurerm_resource_group.rg.name
  location                    = azurerm_resource_group.rg.location
  service_plan_id             = azurerm_service_plan.plan.id
  https_only                  = true
  storage_account_name        = azurerm_storage_account.sa.name
  storage_account_access_key  = azurerm_storage_account.sa.primary_access_key
  functions_extension_version = "~4"

  site_config {
    always_on = true
    application_stack {
      python_version = "3.11"
    }
  }
}
