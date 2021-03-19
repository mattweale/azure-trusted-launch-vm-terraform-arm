#######################################################################
## Create Spoke vNET
#######################################################################
resource "azurerm_virtual_network" "spoke_vnet" {
  name                = "${var.prefix}spoke-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  address_space       = ["172.17.0.0/16"]

  tags = var.tags
}

#######################################################################
## Create Bastion Subnet in Spoke
#######################################################################
resource "azurerm_subnet" "spoke_bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.spoke_vnet.name
  address_prefixes     = ["172.17.1.0/24"]
}

#######################################################################
## Create Subnet in Spoke
#######################################################################
resource "azurerm_subnet" "spoke_subnet" {
  name                 = "${var.prefix}spoke-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.spoke_vnet.name
  address_prefixes     = ["172.17.2.0/24"]
}

#######################################################################
## Create a VNet Peer between Spoke and Hub
#######################################################################
resource "azurerm_virtual_network_peering" "spoke_to_hub_peer" {
  name                         = "${var.prefix}spoke-to-hub-peer"
  resource_group_name          = azurerm_resource_group.rg.name
  virtual_network_name         = azurerm_virtual_network.spoke_vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.hub_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}