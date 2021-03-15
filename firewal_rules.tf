#######################################################################
## Default deny to improve logging verbosity
#######################################################################
resource "azurerm_firewall_network_rule_collection" "network_rule" {
  name                = "${var.prefix}network-rule"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = azurerm_resource_group.rg.name
  priority            = 6500
  action              = "Deny"

  rule {
    name                  = "Deny_All"
    source_addresses      = ["*"]
    destination_ports     = ["*"]
    destination_addresses = ["*"]
    protocols             = ["TCP", "UDP"]
  }
}

#######################################################################
## Create Network Rules where Service Tags are supported
#######################################################################
resource "azurerm_firewall_network_rule_collection" "wvd_net_rule_coll" {
  name                = "wvd-net-rule-coll"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = azurerm_resource_group.rg.name
  priority            = 100
  action              = "Allow"

  rule {
    name                  = "wvd-service"
    source_addresses      = ["172.17.0.0/16"]
    destination_ports     = ["*", ]
    destination_addresses = ["WindowsVirtualDesktop", ]
    protocols = [
      "TCP",
      "UDP",
    ]
  }
  rule {
    name                  = "azure-cloud"
    source_addresses      = ["172.17.0.0/16"]
    destination_ports     = ["*", ]
    destination_addresses = ["AzureCloud", ]
    protocols = [
      "TCP",
      "UDP",
    ]
  }

}
#######################################################################
## Create Application Rules for everything else
#######################################################################
resource "azurerm_firewall_application_rule_collection" "wvd_app_rule_coll" {
  name                = "wvd-net-rule-coll"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = azurerm_resource_group.rg.name
  priority            = 200
  action              = "Allow"

  rule {
    name             = "windows-activiation"
    source_addresses = ["172.17.0.0/16"]
    target_fqdns     = ["kms.core.windows.net"]
    protocol {
      port = "443"
      type = "Https"
    }
  }
  rule {
    name             = "ms-online-services"
    source_addresses = ["172.17.0.0/16"]
    target_fqdns     = ["*.microsoftonline.com"]
    protocol {
      port = "443"
      type = "Https"
    }
  }
  rule {
    name             = "windows-telemtry"
    source_addresses = ["172.17.0.0/16"]
    target_fqdns     = ["*.events.data.microsoft.com"]
    protocol {
      port = "443"
      type = "Https"
    }
  }
  rule {
    name             = "connect-test"
    source_addresses = ["172.17.0.0/16"]
    target_fqdns     = ["www.msftconnecttest.com"]
    protocol {
      port = "443"
      type = "Https"
    }
  }
  rule {
    name             = "windows-update"
    source_addresses = ["172.17.0.0/16"]
    target_fqdns     = ["*.prod.do.dsp.mp.microsoft.com"]
    protocol {
      port = "443"
      type = "Https"
    }
  }
  rule {
    name             = "windows-online-login"
    source_addresses = ["172.17.0.0/16"]
    target_fqdns     = ["login.windows.net"]
    protocol {
      port = "443"
      type = "Https"
    }
  }
  rule {
    name             = "onedrive-login"
    source_addresses = ["172.17.0.0/16"]
    target_fqdns     = ["*.sfx.ms"]
    protocol {
      port = "443"
      type = "Https"
    }
  }
  rule {
    name             = "crl-check"
    source_addresses = ["172.17.0.0/16"]
    target_fqdns     = ["*.digicert.com"]
    protocol {
      port = "443"
      type = "Https"
    }
  }
}
#######################################################################
## Create Network Rule for WVD Host Outbound Internet Access
#######################################################################
resource "azurerm_firewall_network_rule_collection" "wvd_outbound_rule" {
  name                = "${var.prefix}wvd-outbound-rule"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = azurerm_resource_group.rg.name
  priority            = 300
  action              = "Allow"

  rule {
    name = "Outbound"

    source_addresses = ["172.17.1.0/24",
    ]

    destination_ports = [
      "*",
    ]

    destination_addresses = [
      "*"
    ]

    protocols = [
      "Any"
    ]
  }
}

#######################################################################
## Create Network Rule for Services Subnet Outbound
#######################################################################
resource "azurerm_firewall_network_rule_collection" "services_outbound_rule" {
  name                = "${var.prefix}services-outbound-rule"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = azurerm_resource_group.rg.name
  priority            = 400
  action              = "Allow"

  rule {
    name = "Outbound"

    source_addresses = ["172.16.3.0/24",
    ]

    destination_ports = [
      "*",
    ]

    destination_addresses = [
      "*"
    ]

    protocols = [
      "Any"
    ]
  }
}