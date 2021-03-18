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
  default     = "tf-hub-spoke-"
}
variable "tags" {
  type        = map(any)
  description = "Tags to be attached to azure resources"
}
variable "username" {
  description = "Username for Virtual Machines"
  type        = string
  default     = "adminuser"
}
variable "password" {
  description = "Virtual Machine password, must meet Azure complexity requirements"
  type        = string
  default     = "Pa55w0rd123!"
}
#######################################################################
## Initialise variables for ARM Template
#######################################################################
variable "vmName" {
  type        = string
  description = "Name of Virtual Machine"
}
variable "sku" {
  type        = string
  description = "VM SKU"
}
variable "vmsize" {
  type        = string
  description = "Size of the VM"
}
variable "username" {
  description = "Username for Virtual Machines"
  type        = string
}
variable "password" {
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
variable "enableHotpatching" {
  description = "Secure Boot Setting of the VM"
  type        = bool
}
variable "secureBoot" {
  description = "Secure Boot Setting of the VM"
  type        = bool
}
variable "vTPM" {
  description = "vTPM Setting of the VM"
  type        = bool
}