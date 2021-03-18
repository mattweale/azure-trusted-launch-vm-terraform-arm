#######################################################################
## Populate initialised variables if using shell env or use az login
#######################################################################
arm_tenant_id       = "4473285a-1571-4a3a-9ea0-cc9b2ed0e065"
arm_subscription_id = "af4dd953-c105-4bf5-adbd-28fa92519630"
arm_client_id       = "864116c8-4e14-4019-8cc2-82dc13a1a85f"
arm_cliend_secret   = "sFa4TM7xF8X-QiuVf_4N2VEOPOFlzu2~SR"

tags = {
  "environment" = "dev-test"
  "purpose"     = "hub-spoke"
  "createdby"   = "terraform"
}

#######################################################################
## Populate initialised variables for ARM Template
#######################################################################
vmName               = "TrustedLaunch-VM"
sku                  = "20h2-ent-g2"
vmsize               = "Standard_D2s_v4"
username             = "adminuser"
password             = "Pa55w0rd123!"
networkInterfaceName = "vm-nic"
osDiskType           = "Premium_LRS"
secureBoot           = "true"
vTPM                 = "true"
patchMode            = "Manual"
enableHotpatching    = "false"