resource "azurerm_cdn_frontdoor_profile" "frontdoor" {
  name                = "frontdoor-${var.prefix}"
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "Standard_AzureFrontDoor"
}

resource "azurerm_cdn_frontdoor_endpoint" "endpoint-apim" {
  name                     = "endpoint-apim"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor.id
}

resource "azurerm_cdn_frontdoor_origin_group" "origin-group-apim" {
  name                     = "origin-group-apim"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor.id
  session_affinity_enabled = true

  load_balancing {
    sample_size                 = 4
    successful_samples_required = 3
  }

  health_probe {
    path                = "/"
    request_type        = "GET"
    protocol            = "Http"
    interval_in_seconds = 60
  }
}

resource "azurerm_cdn_frontdoor_origin" "origin-apim" {
  name                           = "origin-apim"
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.origin-group-apim.id
  enabled                        = true
  host_name                      = replace(azapi_resource.apim.output.properties.gatewayUrl, "https://", "")
  http_port                      = 80
  https_port                     = 443
  origin_host_header             = replace(azapi_resource.apim.output.properties.gatewayUrl, "https://", "")
  priority                       = 1
  weight                         = 1000
  certificate_name_check_enabled = true
}

resource "azurerm_cdn_frontdoor_route" "route-apim" {
  name                          = "route-apim"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.endpoint-apim.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.origin-group-apim.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.origin-apim.id]
  supported_protocols           = ["Http", "Https"]
  patterns_to_match             = ["/*"]
  forwarding_protocol           = "HttpsOnly"
  link_to_default_domain        = true
  https_redirect_enabled        = false
  cdn_frontdoor_origin_path     = "/"
}
