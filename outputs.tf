#######################################################################
## Output
#######################################################################
output "arm_output_vm_username" {
  value = jsondecode(azurerm_resource_group_template_deployment.trusted_vm_arm[0].output_content).adminUsername.value
}