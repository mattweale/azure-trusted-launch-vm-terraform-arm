#######################################################################
## Create Spoke vNET
#######################################################################
resource "azurerm_virtual_network" "spoke_vnet" {
  name                = "${var.prefix}spoke-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  address_space       = ["172.17.0.0/16"]
  tags                = var.tags
}

#######################################################################
## Create Subnet in Spoke for Backend VMs
#######################################################################
resource "azurerm_subnet" "subnet_be" {
  name                 = "back-end-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.spoke_vnet.name
  address_prefixes     = ["172.17.1.0/24"]
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

#######################################################################
## Create NSG [and Associate] for Spoke Subnet
#######################################################################
resource "azurerm_network_security_group" "nsg_spoke" {
  name                = "${var.prefix}-spoke-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "rdp-in-a"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "3389"
    destination_port_range     = "3389"
    source_address_prefix      = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
    destination_address_prefix = azurerm_network_interface.addc_vm_nic.private_ip_address
  }
  security_rule {
    name                       = "rdp-in-b"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "3389"
    destination_port_range     = "3389"
    source_address_prefix      = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
    destination_address_prefix = azurerm_network_interface.addc_vm_nic.private_ip_address
  }
  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "assoc_nsg_spoke_subnet" {
  subnet_id                 = azurerm_subnet.subnet_be.id
  network_security_group_id = azurerm_network_security_group.nsg_spoke.id
}

#######################################################################
## Create route table for Spoke default route
#######################################################################
resource "azurerm_route_table" "local_default_route_table" {
  name                          = "${var.prefix}spoke-default-route-table"
  location                      = var.location
  resource_group_name           = azurerm_resource_group.rg.name
  disable_bgp_route_propagation = false

  route {
    name                   = "default"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  }
  tags = var.tags
}