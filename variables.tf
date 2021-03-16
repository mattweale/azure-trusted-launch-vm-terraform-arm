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
variable "vmsize" {
  description = "Size of the VMs"
  default     = "Standard_D2s_v4"
}