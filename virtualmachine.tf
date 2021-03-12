#######################################################################
## Create Network Interface - AADC VM
#######################################################################

resource "azurerm_network_interface" "addc_vm_nic" {
  name                 = "addc-vm-nic"
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  enable_ip_forwarding = false

  ip_configuration {
    name                          = "addc-vm-ipconfig"
    subnet_id                     = azurerm_subnet.services_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
  tags = var.tags
}

#######################################################################
## Create AD DC Virtual Machine in Spoke
#######################################################################
resource "azurerm_windows_virtual_machine" "addc_vm" {
  name                  = "addc-vm"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.addc_vm_nic.id]
  size                  = var.vmsize
  computer_name         = "spoke-vm"
  admin_username        = var.username
  admin_password        = var.password
  provision_vm_agent    = true

  source_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_disk {
    name                 = "addc-vm-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
}

resource "azurerm_managed_disk" "addc_vm_data_disk" {
  name                 = "addc-vm-data-disk"
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  disk_size_gb         = "10"
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  tags                 = var.tags

}

resource "azurerm_virtual_machine_data_disk_attachment" "addc_vm-disk-attach" {
  managed_disk_id    = azurerm_managed_disk.addc_vm_data_disk.id
  virtual_machine_id = azurerm_virtual_machine.addc_vm.id
  lun                = "10"
  caching            = "ReadWrite"
}

##########################################################
## Promote VM to Domain Controller
##########################################################
resource "azurerm_virtual_machine_extension" "install-addc-vm" {

  name                 = "install-aadc-vm1"
  virtual_machine_id   = azurerm_windows_virtual_machine.addc_vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  settings = <<SETTINGS
    {
        "commandToExecute":"powershell -ExecutionPolicy Unrestricted -File win-ad-dc.ps1",
        "fileUris":["https://gist.githubusercontent.com/mattweale/4cec671f1b003168b9a89f9f6fa55306/raw/2312bab2ee03396e5f15cd1c303bf0cf6eb12b38/win-ad-dc.ps1"] 
    }
SETTINGS

}