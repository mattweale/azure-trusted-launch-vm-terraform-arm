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
resource "azurerm_resource_group_template_deployment" "trusted_vm_arm" {
  count               = 1
  name                = "${var.prefix}trusted-vm-deployment"
  resource_group_name = azurerm_resource_group.rg.name

  depends_on = [azurerm_subnet.spoke_subnet]

  template_content = file("./templates/vm-template.json")

  parameters_content = jsonencode({
    location                   = { value = var.location }
    virtualMachineName         = { value = var.virtualMachineName }
    sku                        = { value = var.sku }
    virtualMachineSize         = { value = var.virtualMachineSize }
    virtualMachineComputerName = { value = var.virtualMachineComputerName }
    networkInterfaceName       = { value = var.networkInterfaceName }
    osDiskType                 = { value = var.osDiskType }
    adminUsername              = { value = var.adminUsername }
    adminPassword              = { value = var.adminPassword }
    patchMode                  = { value = var.patchMode }
    virtualNetworkID           = { value = azurerm_virtual_network.spoke_vnet.name }
    subnetName                 = { value = azurerm_subnet.spoke_subnet.name }
  })

  deployment_mode = "Incremental"

}

output "arm_example_output" {
  value = jsondecode(azurerm_resource_group_template_deployment.trusted_vm_arm[0].output_content).adminUsername.value
}