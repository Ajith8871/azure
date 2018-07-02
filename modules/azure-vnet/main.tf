resource "azurerm_resource_group" "main" {
  name     = "rg-${var.sdn_name}"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.sdn_name}"
  address_space       = ["${var.vnet_cidr}"]
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
}

resource "azurerm_subnet" "main" {
  name                 = "subnet-${var.sdn_name}-private"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  virtual_network_name = "${azurerm_virtual_network.main.name}"
  address_prefix       = "${var.vnet_private1_cidr}"
}
