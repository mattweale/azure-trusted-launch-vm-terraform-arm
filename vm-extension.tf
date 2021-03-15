##########################################################
## Initialise Disk, Build DC and Add Tools
##########################################################
resource "azurerm_virtual_machine_extension" "install-addc-vm" {

  name                 = "install-aadc-vm"
  virtual_machine_id   = azurerm_windows_virtual_machine.addc_vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
        "commandToExecute":"powershell -ExecutionPolicy RemoteSigned -File vm-data-disk-init.ps1 > ./logfile.txt",
        "fileUris":["https://gist.githubusercontent.com/mattweale/9f086ae08fc1987fcc462e2cdba060ce/raw/0527d4c87930efb22141088ed822ebf8f60d1607/vm-data-disk-init.ps1",
                    "https://gist.githubusercontent.com/mattweale/4cec671f1b003168b9a89f9f6fa55306/raw/48881a3aab1909fc6de55d48372794ed86a185eb/win-ad-dc.ps1"] 
    }
SETTINGS

  tags = var.tags

}