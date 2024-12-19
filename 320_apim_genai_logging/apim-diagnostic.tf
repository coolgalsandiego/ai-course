resource "azurerm_api_management_diagnostic" "apim-diagnostic" {
  identifier               = "applicationinsights" # "azuremonitor"
  resource_group_name      = azurerm_api_management.apim.resource_group_name
  api_management_name      = azurerm_api_management.apim.name
  api_management_logger_id = azurerm_api_management_logger.apim-logger.id

  sampling_percentage       = 100
  always_log_errors         = true
  log_client_ip             = true
  verbosity                 = "verbose"
  http_correlation_protocol = "W3C"

  frontend_request {
    body_bytes = 8192
    headers_to_log = [
      "Content-type",
      "accept",
      "origin",
      "User-agent",
      "x-ms-region",
      "x-ratelimit-remaining-tokens",
      "x-ratelimit-remaining-requests"
    ]
  }

  frontend_response {
    body_bytes = 8192
    headers_to_log = [
      "Content-type",
      "accept",
      "origin",
      "User-agent",
      "x-ms-region",
      "x-ratelimit-remaining-tokens",
      "x-ratelimit-remaining-requests"
    ]
  }

  backend_request {
    body_bytes = 8192
    headers_to_log = [
      "Content-type",
      "accept",
      "origin",
      "User-agent",
      "x-ms-region",
      "x-ratelimit-remaining-tokens",
      "x-ratelimit-remaining-requests"
    ]
  }

  backend_response {
    body_bytes = 8192
    headers_to_log = [
      "Content-type",
      "accept",
      "origin",
      "User-agent",
      "x-ms-region",
      "x-ratelimit-remaining-tokens",
      "x-ratelimit-remaining-requests"
    ]
  }
}

resource "azurerm_api_management_api_diagnostic" "apim-api-diagnostic" {
  identifier               = "applicationinsights" # "azuremonitor"
  resource_group_name      = azurerm_api_management.apim.resource_group_name
  api_management_name      = azurerm_api_management.apim.name
  api_management_logger_id = azurerm_api_management_logger.apim-logger.id
  api_name                 = azurerm_api_management_api.api-azure-openai.name

  sampling_percentage       = 100
  always_log_errors         = true
  log_client_ip             = true
  verbosity                 = "verbose"
  http_correlation_protocol = "W3C"


  frontend_request {
    body_bytes = 8192
    headers_to_log = [
      "Content-type",
      "accept",
      "origin",
      "User-agent",
      "x-ms-region",
      "x-ratelimit-remaining-tokens",
      "x-ratelimit-remaining-requests"
    ]
  }

  frontend_response {
    body_bytes = 8192
    headers_to_log = [
      "Content-type",
      "accept",
      "origin",
      "User-agent",
      "x-ms-region",
      "x-ratelimit-remaining-tokens",
      "x-ratelimit-remaining-requests"
    ]
  }

  backend_request {
    body_bytes = 8192
    headers_to_log = [
      "Content-type",
      "accept",
      "origin",
      "User-agent",
      "x-ms-region",
      "x-ratelimit-remaining-tokens",
      "x-ratelimit-remaining-requests"
    ]
  }

  backend_response {
    body_bytes = 8192
    headers_to_log = [
      "Content-type",
      "accept",
      "origin",
      "User-agent",
      "x-ms-region",
      "x-ratelimit-remaining-tokens",
      "x-ratelimit-remaining-requests"
    ]
  }
}

resource "azapi_update_resource" "enable-apim-api-diagnostic-metrics" {
  type        = "Microsoft.ApiManagement/service/apis/diagnostics@2023-09-01-preview"
  resource_id = azurerm_api_management_api_diagnostic.apim-api-diagnostic.id

  body = {
    properties = {
      metrics = true
    }
  }
}
