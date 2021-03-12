##########################################################
## Promote VM to Domain Controller
##########################################################
resource "azurerm_virtual_machine_extension" "install-addc-vm" {

  name                 = "install-aadc-vm1"
  virtual_machine_id   = azurerm_windows_virtual_machine.addc_vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  settings = <<SETTINGS
    {
        "commandToExecute":"powershell -ExecutionPolicy Unrestricted -File win-ad-dc.ps1",
        "fileUris":["https://gist.githubusercontent.com/mattweale/4cec671f1b003168b9a89f9f6fa55306/raw/2312bab2ee03396e5f15cd1c303bf0cf6eb12b38/win-ad-dc.ps1"] 
    }
SETTINGS

}