resource "azurerm_api_management_api" "api-azure-openai" {
  name                  = "api-azure-openai"
  resource_group_name   = azurerm_api_management.apim.resource_group_name
  api_management_name   = azurerm_api_management.apim.name
  revision              = "1"
  description           = "Azure OpenAI APIs for completions and search"
  display_name          = "OpenAI"
  path                  = "openai"
  protocols             = ["https"]
  service_url           = null # "https://${azurerm_linux_function_app.function-linux-container.default_hostname}/api"
  subscription_required = false
  api_type              = "http"

  import {
    content_format = "openapi-link"
    content_value  = "https://raw.githubusercontent.com/Azure/azure-rest-api-specs/main/specification/cognitiveservices/data-plane/AzureOpenAI/inference/stable/2024-02-01/inference.json"
  }

  # subscription_key_parameter_names {
  #   header = "api-key"
  #   query  = "api-key"
  # }
}

resource "azurerm_api_management_backend" "openai" {
  for_each = var.openAIConfig

  name                = each.value.name
  resource_group_name = azurerm_api_management.apim.resource_group_name
  api_management_name = azurerm_api_management.apim.name
  protocol            = "http"
  url                 = "${azurerm_cognitive_account.openai[each.key].endpoint}openai"
}

resource "azapi_update_resource" "circuit-breaker" {
  for_each = var.openAIConfig

  type        = "Microsoft.ApiManagement/service/backends@2024-06-01-preview"
  resource_id = azurerm_api_management_backend.openai[each.key].id

  body = {
    properties = {
      circuitBreaker = {
        rules = [
          {
            failureCondition = {
              count = 1
              errorReasons = [
                "Server errors"
              ]
              interval = "PT5M"
              statusCodeRanges = [
                {
                  min = 429
                  max = 429
                }
              ]
            }
            name             = "openAIBreakerRule"
            tripDuration     = "PT1M"
            acceptRetryAfter = true // respects the Retry-After header
          }
        ]
      }
    }
  }
}

resource "azapi_resource" "backend-pool" {
  type                      = "Microsoft.ApiManagement/service/backends@2024-06-01-preview"
  name                      = "backend-pool"
  parent_id                 = azurerm_api_management.apim.id
  schema_validation_enabled = false

  body = {
    properties = {
      type = "Pool"
      pool = {
        services = [
          for k, v in var.openAIConfig :
          {
            id       = "/backends/${azurerm_api_management_backend.openai[k].name}"
            priority = v.priority
            weight   = v.weight
          }
        ]
      }
    }
  }
}

resource "azurerm_api_management_api_policy" "policy" {
  api_name            = azurerm_api_management_api.api-azure-openai.name
  api_management_name = azurerm_api_management_api.api-azure-openai.api_management_name
  resource_group_name = azurerm_api_management_api.api-azure-openai.resource_group_name

  xml_content = file("policy.xml")

  depends_on = [azurerm_api_management_backend.openai]
}

resource "azurerm_api_management_subscription" "openai-subscription" {
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = azurerm_api_management.apim.resource_group_name
  display_name        = "openai-subscription"
  api_id              = azurerm_api_management_api.api-azure-openai.id
  allow_tracing       = true
  state               = "active"
}

# resource "azurerm_api_management_api_operation" "operation-azure-function-get" {
#   operation_id        = "api-demo-get"
#   api_name            = azurerm_api_management_api.api-azure-function.name
#   api_management_name = azurerm_api_management_api.api-azure-function.api_management_name
#   resource_group_name = azurerm_api_management_api.api-azure-function.resource_group_name
#   display_name        = "Demo API GET"
#   method              = "GET"
#   url_template        = "/"
#   description         = "GET returns sample JSON file."
# }
