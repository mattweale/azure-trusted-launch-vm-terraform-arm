#######################################################################
## Create Resource Group
#######################################################################
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}rg"
  location = var.location
  tags     = var.tags
}

#######################################################################
## Deploy ARM Template - Important to Set Deployment Mode to Incremental
#######################################################################
resource "azurerm_template_deployment" "trusted_vm_arm" {
  count               = 1
  name                = "${var.prefix}trusted-vm-deployment"
  resource_group_name = azurerm_resource_group.rg.name

  depends_on = azurerm_subnet.spoke_subnet

  template_body = file("./templates/vm-template.json")

  parameters = {
    vmName            = var.vmName
    sku               = var.sku
    vmsize            = var.vmsize
    username          = var.username
    password          = var.password
    patchMode         = var.patchMode
    enableHotpatching = var.enableHotpatching
    virtualMachineRG  = azurerm_resource_group.rg.name
    virtualNetworkID  = azurerm_virtual_network.spoke_vnet.name
    subnetName        = azurerm_subnet.spoke_subnet.name

  }

  deployment_mode = "Incremental"
}