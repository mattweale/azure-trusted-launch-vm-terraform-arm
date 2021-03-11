#######################################################################
## Create Bastion in Hub
#######################################################################
resource "azurerm_public_ip" "bastion-hub-pip" {
  name                = "${var.prefix}bastion"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion-spoke-1" {
  name                = "bastion-spoke-1"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                 = "bastion-hub-configuration"
    subnet_id            = azurerm_subnet.bastion_hub_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion-hub-pip.id
  }
}