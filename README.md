# **Deploy and Azure VM configured with Trusted Launch [Secure Boot and vTPM]**

# Contents
[Overview](#overview)


[Deployment](#deployment)

# Overview

This Terraform module deploys a Hub and Spoke vNET connected with vNET Peering. Bastion sits in the Spoke along with alog with a D2s_v4 VM with Trust Launch [Secure Boot and vTPM].

A .tfvars file is used set variables, these are then passed to the ARM Template. the jsonencode function is used to encode the variables to a string using JSON syntax before passing to the ARM Template.

Some useful documentation:

Terraform AzureRM Resource Group Template Deployment [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_template_deployment).

Azure Trusted Launch [documentation](https://docs.microsoft.com/en-gb/azure/virtual-machines/trusted-launch).


Note that this will store state locally so a backend block with need to be added if required.

# Deployment

Steps:
- Log in to Azure Cloud Shell at https://shell.azure.com/ and select Bash
- Ensure Azure CLI and extensions are up to date:
  
  `az upgrade --yes`
  
- If necessary select your target subscription:
  
  `az account set --subscription <Name or ID of subscription>`
  
- Clone the  GitHub repository:
  
  `git clone https://github.com/mattweale/azure-trusted-launchvm-terraform-arm`
  
  - Change directory:
  
  `cd ./azure-trusted-launchvm-terraform-arm`
  - Initialize terraform and download the azurerm resource provider:

  `terraform init`

- Now start the deployment (when prompted, confirm with **yes** to start the deployment):
 
  `terraform apply`

Deployment takes approximately 10 minutes.

## Explore and verify

After the Terraform deployment concludes successfully, the following has been deployed into your subscription:
- A resource group named **tf-trusted-vm-arm-rg** containing:
  - One Hub vNET.
  - One Spoke vNET containing one Virtual Machine with Windows 10 Enterprise Edition with Secure Boot enabled and a Bastion.

Verify these resources are present in the portal.

Credentials for the VM are:
- User name: adminuser
- Password: Pa55w0rd123!

You can only connect to the VM via Bastion.

- Validate that secure boot is running on Windows by running msinfo32.exe

## Delete all resources

Delete the tf-hub-spoke-addc-rg resource group. This may take up to 20 minutes to complete. Check back to verify that all resources have indeed been deleted.

In Cloud Shell, delete the azure-hub-spoke-app-gateway directory:

`rm -rf azure-azure-trusted-launchvm-terraform-arm`
