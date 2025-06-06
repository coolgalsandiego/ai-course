resource "azurerm_network_interface" "nic-vm-windows" {
  name                = "nic-vm-windows"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.snet-jumpbox.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = null
  }
}

resource "azurerm_windows_virtual_machine" "vm-windows" {
  name                  = "vm-windows11"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_D2ads_v5" # "Standard_B2ats_v2" "Standard_D2pds_v6"
  priority              = "Spot"
  eviction_policy       = "Deallocate"
  admin_username        = "azureuser"
  admin_password        = "@Aa123456789"
  network_interface_ids = [azurerm_network_interface.nic-vm-windows.id]

  os_disk {
    name                 = "os-disk-vm"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-24h2-pro"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = null
  }

  lifecycle {
    ignore_changes = [identity]
  }
}
