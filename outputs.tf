# Outputs
output "hub_firewall_public_ip_address" {
  value       = azurerm_public_ip.fw_pip.ip_address
  description = "The public IP address of the firewall"
}

output "vm1_private_ip_address" {
  value       = azurerm_windows_virtual_machine.addc_vm.private_ip_address
  description = "The private IP address of AD Domain Controller"
}