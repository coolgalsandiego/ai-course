# Applications with external TCP ingress can only be deployed to Container App Environments that have a custom VNET.
# Set ingress traffic to 'Limited to Container Apps Environment' if you want 
# to deploy to a Container App Environment without a custom VNET.

resource "azurerm_virtual_network" "vnet-aca" {
  name                = "vnet-aca"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "snet-aca" {
  name                 = "snet-aca"
  resource_group_name  = azurerm_virtual_network.vnet-aca.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-aca.name
  address_prefixes     = ["10.0.0.0/23"]
}

resource "azurerm_container_app_environment" "aca-env" {
  name                           = "aca-environment-${var.prefix}"
  location                       = azurerm_resource_group.rg.location
  resource_group_name            = azurerm_resource_group.rg.name
  log_analytics_workspace_id     = null
  zone_redundancy_enabled        = false
  internal_load_balancer_enabled = false
  infrastructure_subnet_id       = azurerm_subnet.snet-aca.id
}

resource "azurerm_container_app" "aca-redis-stack" {
  name                         = "aca-redis-stack"
  container_app_environment_id = azurerm_container_app_environment.aca-env.id
  resource_group_name          = azurerm_resource_group.rg.name
  revision_mode                = "Single"

  template {
    min_replicas = 1
    max_replicas = 1

    container {
      name   = "redis"
      image  = "redis/redis-stack:latest"
      cpu    = 0.5
      memory = "1Gi"

      env {
        name  = "REDIS_PASSWORD"
        value = "@Aa123456789"
      }
    }
  }

  ingress {
    external_enabled = true
    exposed_port     = 6379
    target_port      = 6379
    transport        = "tcp"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}
