#######################################################################
## Initialise variables
#######################################################################
variable "arm_tenant_id" {
  description = "Tenant ID"
  type        = string
}
variable "arm_subscription_id" {
  description = "Subscrption ID"
  type        = string
}
variable "arm_client_id" {
  description = "Service Principal client id"
  type        = string
}
variable "location" {
  description = "Region"
  type        = string
  default     = "North Europe"
}
variable "prefix" {
  description = "Default Naming Prefix"
  type        = string
  default     = "tf-trusted-vm-arm-"
}
variable "tags" {
  type        = map(any)
  description = "Tags to be attached to azure resources"
}
#######################################################################
## Initialise variables for ARM Template
#######################################################################
variable "virtualMachineName" {
  type        = string
  description = "Name of Virtual Machine"
}
variable "sku" {
  type        = string
  description = "VM SKU"
}
variable "virtualMachineSize" {
  type        = string
  description = "Size of the VM"
}
variable "virtualMachineComputerName" {
  type        = string
  description = "Computer Name of the VM"
}
variable "adminUsername" {
  description = "Username for Virtual Machines"
  type        = string
}
variable "adminPassword" {
  description = "Virtual Machine password, must meet Azure complexity requirements"
  type        = string
}
variable "networkInterfaceName" {
  description = "Name of the network interface"
  type        = string
}
variable "osDiskType" {
  description = "Operating System Disk Type"
  type        = string
}
variable "patchMode" {
  description = "Patch Mode for VM"
  type        = string
}
