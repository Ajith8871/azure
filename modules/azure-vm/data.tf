data "azurerm_subnet" "main" {
  name                 = "${var.subnet_name}"
  virtual_network_name = "${var.subnet_vnet_name}"
  resource_group_name  = "${var.subnet_rg_name}"
}
